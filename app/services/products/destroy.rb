class Products::Destroy
  def initialize(product)
    @product = product
  end

  def call
    return product_not_found_response unless product_exists?

    if @product.destroy
      success_response
    else
      failure_response
    end
  end

  private

  def product_exists?
    @product.present?
  end

  def product_not_found_response
    {
      success: false,
      message: 'product not found.',
      data: nil
    }
  end

  def success_response
    {
      success: true,
      message: 'product successfully deleted.',
      data: @product
    }
  end

  def failure_response
    {
      success: false,
      message: 'Failed to delete product.',
      errors: @product.errors.full_messages
    }
  end
end
