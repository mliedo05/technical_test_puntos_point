class Reports::TopEarningProductsByCategory
  def self.call
    Category.includes(:products).map do |category|
      top_products = category.products.joins(:purchases).select("products.id, products.name, SUM(purchases.total_price) AS total_earned").group("products.id").order("total_earned DESC").limit(3)

      {
        category: category.name,
        top_earning_products: top_products.map do |p|
          {
            id: p.id,
            name: p.name,
            total_earned: p.total_earned.to_f
          }
        end
      }
    end
  end
end
