class Purchases::Update
  attr_reader :params

  def initialize(purchase, params)
    @purchase = purchase
    @params = params
  end

  def call
    if @purchase.update(params)
      success_response(@purchase)
    else
      failure_response(@purchase)
    end
  end

  private

  def success_response(purchase)
    {
      success: true,
      message: "Purchase successfully updated.",
      data: purchase
    }
  end

  def failure_response(purchase)
    {
      success: false,
      message: "Failed to update purchase.",
      errors: purchase.errors.full_messages
    }
  end
end
