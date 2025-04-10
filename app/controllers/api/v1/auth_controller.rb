class Api::V1::AuthController < ApplicationController

  def login
    admin = Admin.find_for_database_authentication(email: params[:email])
    if admin&.valid_password?(params[:password])
      render json: { token: generate_jwt_token(admin) }, status: :ok
    else
      render json: { error: 'Invalid email or password' }, status: :unauthorized
    end
  end

  def register
    admin = Admin.new(admin_params)
    if admin.save
      render json: { message: 'Admin user created successfully' }, status: :created
    else
      render json: { errors: admin.errors.full_messages }, status: :unprocessable_entity
    end
  end

  private

  def admin_params
    params.require(:admin).permit(:email, :password, :password_confirmation, :name)
  end

  def generate_jwt_token(admin)
    Auth::JwtService.encode(user_id: admin.id)
  end
end
