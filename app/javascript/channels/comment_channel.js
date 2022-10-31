import consumer from "./consumer"

consumer.subscriptions.create("CommentChannel", {
  connected() {
    // Called when the subscription is ready for use on the server
    console.log("Connected to the chat room!");
  },

  disconnected() {
    // Called when the subscription has been terminated by the server
  },

  received(data) {
    console.log(data)
    const html = this.createLine(data.content)
    $('.comments_tab').append(html);
  },

  createLine(comment) {
    return `
    <table class="comment_table">
    <col width="50">
    <col width="50">
   <col width="100">
    <tr>
      <td class = 'th_result'>${comment.created_at}</td>
      <td class = 'th_result'>${comment.body}</td>
    </tr>
  </table>
    `}
});

