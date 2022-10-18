import consumer from "./consumer"

consumer.subscriptions.create("CommitChannel", {
  connected() {
    console.log("Connected to the room!");
    perform('do_something')
  },

  disconnected() {
    // Called when the subscription has been terminated by the server
  },

  received(data) {
    // Called when there's incoming data on the websocket for this channel
    console.log('received', data)
  }
});

