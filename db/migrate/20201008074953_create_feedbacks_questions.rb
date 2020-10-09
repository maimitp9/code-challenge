class CreateFeedbacksQuestions < ActiveRecord::Migration[6.0]
  def change
    create_table :feedbacks_questions do |t|
      t.references :feedback, null: false, foreign_key: true
      t.references :question, null: false, foreign_key: true

      t.timestamps
    end
    add_index :feedbacks_questions, [:feedback_id, :question_id]
  end
end
