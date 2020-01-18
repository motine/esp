const skillBase = {
  methods: {
    // returns a promise
    request(host, path, payload = null) {
      if (payload) { console.error("PAYLOAD NOT SUPPORTED YET!"); }

      return fetch(`http://${host}${path}`)
        .then(data => data.json())
        .catch(error => console.error("ERROR on request from within a skill: ", error))
    }
  }
};
