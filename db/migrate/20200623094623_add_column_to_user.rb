class AddColumnToUser < ActiveRecord::Migration[6.0]
  def change
    add_column :users, :name, :string
    add_column :users, :current_question_id, :integer
    add_reference :users, :step, null: false, foreign_key: true
  end
end
