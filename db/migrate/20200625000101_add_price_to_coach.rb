class AddPriceToCoach < ActiveRecord::Migration[6.0]
  def change
    add_monetize :coaches, :price, currency: { present: false }
  end
end
