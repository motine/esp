Vue.component('actor-switch', {
  props: {
    uuid: { type: String, required: true }
  },
  template: `
    <div class="actor-switch" :class="'actor-switch--' + state" :title="uuid">
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
      console.log("TODO UPDATE!");
      this.state = state;
    }
  }
})