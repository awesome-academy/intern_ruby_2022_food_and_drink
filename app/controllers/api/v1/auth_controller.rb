class Api::V1::AuthController < Api::V1::BaseApiController
  skip_before_action :verify_authenticity_token, :authenticate, :is_admin?

  def login
    user = User.find_by(email: user_params[:email].downcase)
    if user&.valid_password?(user_params[:password])
      token = Auth.issue({id: user.id, name: user.name})
      render json: {user: user.attributes, token: token}
    else
      failure
    end
  end

  private

  def failure
    render status: :unauthorized, json: {message: I18n.t("login_fail"), data: {}}
  end

  def user_params
    params.require(:user).permit(:email, :password)
  end
end
