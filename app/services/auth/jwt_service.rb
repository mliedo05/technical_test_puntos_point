class Auth::JwtService
  HMAC_SECRET = Rails.application.credentials.devise_jwt_secret_key || ENV['DEVISE_JWT_SECRET_KEY']
  EXPIRATION_TIME = 1.day

  def self.encode(payload)
    payload[:exp] =  EXPIRATION_TIME.from_now.to_i
    JWT.encode(payload, HMAC_SECRET)
  end

  def self.decode(token)
    body = JWT.decode(token, HMAC_SECRET)[0]
    HashWithIndifferentAccess.new(body)
  rescue JWT::DecodeError => e
    nil
  end
end
