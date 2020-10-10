import User from "./User";

class Feedback {
  id: number;
  title: string;
  status: string;
  questions: Array<{id: number, text: string}>;
  usersFeedbacks?: Array<usersFeedback>;
  feedbacksQuestions?: Array<feedbacksQuestion> | [];

  constructor(data: {
    id: number;
    title: string;
    status: string;
    questions: Array<{id: number, text: string}>;
    usersFeedbacks?: Array<usersFeedback>;
    feedbacksQuestions?: Array<feedbacksQuestion>;
  }) {
    this.id = data.id;
    this.title = data.title;
    this.status = data.status;
    this.questions = data.questions;
    this.usersFeedbacks = data.usersFeedbacks.map(uf => new usersFeedback(uf));
    this.feedbacksQuestions = data.feedbacksQuestions && data.feedbacksQuestions.map(fq => new feedbacksQuestion(fq));
  }
}

export default Feedback;

class usersFeedback {
  user: User;
  reviewer: User;
  status: string;

  constructor(data: { user: User, reviewer: User, status: string}) {
    this.user = new User(data.user);
    this.reviewer = new User(data.reviewer);
    this.status = data.status;
  }
}

class feedbacksQuestion {
  question?: Question;
  feedbacksQuestionsAnswers?: Array<feedbacksQuestionsAnswer>;

  constructor(data: { question?: Question; feedbacksQuestionsAnswers?: Array<feedbacksQuestionsAnswer>; }) {
    this.question = new Question(data.question);
    this.feedbacksQuestionsAnswers = data.feedbacksQuestionsAnswers.map(fqa => new feedbacksQuestionsAnswer(fqa));
  }
}

class Question {
  id: number;
  text: string;

  constructor(data: { id: number; text: string; }) {
    this.id = data.id;
    this.text = data.text;
  }
}

class feedbacksQuestionsAnswer {
  id: number;
  feedbacksQuestionId?: number;
  answer?: string;

  constructor(data: { id?: number; feedbacksQuestionId?: number; text?: string; }) {
    this.id = data.id;
    this.feedbacksQuestionId = data.feedbacksQuestionId;
    this.answer = data.text;
  }
}