import User from "./User";

class Feedback {
  id: number;
  title: string;
  status: string;
  questions: Array<{id: number, text: string}>;
  usersFeedbacks: Array<{user: User, reviewer: User}>;

  constructor(data: {
    id: number;
    title: string;
    status: string;
    questions: Array<{id: number, text: string}>;
    usersFeedbacks: Array<{user: User, reviewer: User}>;
  }) {
    this.id = data.id;
    this.title = data.title;
    this.status = data.status;
    this.questions = data.questions;
    this.usersFeedbacks = data.usersFeedbacks;
  }
}

export default Feedback;
