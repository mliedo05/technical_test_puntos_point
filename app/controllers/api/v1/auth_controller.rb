class Api::V1::AuthController < ApplicationController

  def login
    admin_user = AdminUser.find_for_database_authentication(email: params[:email])
    if admin_user&.valid_password?(params[:password])
      render json: { token: generate_jwt_token(admin_user) }, status: :ok
    else
      render json: { error: 'Invalid email or password' }, status: :unauthorized
    end
  end

  def register
    admin_user = AdminUser.new(admin_user_params)
    if admin_user.save
      render json: { message: 'Admin user created successfully' }, status: :created
    else
      render json: { errors: admin_user.errors.full_messages }, status: :unprocessable_entity
    end
  end

  private

  def admin_user_params
    params.require(:admin_user).permit(:email, :password, :password_confirmation, :name)
  end

  def generate_jwt_token(admin_user)
    Auth::JwtService.encode(user_id: admin_user.id)
  end
end
