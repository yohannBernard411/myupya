class Choice < ApplicationRecord
  belongs_to :question
  belongs_to :step
end
