class AuthController < ApplicationController
  include AuthHelper
  layout "auth"
  def new
    @user = User.new
    @address = @user.addresses.new
  end

  def create
    @user = User.new user_params
    if @user.save
      redirect_to root_url
    else
      flash[:danger] = t "register_fail"
      render :new
    end
  end

  def login; end

  def handle_login
    user = User.find_by(email: params[:session][:email].downcase)
    if user&.authenticate(params[:session][:password])
      log_in user
      decentralization_redirect_user user
    else
      flash.now[:danger] = t "login_fail"
      render :login
    end
  end

  def logout
    log_out if logged_in?
    redirect_to root_url
  end

  private
  def user_params
    params.require(:user).permit(
      :name, :phone, :email, :password, :password_confirmation, addresses_attributes: [:name, :types]
    )
  end
end
