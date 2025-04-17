class Api::V1::ClientsController < ApplicationController
  before_action :authenticate_user_from_token!, only: %i[index]
  before_action :set_client, only: %i[show edit update destroy]

  def index
    clients = Client.all
    render json: clients, status: :ok
  end

  def show
    render json: client, status: :ok
  end

  # def create
  #   service = Clients::Create.new(client_params).call
  #   if service[:success]
  #     render json: service[:data], status: :created
  #   else
  #     render json: { errors: service[:message] }, status: :unprocessable_entity
  #   end
  # end

  def update
    service = Clients::Update.new(@client, client_params).call
    if service[:success]
      render json: service[:data], status: :ok
    else
      render json: { errors: service[:errors], message: service[:message] }, status: :unprocessable_entity
    end
  end

  def destroy
    service = Clients::Destroy.new(@client).call
    if service[:success]
      render json: { message: service[:message] }, status: :ok
    else
      render json: { error: service[:message] }, status: :unprocessable_entity
    end
  end

  private

  def client_params
    params.require(:client).permit(:name, :email, :phone, :address)
  end

  def set_client
    @client = Client.find_by(id: params[:id])
    return if @client

    render json: { error: 'Client not found' }, status: :not_found
  end
end
