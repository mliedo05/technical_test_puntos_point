class Reports::FilteredPurchases
  def self.call(params)
    purchases = Purchase.all

    if params[:from].present? && params[:to].present?
      purchases = purchases.where(created_at: params[:from]..params[:to])
    end

    if params[:category_id].present?
      purchases = purchases.joins(product: :categories).where(categories: { id: params[:category_id] })
    end

    purchases = purchases.where(client_id: params[:client_id]) if params[:client_id].present?
    purchases = purchases.joins(:product).where(products: { admin_id: params[:admin_id] }) if params[:admin_id].present?

    purchases.includes(:product, :client).map do |purchase|
      {
        id: purchase.id,
        quantity: purchase.quantity,
        total_price: purchase.total_price,
        created_at: purchase.created_at,
        client: {
          id: purchase.client.id,
          name: purchase.client.name
        },
        product: {
          id: purchase.product.id,
          name: purchase.product.name
        }
      }
    end
  end
end
