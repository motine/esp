class DeviceManager {
  // this class shall retrieve devices and create a device object for each retrieved device

  // each device knows its components

  // we render the appropriate moha-component based on the type (rename actor-switch to component-switch)
  // the component is passed as a prop to the vue component
  
  static sendToComponent(uuid, payload) { // this method will move to the component
    console.log("TODO SEND OUT!", uuid, payload);
  }
}