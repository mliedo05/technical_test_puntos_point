class Categories::Destroy
  def initialize(category)
    @category = category
  end

  def call
    return category_not_found_response unless category_exists?

    if @category.destroy
      success_response
    else
      failure_response
    end
  end

  private

  def category_exists?
    @category.present?
  end

  def category_not_found_response
    {
      success: false,
      message: 'category not found.',
      data: nil
    }
  end

  def success_response
    {
      success: true,
      message: 'category successfully deleted.',
      data: @category
    }
  end

  def failure_response
    {
      success: false,
      message: 'Failed to delete category.',
      errors: @category.errors.full_messages
    }
  end
end
