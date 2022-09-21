class ApplicationController < ActionController::Base
  include Pagy::Backend
  protect_from_forgery with: :exception

  before_action :set_locale
  before_action :is_admin?, unless: :devise_controller?
  before_action :configure_permitted_parameters, if: :devise_controller?

  def is_admin?
    binding.pry
    return if user_signed_in? && current_user.admin?

    flash[:danger] = t "must_login"
    redirect_to root_url
  end

  protected

  def configure_permitted_parameters
    added_attrs = [:name, :phone, :email, :password, :password_confirmation, :remember_me]
    devise_parameter_sanitizer.permit :sign_up, keys: added_attrs
    devise_parameter_sanitizer.permit :account_update, keys: added_attrs
  end

  private
  def set_locale
    I18n.locale = params[:locale] || I18n.default_locale
  end

  def default_url_options
    {locale: I18n.locale}
  end

  def find_object model, id
    model.find(id)
  rescue StandardError
    template_not_found
  end

  def template_not_found
    respond_to do |format|
      format.html{render file: Rails.root.to_s << ("/public/404.html"), layout: false, status: :not_found}
      format.xml{head :not_found}
      format.any{head :not_found}
    end
  end

  rescue_from CanCan::AccessDenied do |exception|
    respond_to do |format|
      format.json{head :forbidden}
      format.html{redirect_to admin_home_index_path, alert: exception.message}
    end
  end

  def current_ability
    @current_ability ||= Ability.new(current_user)
  end
end
