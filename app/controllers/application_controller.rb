class ApplicationController < ActionController::Base
  include Pagy::Backend
  include AuthHelper

  protect_from_forgery with: :exception
  skip_before_action :verify_authenticity_token

  before_action :set_locale
  before_action :current_cart

  private
  def set_locale
    I18n.locale = params[:locale] || I18n.default_locale
  end

  def default_url_options
    {locale: I18n.locale}
  end

  def current_cart
    if session[:cart_id]
      cart = Cart.find_by(id: session[:cart_id])
      if cart.present?
        @current_cart = cart
      else
        session[:cart_id] = nil
      end
    end

    return unless session[:cart_id].nil?

    @current_cart = Cart.create
    session[:cart_id] = @current_cart.id
  end

  def logged_in_user
    return if logged_in?

    flash[:danger] = t ".please_log_in"
    redirect_to auth_login_path
  end
end
