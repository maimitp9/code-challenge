class CreateUsersFeedbacks < ActiveRecord::Migration[6.0]
  def change
    create_table :users_feedbacks do |t|
      t.references :user
      t.references :feedback
      t.integer :reviewer_id, null: false

      t.timestamps
    end
    add_index :users_feedbacks, [:user_id, :feedback_id, :reviewer_id], name: "index_users_feedbacks_on_user_feedback", :unique => true
  end
end
