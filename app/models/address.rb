class Address < ApplicationRecord
  belongs_to :order
  belongs_to :prefecture
end
