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
      return SkillRegistry.componentNameFor(this.skills[index].type);
    }
  }
})