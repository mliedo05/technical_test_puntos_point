class Categories::Create
  attr_reader :params

  def initialize(params)
    @params = params
  end

  def call
    return category_exists_response if category_exists?

    category = Category.new(params)
    if category.save
      success_response(category)
    else
      failure_response(category)
    end
  end

  def category_exists?
    normalized_name = params[:name].to_s.strip.downcase.capitalize
    @existing_category = Category.find_by(name: normalized_name)
  end

  def category_exists_response
    {
      success: false,
      message: 'A category with this name already exists.',
      data: @existing_category
    }
  end

  def success_response(category)
    {
      success: true,
      message: 'category created successfully.',
      data: category
    }
  end

  def failure_response(category)
    {
      success: false,
      message: 'Failed to create category.',
      errors: category.errors.full_messages
    }
  end
end
