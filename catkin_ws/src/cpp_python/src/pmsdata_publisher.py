#! /usr/bin/env python

import RPi_I2C_driver
from time import *
import time
import Adafruit_DHT
import serial
import struct
import RPi.GPIO as GPIO

############################################################################################
import rospy
from cpp_python.msg import TopicMsg	#pakage name : cpp_python <----should be corrected.
					#message name : TopicMsg
############################################################################################

class PMS7003(object):

  # PMS7003 protocol data (HEADER 2byte + 30byte)
  PMS_7003_PROTOCOL_SIZE = 32

  # PMS7003 data list
  HEADER_HIGH            = 0  # 0x42
  HEADER_LOW             = 1  # 0x4d
  FRAME_LENGTH           = 2  # 2x13+2(data+check bytes) 
  DUST_PM1_0_CF1         = 3  # PM1.0 concentration unit μ g/m3（CF=1，standard particle）
  DUST_PM2_5_CF1         = 4  # PM2.5 concentration unit μ g/m3（CF=1，standard particle）
  DUST_PM10_0_CF1        = 5  # PM10 concentration unit μ g/m3（CF=1，standard particle）
  DUST_PM1_0_ATM         = 6  # PM1.0 concentration unit μ g/m3（under atmospheric environment）
  DUST_PM2_5_ATM         = 7  # PM2.5 concentration unit μ g/m3（under atmospheric environment）
  DUST_PM10_0_ATM        = 8  # PM10 concentration unit μ g/m3  (under atmospheric environment) 
  DUST_AIR_0_3           = 9  # indicates the number of particles with diameter beyond 0.3 um in 0.1 L of air. 
  DUST_AIR_0_5           = 10 # indicates the number of particles with diameter beyond 0.5 um in 0.1 L of air. 
  DUST_AIR_1_0           = 11 # indicates the number of particles with diameter beyond 1.0 um in 0.1 L of air. 
  DUST_AIR_2_5           = 12 # indicates the number of particles with diameter beyond 2.5 um in 0.1 L of air. 
  DUST_AIR_5_0           = 13 # indicates the number of particles with diameter beyond 5.0 um in 0.1 L of air. 
  DUST_AIR_10_0          = 14 # indicates the number of particles with diameter beyond 10 um in 0.1 L of air. 
  RESERVEDF              = 15 # Data13 Reserved high 8 bits
  RESERVEDB              = 16 # Data13 Reserved low 8 bits
  CHECKSUM               = 17 # Checksum code


  # header check 
  def header_chk(self, buffer):

    if (buffer[self.HEADER_HIGH] == 66 and buffer[self.HEADER_LOW] == 77):
      return True

    else:
      return False

  # chksum value calculation
  def chksum_cal(self, buffer):

    buffer = buffer[0:self.PMS_7003_PROTOCOL_SIZE]

    # data unpack (Byte -> Tuple (30 x unsigned char <B> + unsigned short <H>))
    chksum_data = struct.unpack('!30BH', buffer)
    
    chksum = 0

    for i in range(30):
      chksum = chksum + chksum_data[i]

    return chksum

  # checksum check
  def chksum_chk(self, buffer):   
    
    chk_result = self.chksum_cal(buffer)
    
    chksum_buffer = buffer[30:self.PMS_7003_PROTOCOL_SIZE]
    chksum = struct.unpack('!H', chksum_buffer)
    
    if (chk_result == chksum[0]):
      return True

    else:
      return False

  # protocol size(small) check
  def protocol_size_chk(self, buffer):

    if(self.PMS_7003_PROTOCOL_SIZE <= len(buffer)):
      return True

    else:
      return False

  # protocol check
  def protocol_chk(self, buffer):
    
    if(self.protocol_size_chk(buffer)):
      
      if(self.header_chk(buffer)):
        
        if(self.chksum_chk(buffer)):
          
          return True
        else:
          print("Chksum err")
      else:
        print("Header err")
    else:
      print("Protol err")

    return False 

  # unpack data 
  # <Tuple (13 x unsigned short <H> + 2 x unsigned char <B> + unsigned short <H>)>
  def unpack_data(self, buffer):
    
    buffer = buffer[0:self.PMS_7003_PROTOCOL_SIZE]

    # data unpack (Byte -> Tuple (13 x unsigned short <H> + 2 x unsigned char <B> + unsigned short <H>))
    data = struct.unpack('!2B13H2BH', buffer)

    return data


  def print_serial(self, buffer):
    
    chksum = self.chksum_cal(buffer)
    data = self.unpack_data(buffer)

    print ("============================================================================")
    print ("Header : %c %c \t\t | Frame length : %s" % (data[self.HEADER_HIGH], data[self.HEADER_LOW], data[self.FRAME_LENGTH]))
    print ("PM 10.0 (CF=1) : %s\t | PM 10.0 : %s" % (data[self.DUST_PM10_0_CF1], data[self.DUST_PM10_0_ATM]))
    print ("10.0um in 0.1L of air : %s" % (data[self.DUST_AIR_10_0]))
    print ("Reserved F : %s | Reserved B : %s" % (data[self.RESERVEDF],data[self.RESERVEDB]))
    print ("CHKSUM : %s | read CHKSUM : %s | CHKSUM result : %s" % (chksum, data[self.CHECKSUM], chksum == data[self.CHECKSUM]))
    print ("============================================================================")


  def get_pmsdata(self, buffer):
    
    chksum = self.chksum_cal(buffer)
    data = self.unpack_data(buffer)
    return data[self.DUST_PM10_0_CF1]



# UART / USB Serial : 'dmesg | grep ttyUSB'
USB0 = '/dev/ttyUSB1'
UART = '/dev/ttyAMA0'

# USE PORT
SERIAL_PORT = USB0

# Baud Rate
Speed = 9600

# example

mylcd = RPi_I2C_driver.lcd(0x27)
sensor = Adafruit_DHT.DHT11
pin = 24
GPIO.setmode(GPIO.BCM)
rpin = 13

# The output pins will be declared, which are connected with the LEDs. 
LED_Red = 17
LED_Green = 18
LED_Blue = 22
 
if __name__=='__main__':


  #serial setting 
  ser = serial.Serial(SERIAL_PORT, Speed, timeout = 1)

  dust = PMS7003()
      
  x=True                 
  try:
    while x:
      h, t = Adafruit_DHT.read_retry(sensor, pin)
      if h is not None and t is not None :
        mylcd.setCursor(0,0)
        print("Temperature = {0:0.1f}*C Humidity = {1:0.1f}%".format(t, h))
        mylcd.print("{0:0.1f} C {1:0.1f} %".format(t, h))      
      else :
        print('Read error')

      ser.flushInput()
      buffer = ser.read(1024)

      if(dust.protocol_chk(buffer)):
    
        print("DATA read success")
    
        # print data
        dust.print_serial(buffer)
        pmsdata=int(dust.get_pmsdata(buffer))
        print("%d " %pmsdata)
        mylcd.setCursor(0,1)
        mylcd.print("dust=%d "%pmsdata)
      
        GPIO.setup(LED_Red, GPIO.OUT, initial= GPIO.LOW)
        GPIO.setup(LED_Green, GPIO.OUT, initial= GPIO.LOW)
        GPIO.setup(LED_Blue, GPIO.OUT, initial= GPIO.LOW)
        GPIO.setup(rpin,GPIO.OUT)

        GPIO.output(rpin,True)
      
        if(pmsdata<31):
          GPIO.output(LED_Red,GPIO.LOW) #LED will be switched off
          GPIO.output(LED_Green,GPIO.LOW) #LED will be switched off
          GPIO.output(LED_Blue,GPIO.HIGH) #LED will be switched on
  
        elif(pmsdata<81):
          GPIO.output(LED_Red,GPIO.LOW) #LED will be switched off
          GPIO.output(LED_Green,GPIO.HIGH) #LED will be switched on
          GPIO.output(LED_Blue,GPIO.LOW) #LED will be switched off

        elif(pmsdata<151):
          GPIO.output(LED_Red,GPIO.HIGH) #LED will be switched on
          GPIO.output(LED_Green,GPIO.HIGH) #LED will be switched on
          GPIO.output(LED_Blue,GPIO.LOW) #LED will be switched off

        elif(pmsdata>=151):
          GPIO.output(LED_Red,GPIO.HIGH) #LED will be switched on
          GPIO.output(LED_Green,GPIO.LOW) #LED will be switched off
          GPIO.output(LED_Blue,GPIO.LOW) #LED will be switched off
        

        time.sleep(1)
      
#############################################################################################
        #publisher node
        
    
        rospy.init_node('pmsdata_publisher') #create a node to run the publisher
	               		             #node name : pmsdata_publisher

        pub=rospy.Publisher('pmsdata', TopicMsg, queue_size=10) #topic name : pmsdata
							        #message file name : TopicMsg.msg

        rate=rospy.Rate(1) #create a rate (per second) for publishing
        msg=TopicMsg()
        msg.pmsdata=pmsdata #should be corrected.

        pub.publish(msg)
        rate.sleep()

###############################################################################################


      else:
        print("DATA read fail...")

         

  except KeyboardInterrupt:
    print("Terminated by Keyboard")

##################################################
#  except rospy.ROSInterruptException : pass
##################################################

  finally:
    x=False
    print("End of Program")
    GPIO.cleanup()
    ser.close() 
