class DailyPurchaseReportJob < ApplicationJob
  queue_as :default

  def perform
    yesterday = Date.yesterday.all_day
    purchases = Purchase.where(created_at: yesterday)

    grouped = purchases.group_by(&:product_id)
    report = grouped.map do |product_id, product_purchases|
      product = Product.find(product_id)
      total_quantity = product_purchases.sum(&:quantity)
      total_amount = product_purchases.sum(&:total_price)
      "- #{product.name}: #{total_quantity} unidades - Total: $#{total_amount}"
    end.join("\n")

    Admin.find_each do |admin|
      PurchaseMailer.daily_report_email(admin, report).deliver_later
    end
  end
end
