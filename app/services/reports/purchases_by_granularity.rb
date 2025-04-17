class Reports::PurchasesByGranularity
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

    case params[:granularity]
    when 'hour'
      group_format = "%Y-%m-%d %H:00"
    when 'day'
      group_format = "%Y-%m-%d"
    when 'week'
      group_format = "IYYY-IW"
    when 'year'
      group_format = "%Y"
    else
      return { error: "Granularity no válida. Usa: hour, day, week, year." }
    end

    purchases.group("TO_CHAR(purchases.created_at, '#{group_format}')").count
  end

end
