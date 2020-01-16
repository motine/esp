class Device {
  // this class shall retrieve devices in a static method and create a device object for each retrieved device
  // each device knows its components
  // we render the appropriate skill/actor component based on the type
  // the component is passed as a prop to the skill
  
  static sendToComponent(uuid, payload) { // this method will move to the component
    console.log("TODO SEND OUT!", uuid, payload);
  }
}