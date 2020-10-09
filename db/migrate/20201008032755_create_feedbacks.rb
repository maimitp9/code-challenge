class CreateFeedbacks < ActiveRecord::Migration[6.0]
  def change
    create_table :feedbacks do |t|
      t.string :title, null: false
      t.integer :status, default: 0, index: true

      t.timestamps
    end
  end
end
