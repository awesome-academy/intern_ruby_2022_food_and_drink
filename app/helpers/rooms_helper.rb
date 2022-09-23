module RoomsHelper
  def render_msg content
    "<div class='direct-chat-msg' >
    <div class='direct-chat-infos clearfix'>
      <span class='direct-chat-name float-left'>#{ User.find(content["user_id"]) }</span>
      <span class='direct-chat-timestamp float-right'><%= time_ago_in_words message.created_at %></span>
    </div>
    <img class='direct-chat-img' src='https://ptetutorials.com/images/user-profile.png'>
    <% unless message.content.blank? %>
      <div class='direct-chat-text'>
        #{content["message"]}
      </div>
    <% end %>
  </div>"
  end
end
