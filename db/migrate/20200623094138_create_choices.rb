class CreateChoices < ActiveRecord::Migration[6.0]
  def change
    create_table :choices do |t|
      t.boolean :value
      t.references :question, null: false, foreign_key: true
      t.integer :next_question_id
      t.references :step, null: false, foreign_key: true

      t.timestamps
    end
  end
end
