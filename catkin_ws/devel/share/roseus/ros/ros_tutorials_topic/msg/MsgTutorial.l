;; Auto-generated. Do not edit!


(when (boundp 'ros_tutorials_topic::MsgTutorial)
  (if (not (find-package "ROS_TUTORIALS_TOPIC"))
    (make-package "ROS_TUTORIALS_TOPIC"))
  (shadow 'MsgTutorial (find-package "ROS_TUTORIALS_TOPIC")))
(unless (find-package "ROS_TUTORIALS_TOPIC::MSGTUTORIAL")
  (make-package "ROS_TUTORIALS_TOPIC::MSGTUTORIAL"))

(in-package "ROS")
;;//! \htmlinclude MsgTutorial.msg.html


(defclass ros_tutorials_topic::MsgTutorial
  :super ros::object
  :slots (_pmsdata ))

(defmethod ros_tutorials_topic::MsgTutorial
  (:init
   (&key
    ((:pmsdata __pmsdata) 0)
    )
   (send-super :init)
   (setq _pmsdata (round __pmsdata))
   self)
  (:pmsdata
   (&optional __pmsdata)
   (if __pmsdata (setq _pmsdata __pmsdata)) _pmsdata)
  (:serialization-length
   ()
   (+
    ;; int32 _pmsdata
    4
    ))
  (:serialize
   (&optional strm)
   (let ((s (if strm strm
              (make-string-output-stream (send self :serialization-length)))))
     ;; int32 _pmsdata
       (write-long _pmsdata s)
     ;;
     (if (null strm) (get-output-stream-string s))))
  (:deserialize
   (buf &optional (ptr- 0))
   ;; int32 _pmsdata
     (setq _pmsdata (sys::peek buf ptr- :integer)) (incf ptr- 4)
   ;;
   self)
  )

(setf (get ros_tutorials_topic::MsgTutorial :md5sum-) "6ce25d4fb844ef5878b2c0a5c88477b7")
(setf (get ros_tutorials_topic::MsgTutorial :datatype-) "ros_tutorials_topic/MsgTutorial")
(setf (get ros_tutorials_topic::MsgTutorial :definition-)
      "int32 pmsdata

")



(provide :ros_tutorials_topic/MsgTutorial "6ce25d4fb844ef5878b2c0a5c88477b7")


