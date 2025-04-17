class Api::V1::CategoriesController < ApplicationController
  before_action :authenticate_user_from_token!, only: %i[update destroy create]
  before_action :set_category, only: %i[show update destroy]

  def index
    categories = Category.all
    render json: categories, status: :ok
  end

  def show
    render json: category, status: :ok
  end

  def create
    service = Categories::Create.new(category_params).call
    if service[:success]
      render json: service[:data], status: :created
    else
      render json: { errors: service[:message] }, status: :unprocessable_entity
    end
  end

  def update
    service = Categories::Update.new(@category, category_params).call
    if service[:success]
      render json: service[:data], status: :ok
    else
      render json: { errors: service[:errors], message: service[:message] }, status: :unprocessable_entity
    end
  end

  def destroy
    service = Categories::Destroy.new(@category).call
    if service[:success]
      render json: { message: service[:message] }, status: :ok
    else
      render json: { error: service[:message] }, status: :unprocessable_entity
    end
  end

  private

  def category_params
    params.require(:category).permit(:name, :description, :admin_id)
  end

  def set_category
    @category = Category.find_by(id: params[:id])
    return if @category

    render json: { error: 'Category not found' }, status: :not_found
  end
end
