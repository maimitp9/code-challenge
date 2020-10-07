class CreateUsersFeedbacks < ActiveRecord::Migration[6.0]
  def change
    create_table :users_feedbacks do |t|
      t.references :user, null: false, foreign_key: true
      t.references :feedback, null: false, foreign_key: true
      t.integer :reviewer_id, null: false
      t.integer :status, null: false, default: 0

      t.timestamps
    end
    add_index :users_feedbacks, [:user_id, :feedback_id, :reviewer_id], unique: true, name: 'index_users_feedbacks_user_feedback_reviewer'
    add_index :users_feedbacks, :status
  end
end
