
SKILL_TYPE_TO_COMPONENT_NAME = {
  "switch": "actor-switch"
}

Vue.component('device', {
  props: {
    config: { type: Object, required: true },
    skills: { type: Array, required: true }
  },
  template: `
    <div class="device">
      <component v-for="(skill, index) in skills" v-bind:is="skillComponent(index)" :key="skill.uuid" :config="skill"></component>
    </div>
    `,
  data() {
    return { }
  },
  methods: {
    skillComponent(index) {
      const retrievedName = this.skills[index].type;
      const mappedName = SKILL_TYPE_TO_COMPONENT_NAME[retrievedName]
      if (mappedName) {
        return mappedName;
      } else {
        console.error(`Could not find mapping for the skill type retrieved from the device: ${retrievedName}`)
      }
    }
  }
})