
SkillRegistry.registerMapping("switch", "actor-switch");

Vue.component('actor-switch', {
  mixins: [skillBase],
  props: {
    config: { type: Object, required: true }
  },
  template: `
    <div class="actor-switch" :class="'actor-switch--' + state" :title="config.uuid">
      <a class="actor-switch__off" @click.prevent="updateState('OFF')">OFF</a>
      <a class="actor-switch__on" @click.prevent="updateState('ON')">ON</a>
    </div>
    `,
  data() {
    return {
      state: 'OFF'
    };
  },
  methods: {
    updateState(state) { // could also done via https://vuejs.org/v2/guide/computed.html#Computed-Setter
      if (state == this.state) { return; }
      response = this.sendToComponent(this.config.uuid, {
        someJSON: true,
        state: this.state.toLowerCase()
      });
      this.state = state; // TODO use response for new state
    }
    // TODO retrieve initial state
  }
})