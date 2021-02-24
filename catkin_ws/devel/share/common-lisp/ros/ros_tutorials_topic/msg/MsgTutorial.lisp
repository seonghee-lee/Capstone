; Auto-generated. Do not edit!


(cl:in-package ros_tutorials_topic-msg)


;//! \htmlinclude MsgTutorial.msg.html

(cl:defclass <MsgTutorial> (roslisp-msg-protocol:ros-message)
  ((pmsdata
    :reader pmsdata
    :initarg :pmsdata
    :type cl:integer
    :initform 0))
)

(cl:defclass MsgTutorial (<MsgTutorial>)
  ())

(cl:defmethod cl:initialize-instance :after ((m <MsgTutorial>) cl:&rest args)
  (cl:declare (cl:ignorable args))
  (cl:unless (cl:typep m 'MsgTutorial)
    (roslisp-msg-protocol:msg-deprecation-warning "using old message class name ros_tutorials_topic-msg:<MsgTutorial> is deprecated: use ros_tutorials_topic-msg:MsgTutorial instead.")))

(cl:ensure-generic-function 'pmsdata-val :lambda-list '(m))
(cl:defmethod pmsdata-val ((m <MsgTutorial>))
  (roslisp-msg-protocol:msg-deprecation-warning "Using old-style slot reader ros_tutorials_topic-msg:pmsdata-val is deprecated.  Use ros_tutorials_topic-msg:pmsdata instead.")
  (pmsdata m))
(cl:defmethod roslisp-msg-protocol:serialize ((msg <MsgTutorial>) ostream)
  "Serializes a message object of type '<MsgTutorial>"
  (cl:let* ((signed (cl:slot-value msg 'pmsdata)) (unsigned (cl:if (cl:< signed 0) (cl:+ signed 4294967296) signed)))
    (cl:write-byte (cl:ldb (cl:byte 8 0) unsigned) ostream)
    (cl:write-byte (cl:ldb (cl:byte 8 8) unsigned) ostream)
    (cl:write-byte (cl:ldb (cl:byte 8 16) unsigned) ostream)
    (cl:write-byte (cl:ldb (cl:byte 8 24) unsigned) ostream)
    )
)
(cl:defmethod roslisp-msg-protocol:deserialize ((msg <MsgTutorial>) istream)
  "Deserializes a message object of type '<MsgTutorial>"
    (cl:let ((unsigned 0))
      (cl:setf (cl:ldb (cl:byte 8 0) unsigned) (cl:read-byte istream))
      (cl:setf (cl:ldb (cl:byte 8 8) unsigned) (cl:read-byte istream))
      (cl:setf (cl:ldb (cl:byte 8 16) unsigned) (cl:read-byte istream))
      (cl:setf (cl:ldb (cl:byte 8 24) unsigned) (cl:read-byte istream))
      (cl:setf (cl:slot-value msg 'pmsdata) (cl:if (cl:< unsigned 2147483648) unsigned (cl:- unsigned 4294967296))))
  msg
)
(cl:defmethod roslisp-msg-protocol:ros-datatype ((msg (cl:eql '<MsgTutorial>)))
  "Returns string type for a message object of type '<MsgTutorial>"
  "ros_tutorials_topic/MsgTutorial")
(cl:defmethod roslisp-msg-protocol:ros-datatype ((msg (cl:eql 'MsgTutorial)))
  "Returns string type for a message object of type 'MsgTutorial"
  "ros_tutorials_topic/MsgTutorial")
(cl:defmethod roslisp-msg-protocol:md5sum ((type (cl:eql '<MsgTutorial>)))
  "Returns md5sum for a message object of type '<MsgTutorial>"
  "6ce25d4fb844ef5878b2c0a5c88477b7")
(cl:defmethod roslisp-msg-protocol:md5sum ((type (cl:eql 'MsgTutorial)))
  "Returns md5sum for a message object of type 'MsgTutorial"
  "6ce25d4fb844ef5878b2c0a5c88477b7")
(cl:defmethod roslisp-msg-protocol:message-definition ((type (cl:eql '<MsgTutorial>)))
  "Returns full string definition for message of type '<MsgTutorial>"
  (cl:format cl:nil "int32 pmsdata~%~%~%"))
(cl:defmethod roslisp-msg-protocol:message-definition ((type (cl:eql 'MsgTutorial)))
  "Returns full string definition for message of type 'MsgTutorial"
  (cl:format cl:nil "int32 pmsdata~%~%~%"))
(cl:defmethod roslisp-msg-protocol:serialization-length ((msg <MsgTutorial>))
  (cl:+ 0
     4
))
(cl:defmethod roslisp-msg-protocol:ros-message-to-list ((msg <MsgTutorial>))
  "Converts a ROS message object to a list"
  (cl:list 'MsgTutorial
    (cl:cons ':pmsdata (pmsdata msg))
))
