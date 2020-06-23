class Consultation < ApplicationRecord
  belongs_to :coach
  belongs_to :step
end
