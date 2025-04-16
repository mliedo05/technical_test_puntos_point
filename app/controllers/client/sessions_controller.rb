class Clients::SessionsController < Devise::SessionsController
  def create
    super do |resource|
      if resource.jwt_token.present?
        render json: { token: resource.jwt_token }, status: :ok
      else
        render json: { error: 'No JWT token available' }, status: :unprocessable_entity
      end
    end
  end
end
