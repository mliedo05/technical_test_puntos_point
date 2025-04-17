class ApplicationController < ActionController::API
  include Devise::Controllers::Helpers
  def authenticate_user_from_token!
    token = request.headers['Authorization']&.split(' ')&.last
    if token.present?
      begin
        decoded_token = Auth::JwtService.decode(token)
        if decoded_token.nil?
          render json: { error: 'Invalid or expired token' }, status: :unauthorized
          return
        end

        admin_id = decoded_token['user_id']
        @current_user = Admin.find(admin_id)
      rescue ActiveRecord::RecordNotFound
        render json: { error: 'Admin not found' }, status: :unauthorized
      end
    else
      render json: { error: 'Token not provided' }, status: :unauthorized
    end
  end
end
