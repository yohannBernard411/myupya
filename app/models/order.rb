class Order < ApplicationRecord
  belongs_to :user
  belongs_to :coach
  monetize :amount_cents
end
