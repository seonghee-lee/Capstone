#! /usr/bin/env python

import rospy # import the ros Python api
#from cpp_python.msg import InfoData, InfoDataArray # import the custom messages
#from std_msgs.msg import Int32
from cpp_python.msg import Msg

rospy.init_node('infodata_publisher_node') # create a node to run the publisher
#pub = rospy.Publisher('/infodata', InfoDataArray, queue_size=1) # create the p$
#pub = rospy.Publisher('/infodata',Int32, queue_size=10)
pub=rospy.Publisher('/infodata', Msg, queue_size=10)
rate = rospy.Rate(1) # create a rate (per second) for publishing
#infodata = InfoData() # create the infodata message
#infodata_array = InfoDataArray() # create the infodata array
# set the variables of the info data message
#infodata.num = 5
#infodata.color = 'red'
#infodata.name = 'data1'
#count = 3
msg=Msg()
msg.pmsdata=3

# push several infodata messages into the info data array
#for x in range(10):
#    infodata_array.infos.append(infodata)

# continously publish the infodata array at the rate specified
# until someone stops the node
while not rospy.is_shutdown():
  pub.publish(msg)
  rate.sleep()
