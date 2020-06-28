class AddDateToOrder < ActiveRecord::Migration[6.0]
  def change
    add_column :orders, :date, :string
  end
end
