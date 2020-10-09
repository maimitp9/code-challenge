class Feedback {
  id: number;
  title: string;
  status: string;
  questions: Array<{id: number, text: string}>;

  constructor(data: {
    id: number;
    title: string;
    status: string;
    questions: Array<{id: number, text: string}>;
  }) {
    this.id = data.id;
    this.title = data.title;
    this.status = data.status;
    this.questions = data.questions;
  }
}

export default Feedback;
