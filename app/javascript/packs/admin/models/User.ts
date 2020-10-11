class User {
  id: number;
  name: string;
  email: string;
  role: string;
  status: string;

  constructor(data: {
    id: number;
    name: string;
    email: string;
    role: string;
    status: string;
  }) {
    this.id = data.id;
    this.name = data.name;
    this.email = data.email;
    this.role = data.role;
    this.status = data.status;
  }
}

export default User;
