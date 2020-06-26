class Coach < ApplicationRecord
    has_many :consultations
    monetize :price_cents
end
