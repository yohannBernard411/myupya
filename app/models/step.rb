class Step < ApplicationRecord
    has_many :users
    has_many :choices
    has_many :consultations 
    has_many :articles
    has_many :videos
end
