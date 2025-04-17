class Auth::JwtService
  EXPIRATION_TIME = 1.day

  def self.encode(payload)
    payload[:exp] = EXPIRATION_TIME.from_now.to_i
    JWT.encode(payload, Rails.application.secrets.secret_key_base)
  end

  def self.decode(token)
    body = JWT.decode(token, Rails.application.secrets.secret_key_base)[0]
    HashWithIndifferentAccess.new body
  rescue StandardError
    nil
  end
end
