class CreateFeedbacksQuestionsAnswers < ActiveRecord::Migration[6.0]
  def change
    create_table :feedbacks_questions_answers do |t|
      t.references :feedbacks_question, null: false, foreign_key: true
      t.string :text, null: false
      t.integer :user_id, null: false, index: true
      t.integer :reviewer_id, null: false, index: true

      t.timestamps
    end
  end
end
