class Purchases::Create
  attr_reader :params 
  def initialize(params)
    @params = params
  end

  def call

    purchase = Purchase.new(params)
    if purchase.save!
      send_first_purchase_email(purchase)
      success_response(purchase)
    else
      failure_response(purchase)
    end
  end

  private
  def send_first_purchase_email(purchase)
    product = purchase.product
    total_purchases = product.purchases.count
  
    return unless total_purchases == 1
  
    creator = Admin.find_by(id: product.admin_id)
    cc_admins = Admin.where.not(id: creator.id)
  
    PurchaseMailer.first_purchase_email(purchase, creator, cc_admins).deliver_now
  end
  


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
