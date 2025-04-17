class Reports::TopProductsByCategory
  def self.call
    Category.includes(:products).map do |category|
      top_products = category.products.joins(:purchases).select("products.id, products.name, COUNT(purchases.id) AS total_purchases").group("products.id").order("total_purchases DESC")
      {
        category: category.name,
        top_products: top_products.map do |p|
          { id: p.id, name: p.name, total_purchases: p.total_purchases.to_i }
        end
      }
    end
  end
end
