// Auto-generated. Do not edit!

// (in-package ros_tutorials_topic.msg)


"use strict";

const _serializer = _ros_msg_utils.Serialize;
const _arraySerializer = _serializer.Array;
const _deserializer = _ros_msg_utils.Deserialize;
const _arrayDeserializer = _deserializer.Array;
const _finder = _ros_msg_utils.Find;
const _getByteLength = _ros_msg_utils.getByteLength;

//-----------------------------------------------------------

class MsgTutorial {
  constructor(initObj={}) {
    if (initObj === null) {
      // initObj === null is a special case for deserialization where we don't initialize fields
      this.pmsdata = null;
    }
    else {
      if (initObj.hasOwnProperty('pmsdata')) {
        this.pmsdata = initObj.pmsdata
      }
      else {
        this.pmsdata = 0;
      }
    }
  }

  static serialize(obj, buffer, bufferOffset) {
    // Serializes a message object of type MsgTutorial
    // Serialize message field [pmsdata]
    bufferOffset = _serializer.int32(obj.pmsdata, buffer, bufferOffset);
    return bufferOffset;
  }

  static deserialize(buffer, bufferOffset=[0]) {
    //deserializes a message object of type MsgTutorial
    let len;
    let data = new MsgTutorial(null);
    // Deserialize message field [pmsdata]
    data.pmsdata = _deserializer.int32(buffer, bufferOffset);
    return data;
  }

  static getMessageSize(object) {
    return 4;
  }

  static datatype() {
    // Returns string type for a message object
    return 'ros_tutorials_topic/MsgTutorial';
  }

  static md5sum() {
    //Returns md5sum for a message object
    return '6ce25d4fb844ef5878b2c0a5c88477b7';
  }

  static messageDefinition() {
    // Returns full string definition for message
    return `
    int32 pmsdata
    
    `;
  }

  static Resolve(msg) {
    // deep-construct a valid message object instance of whatever was passed in
    if (typeof msg !== 'object' || msg === null) {
      msg = {};
    }
    const resolved = new MsgTutorial(null);
    if (msg.pmsdata !== undefined) {
      resolved.pmsdata = msg.pmsdata;
    }
    else {
      resolved.pmsdata = 0
    }

    return resolved;
    }
};

module.exports = MsgTutorial;
