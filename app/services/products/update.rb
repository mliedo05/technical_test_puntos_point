class Products::Update
  attr_reader :params

  def initialize(product, params)
    @product = product
    @params = params
  end

  def call
    if @product.update(params)
      update_categories if params[:category_ids]
      success_response(@product)
    else
      failure_response(@product)
    end
  end

  private

  def update_categories
    new_categories = Category.where(id: params[:category_ids])
    @product.categories << new_categories.reject { |cat| @product.categories.include?(cat) }
  end

  def success_response(product)
    {
      success: true,
      message: 'Product successfully updated.',
      data: product
    }
  end

  def failure_response(product)
    {
      success: false,
      message: 'Failed to update product.',
      errors: product.errors.full_messages
    }
  end
end
