class ApplicationController < ActionController::Base
  include Pagy::Backend
  protect_from_forgery with: :exception

  before_action :set_locale
  before_action :current_cart

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
end
