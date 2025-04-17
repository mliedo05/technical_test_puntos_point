class Api::V1::ReportsController < ApplicationController
  before_action :authenticate_user_from_token!

  def top_products_by_category
    render json: Reports::TopProductsByCategory.call
  end

  def top_earning_products_by_category
    render json: Reports::TopEarningProductsByCategory.call
  end

  def filtered_purchases
    render json: Reports::FilteredPurchases.call(params)
  end

  def purchases_by_granularity
    render json: Reports::PurchasesByGranularity.call(params)
  end
end
