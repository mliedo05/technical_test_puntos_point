class Api::V1::PurchasesController < ApplicationController
  before_action :authenticate_user_from_token!, only: %i[update destroy]

  before_action :set_purchase, only: %i[show update destroy]

  def index
    purchases = Purchase.all.includes(:product, :client)
    render json: purchases, status: :ok
  end

  def show
    render json: @purchase, status: :ok
  end

  def create
    service = Purchases::Create.new(purchase_params).call

    if service[:success]
      render json: service[:data], status: :created
    else
      render json: { errors: service[:message] }, status: :unprocessable_entity
    end
  end

  def update
    service = Purchases::Update.new(@purchase, purchase_params).call

    if service[:success]
      render json: service[:data], status: :ok
    else
      render json: { errors: service[:message] }, status: :unprocessable_entity
    end
  end

  def destroy
    service = Purchases::Destroy.new(@purchase).call
    if service[:success]
      render json: { message: service[:message] }, status: :ok
    else
      render json: { error: service[:message] }, status: :unprocessable_entity
    end
  end

  private

  def set_purchase
    @purchase = Purchase.find(params[:id])
  rescue ActiveRecord::RecordNotFound
    render json: { error: 'Purchase not found' }, status: :not_found
  end

  def purchase_params
    params.require(:purchase).permit(:product_id, :client_id, :quantity)
  end
end
