class Products::RemoveCategory
  def initialize(product, category_id)
    @product = product
    @category_id = category_id
  end

  def call
    category = Category.find_by(id: @category_id)
    return not_found_response unless category

    if @product.categories.include?(category)
      @product.categories.delete(category)
      success_response
    else
      not_associated_response
    end
  end

  private

  def success_response
    {
      success: true,
      message: "Category removed successfully."
    }
  end

  def not_associated_response
    {
      success: false,
      message: "This category is not associated with the product."
    }
  end

  def not_found_response
    {
      success: false,
      message: "Category not found."
    }
  end
end
