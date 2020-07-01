class AddBackgroundToStep < ActiveRecord::Migration[6.0]
  def change
    add_column :steps, :background, :string
  end
end
