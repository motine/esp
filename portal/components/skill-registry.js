class _SkillRegistry {
  constructor() {
    this.mapping = {}
  }
  registerMapping(typeRecievedFromDevice, skillComponentName) {
    this.mapping[typeRecievedFromDevice] = skillComponentName;
  }

  componentNameFor(typeRecievedFromDevice) {
    const mappedName = this.mapping[typeRecievedFromDevice];
    if (!mappedName) {
      console.error(`Could not find mapping for the skill type retrieved from the device: ${typeRecievedFromDevice}`)
      return undefined;
    }
    return mappedName;
  }
}

const SkillRegistry = new _SkillRegistry();