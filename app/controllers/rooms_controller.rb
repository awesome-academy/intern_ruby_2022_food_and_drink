class RoomsController < ApplicationController
  layout "devise"
  skip_before_action :is_admin?
  before_action :authenticate_user!

  def index
    @rooms = Room.all
  end

  def new
    @room = current_user.rooms.new
  end

  def show
    @room = Room.find_by id: params[:id]
    @messages = @room.messages.includes(:user).order(created_at: :asc)
    ActionCable.server.broadcast "comment_channel",
                                   {message: params[:comment]}
  end

  def create
    @room = current_user.rooms.new room_params

    if @room.save
      flash[:success] = "Room is created"
      redirect_to root_url
    else
      flash.now[:danger] = "Something wrong"
      render :new
    end
  end

  private

  def room_params
    params.require(:room).permit :name
  end
end
