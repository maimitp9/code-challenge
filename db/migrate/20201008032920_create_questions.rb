class CreateQuestions < ActiveRecord::Migration[6.0]
  def change
    create_table :questions do |t|
      t.string :text, limit: 255, null: false

      t.timestamps
    end
  end
end
