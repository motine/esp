const app = new Vue({
  el: "#app",
  data() {
    // TODO retrieve this from the device
    return { devices: [] }
  },
  methods: {
    loadDevices(hosts) {
      for (const host of hosts) {
        fetch(`http://${host}/moha/v1/`)
          .then(data => data.json())
          .then(json => this.devices.push({ host: host, config: json.device, skills: json.skills }));
      }
    }
  },
  mounted() {
    fetch("../config.json")
      .then(data => data.json())
      .then(json => this.loadDevices(json.device_hosts))
  }
})
