
SkillRegistry.registerMapping("switch", "actor-switch");

// Example config:
// {
//   "uuid": "b82ef140-c589-49bb-81fd-7c160be2ad16",
//   "comment": "hard wired to the relay output 3",
//   "type": "switch",
//   "capabilities": ["on/off"],
//   "actions" : {
//     "status":  { "http-path": "/moha/v1/switch1/status" },
//     "on":  { "http-path": "/moha/v1/switch1/on" },
//     "off": { "http-path": "/moha/v1/switch1/off" }
//   }
// }

Vue.component('actor-switch', {
  mixins: [skillBase],
  props: {
    host: { type: String, required: true },
    config: { type: Object, required: true }
  },
  template: `
    <div class="actor-switch" :class="'actor-switch--' + status" :title="config.comment">
      <a class="actor-switch__off" @click.prevent="changeStatus('OFF')">OFF</a>
      <a class="actor-switch__on" @click.prevent="changeStatus('ON')">ON</a>
    </div>`,
  data() {
    return {
      status: 'OFF'
    };
  },
  mounted() {
    this.readStatus();
  },
  methods: {
    readStatus() {
      const response = this.request(this.host, this.config.actions.status["http-path"], null);
      this.status = response.status.toUpperCase();
    },
    changeStatus(status) { // could also done via https://vuejs.org/v2/guide/computed.html#Computed-Setter
      if (status == this.status) { return; }
      const response = this.request(this.host, this.config.actions[`${status.toLowerCase()}`]["http-path"], null);
      this.status = response.status.toUpperCase();
    }
  }
})
