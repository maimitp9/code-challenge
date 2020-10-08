class CreateFeedbacks < ActiveRecord::Migration[6.0]
  def change
    create_table :feedbacks do |t|
      t.string :title
      t.integer :status, default: 0, index: true

      t.timestamps
    end
    add_index :feedbacks, :title, unique: true
  end
end
