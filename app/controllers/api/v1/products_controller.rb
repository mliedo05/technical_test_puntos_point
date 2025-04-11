class Api::V1::ProductsController < ApplicationController
  before_action :authenticate_user_from_token!, only: %i[ update destroy create ] 
  before_action :set_product, only: %i[ show update destroy ]
  
  def index
    products = Product.all
    render json: products, status: :ok
  end

  def show
    render json: product, status: :ok
  end

  def create
    service = Products::Create.new(product_params).call
    if service[:success]
      render json: service[:data], status: :created
    else
      render json: { errors: service[:message] }, status: :unprocessable_entity
    end
  end

  def update
    service = Products::Update.new(@product, product_params).call
    if service[:success]
      render json: service[:data], status: :ok
    else
      render json: { errors: service[:errors], message: service[:message] }, status: :unprocessable_entity
    end
  end

  def destroy
    service = Products::Destroy.new(@product).call
    if service[:success]
      render json: { message: service[:message] }, status: :ok
    else
      render json: { error: service[:message], details: service[:errors] }, status: :unprocessable_entity
    end
  end

  private

  def product_params
    params.permit(:name, :description, :price, :stock, :admin_id, category_ids: [], images: [])
  end

  def set_product
    @product = Product.find_by(id: params[:id])
    unless @product
      render json: { error: "product not found" }, status: :not_found
    end
  end

end
