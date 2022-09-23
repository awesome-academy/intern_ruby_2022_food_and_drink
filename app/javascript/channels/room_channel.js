import consumer from "./consumer"
$(document).ready(function () {
  var roomId = $('#messages').attr('room_id');
  let app = consumer.subscriptions.create({ channel: "RoomChannel", room_id: roomId }, {
    connected: function () { },
    disconnected: function () { },
    received: function (data) {
      var msg;
      if ($('#messages').attr('current_user') != data.user_id) {
        $("#messages").append(`<div class="direct-chat-msg" >
          <div class="direct-chat-infos clearfix">
            <span class="direct-chat-name float-left">${data.user_name}</span>
          </div>
          <img class="direct-chat-img" src="https://ptetutorials.com/images/user-profile.png">
          <div class="direct-chat-text">
            ${data.message}
          </div>
        </div>`)
      }
      $("#messages").append(msg)
    },
    speak: function (message, user_id, room_id) {
      this.perform('speak', {
        message: message,
        user_id: user_id,
        room_id: room_id
      });

      var msg = `<div class="direct-chat-msg right">
        <div class="direct-chat-infos clearfix">
          <span class="direct-chat-timestamp float-left"></span>
        </div>
        <img class="direct-chat-img" src="https://ptetutorials.com/images/user-profile.png">
        <div class="direct-chat-text">
          ${message}
        </div>
      </div>`

      $("#messages").append(msg)
    }
  });

  $(document).on('keypress', '.js-message-content', function (event) {
    if (event.keyCode === 13) {
      if (!event.target.value.trim().length) {
        return 0;
      }
      app.speak(event.target.value,
        $("#user_id").val(),
        $("#messages").attr("room_id")
      );
      event.target.value = '';
      return event.preventDefault();
    }
  });
});
