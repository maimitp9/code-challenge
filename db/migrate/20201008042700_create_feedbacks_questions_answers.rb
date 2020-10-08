class CreateFeedbacksQuestionsAnswers < ActiveRecord::Migration[6.0]
  def change
    create_table :feedbacks_questions_answers do |t|
      t.integer :feedback_id, null: false, foreign_key: true
      t.integer :question_id, null: false, foreign_key: true
      t.integer :answer_id, null: false, foreign_key: true
      t.integer :user_id, null: false
      t.integer :reviewer_id, null: false, foreign_key: true

      t.timestamps
    end
    add_index :feedbacks_questions_answers, [:feedback_id, :question_id, :answer_id], name: "index_feedbacks_questions_answers", :unique => true

  end
end
