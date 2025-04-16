class Api::V1::AuthController < ApplicationController
  def login
    user = find_user_by_email(params[:email])
    
    if user&.valid_password?(params[:password])
      render json: { token: generate_jwt_token(user) }, status: :ok
    else
      render json: { error: 'Invalid email or password' }, status: :unauthorized
    end
  end

  def register
    user = find_user_type.new(user_params)

    if user.save
      render json: { message: "#{user.class.name} user created successfully" }, status: :created
    else
      render json: { errors: user.errors.full_messages }, status: :unprocessable_entity
    end
  end

  private

  def find_user_by_email(email)
    admin = Admin.find_for_database_authentication(email: email)
    return admin if admin.present?

    Client.find_for_database_authentication(email: email)
  end

  def find_user_type
    params[:user_type] == 'admin' ? Admin : Client
  end

  def user_params
    params.require(:user).permit(:email, :password, :password_confirmation, :name)
  end

  def generate_jwt_token(user)
    Auth::JwtService.encode(user_id: user.id)
  end
end
