class AddColumnStatusToUsersFeedbacks < ActiveRecord::Migration[6.0]
  def change
    add_column :users_feedbacks, :status, :integer, default: 0, null: false
  end
end
