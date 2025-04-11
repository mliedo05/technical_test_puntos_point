class Categories::Update
  def initialize(category, params)
    @category = category
    @params = params
  end

  def call
    if @category.update(@params)
      success_response(@category)
    else
      failure_response(@category)
    end
  end

  private

  def success_response(category)
    {
      success: true,
      message: "category successfully updated.",
      data: category
    }
  end

  def failure_response(category)
    {
      success: false,
      message: "Failed to update category.",
      errors: category.errors.full_messages
    }
  end
end
