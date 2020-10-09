import Question from "./Question";

class FeedbacksQuestion {
  id: number;
  feedbackId: number;
  questionId: number;
  question: Question;

  constructor(data: {
    id: number;
    feedbackId: number;
    questionId: number;
    question: Question;
  }) {
    this.id = data.id;
    this.feedbackId = data.feedbackId;
    this.questionId = data.questionId;
    this.question = data.question;
  }
}

export default FeedbacksQuestion;
