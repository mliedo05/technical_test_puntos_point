class Purchases::Destroy
  def initialize(purchase)
    @purchase = purchase
  end

  def call
    return purchase_not_found_response unless purchase_exists?

    if @purchase.destroy
      success_response
    else
      failure_response
    end
  end

  private

  def purchase_exists?
    @purchase.present?
  end

  def purchase_not_found_response
    {
      success: false,
      message: 'purchase not found.',
      data: nil
    }
  end

  def success_response
    {
      success: true,
      message: 'purchase successfully deleted.',
      data: @purchase
    }
  end

  def failure_response
    {
      success: false,
      message: 'Failed to delete purchase.',
      errors: @purchase.errors.full_messages
    }
  end
end
