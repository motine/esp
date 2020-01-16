const app = new Vue({
  el: "#app",
  data() {
    // TODO retrieve this from the device
    return { devices: [] }
  },
  methods: {
    loadFromDeviceUrls(urls) {
      // TODO use actual urls
      for (const url of urls) {
        console.log("TODO use actual URL", url)
        fetch("../tmp-response.json")
          .then(data => data.json())
          .then(json => this.devices.push(json));
      }
    }
  },
  mounted() {
    fetch("../config.json")
      .then(data => data.json())
      .then(json => this.loadFromDeviceUrls(json.device_urls))
  }
})
