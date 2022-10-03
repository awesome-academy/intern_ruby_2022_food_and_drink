class Api::V1::BaseApiController < ApplicationController
  include ActionController::HttpAuthentication::Token::ControllerMethods
  before_action :authenticate

  def logged_in?
    current_user
  end

  def current_user
    return unless auth_present?

    user = find_object User, auth["id"]
    @current_user ||= user if user
  end

  def authenticate
    render json: {message: I18n.t("unauthorized")}, status: :unauthorized unless logged_in?
  end

  protected

  def token
    request.env["HTTP_AUTHORIZATION"].scan(/Bearer (.*)$/).flatten.last
  end

  def auth
    Auth.decode(token)
  end

  def auth_present?
    request.env.fetch("HTTP_AUTHORIZATION", "").scan(/Bearer/).flatten.first && auth.present?
  end

  def find_object model, id
    model.find(id)
  rescue StandardError
    render json: {message: I18n.t("not_found")}, status: :not_found
  end
end
