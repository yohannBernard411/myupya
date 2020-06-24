class AddPhotoToCoach < ActiveRecord::Migration[6.0]
  def change
    add_column :coaches, :photo_url, :string
  end
end
