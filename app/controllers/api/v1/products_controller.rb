class Api::V1::ProductsController < ApplicationController
  before_action :authenticate_user_from_token!, only: %i[update destroy create remove_category]
  before_action :set_product, only: %i[show update destroy remove_category]

  def index
    products = Product.all
    render json: products, status: :ok
  end

  def show
    if @product
      render json: @product.as_json(include: { categories: { only: %i[id name] } }), status: :ok
    else
      render json: { error: 'Product not found' }, status: :not_found
    end
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
      render json: { error: service[:message] }, status: :unprocessable_entity
    end
  end

  def remove_category
    service = Products::RemoveCategory.new(@product, params[:category_id]).call

    if service[:success]
      render json: { message: service[:message] }, status: :ok
    else
      render json: { error: service[:message] }, status: :unprocessable_entity
    end
  end

  private

  def product_params
    params.require(:product).permit(:name, :description, :price, :stock, :admin_id, category_ids: [], images: [])
  end

  def set_product
    @product = Product.find_by(id: params[:id])
    return if @product

    render json: { error: 'product not found' }, status: :not_found
  end
end
