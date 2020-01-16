const skillBase = {
  methods: {
    request(host, path, payload = null) {
      console.log("TODO SEND OUT!", host, path, payload);
      return { status: "on" }
      // parse JSON
      // raise errors (!= 200)
    }
  }
};
