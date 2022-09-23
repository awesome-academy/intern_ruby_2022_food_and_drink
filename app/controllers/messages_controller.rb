class MessagesController < ApplicationController
  skip_before_action :is_admin?
  before_action :authenticate_user!

  def new
    @message = current_user.messages.new
  end

  def create
    @message = current_user.messages.new message_params
    if @room.save
      flash[:success] = "Room is created"
      redirect_to root_url
    else
      flash.now[:danger] = "Something wrong"
      render :new
    end
  end

  private

  def message_params
    params.require(:message).permit :name
  end
end
