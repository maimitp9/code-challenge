class Question {
  id: number;
  text: string;
  answer: string | null;

  constructor(data: { id: number; text: string; answer: string | null; }) {
    this.id = data.id;
    this.text = data.text;
    this.answer = data.answer;
  }
}

export default Question;