require "jwt"

class Auth
  AUTH_SECRET = Rails.application.secrets.secret_key_base.to_s

  def self.issue payload
    exp = Settings.const.expired_token.minutes.from_now
    payload[:exp] = exp.to_i
    JWT.encode(payload, AUTH_SECRET)
  end

  def self.decode token
    JWT.decode(token, AUTH_SECRET).first
  rescue StandardError
    {}
  end
end
