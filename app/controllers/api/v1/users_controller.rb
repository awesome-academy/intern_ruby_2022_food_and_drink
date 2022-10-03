class Api::V1::UsersController < Api::V1::BaseApiController
  skip_before_action :verify_authenticity_token, :authenticate, :is_admin?, only: %i(create update destroy)
  before_action :correct_user, :find_user, only: %i(show update destroy)

  def index
    @pagy, @users = pagy User.latest_user, items: Settings.const.paginate
    render json: @users
  end

  def create
    @user = User.new user_params
    if @user.save
      token = Auth.issue({id: @user.id, name: @user.name})
      render json: {
        user: @user.attributes,
        token: token,
        message: I18n.t("success")
      }, status: :ok
    else
      render json: {
        user: @user.errors,
        message: I18n.t("fail")
      }, status: :unprocessable_entity
    end
  end

  def show
    render json: @user.attributes
  end

  def update
    if @user.update user_params
      render json: {
        user: @user.attributes,
        message: I18n.t("success")
      }
    else
      render json: {message: I18n.t("fail")}
    end
  end

  def destroy
    if @user.destroy
      render json: {
        user: @user.attributes,
        message: I18n.t("success")
      }
    else
      render json: {message: I18n.t("fail")}
    end
  end

  private

  def user_params
    params.require(:user).permit(
      :name, :phone, :email, :password, :password_confirmation
    )
  end

  def find_user
    @user = find_object User, params[:id]
  end

  def correct_user
    return if current_user.present? && (params[:id].to_i == current_user.id || is_admin?)

    render json: {error: I18n.t("unauthorized")}, status: :unauthorized
  end
end
