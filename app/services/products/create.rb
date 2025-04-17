class Products::Create
  attr_reader :params

  def initialize(params)
    @params = params
  end

  def call
    return product_exists_response if product_exists?

    product = Product.new(params)
    if product.save!
      success_response(product)
    else
      failure_response(product)
    end
  end

  private

  def product_exists?
    normalized_name = params[:name].to_s.strip.downcase.capitalize
    @existing_product = Product.find_by(name: normalized_name)
  end

  def product_exists_response
    {
      success: false,
      message: 'A product with this name already exists.',
      data: @existing_product
    }
  end

  def success_response(product)
    {
      success: true,
      message: 'Product created successfully.',
      data: product
    }
  end

  def failure_response(product)
    {
      success: false,
      message: 'Failed to create product.',
      errors: product.errors.full_messages
    }
  end
end
