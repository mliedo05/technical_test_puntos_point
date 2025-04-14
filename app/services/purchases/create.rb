class Purchases::Create
  attr_reader :params 
  def initialize(params)
    @params = params
  end

  def call

    purchase = Purchase.new(params)
    if purchase.save!
      success_response(purchase)
    else
      failure_response(purchase)
    end
  end

  private  


  def success_response(purchase)
    {
      success: true,
      message: "purchase created successfully.",
      data: purchase
    }
  end

  def failure_response(purchase)
    {
      success: false,
      message: "Failed to create purchase.",
      errors: purchase.errors.full_messages
    }
  end
end
