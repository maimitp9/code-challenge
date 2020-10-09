import User from "./User";
import Question from "./Question";
import FeedbacksQuestion from "./FeedbacksQuestion";

class Feedback {
  id: number;
  title: string;
  status: string;
  questions?: Array<Question>;
  feedbacksQuestions?: Array<FeedbacksQuestion>;
  usersFeedbacks: Array<{user: User, reviewer: User}>;

  constructor(data: {
    id: number;
    title: string;
    status: string;
    questions?: Array<Question>;
    feedbacksQuestions?: Array<FeedbacksQuestion>;
    usersFeedbacks: Array<{user: User, reviewer: User}>;
  }) {
    this.id = data.id;
    this.title = data.title;
    this.status = data.status;
    this.questions = data.questions;
    this.feedbacksQuestions = data.feedbacksQuestions;
    this.usersFeedbacks = data.usersFeedbacks;
  }
}

export default Feedback;
