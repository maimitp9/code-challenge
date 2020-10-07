class CreateFeedbacks < ActiveRecord::Migration[6.0]
  def change
    create_table :feedbacks do |t|
      t.string :year, null: false
      t.integer :status, null: false, default: 0

      t.timestamps
    end
    add_index :feedbacks, :year, unique: true
  end
end
