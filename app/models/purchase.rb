class Purchase < ApplicationRecord
  belongs_to :product
  belongs_to :client
end
