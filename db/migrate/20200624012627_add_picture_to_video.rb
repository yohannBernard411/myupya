class AddPictureToVideo < ActiveRecord::Migration[6.0]
  def change
    add_column :videos, :picture, :string
  end
end
