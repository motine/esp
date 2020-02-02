
SkillRegistry.registerMapping("actor-strip", "actor-strip");

// Example config:
// {
//   "uuid": "...",
//   "comment": "...",
//   "type": "actor-strip",
//   "capabilities": ["on/off", "rgb"],
//   "actions" : {
//     "status":  { "http-path": "/moha/v1/strip1/status" },
//     "on":  { "http-path": "/moha/v1/strip1/on" },
//     "off": { "http-path": "/moha/v1/strip1/off" },
//     "rgb": { "http-path": "/moha/v1/strip1/rgb" },
//   }
// }

Vue.component('actor-strip', {
  mixins: [skillBase],
  props: {
    host: { type: String, required: true },
    config: { type: Object, required: true }
  },
  template: `
    <div class="actor-strip" :title="config.comment">
      <input v-model="r" type="number" min="0" max="255" @input="updateColor()"/>
      <input v-model="g" type="number" min="0" max="255" @input="updateColor()"/>
      <input v-model="b" type="number" min="0" max="255" @input="updateColor()"/>
    </div>`,
  data() {
    return {
      r: 0, g: 0, b: 0
    };
  },
  mounted() {
    this.readStatus();
  },
  methods: {
    readStatus() {
      this.request(this.host, this.config.actions.status["http-path"], null)
        .then( (json) => { this.r = json.r; this.g = json.g; this.b = json.b; } );
    },
    updateColor() {
      if (isNaN(this.r) || isNaN(this.g) || isNaN(this.b)) { return; }
      const baseURL = this.config.actions.rgb["http-path"];
      const url = `${baseURL}?r=${this.r}&g=${this.g}&b=${this.b}`;
      this.request(this.host, url, null);
    }
  }
})
