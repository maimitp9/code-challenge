class User {
  id: number;
  name: string;
  email: string;
  role: string;

  constructor(data: {
    id: number;
    name: string;
    email: string;
    role: string;
  }) {
    this.id = data.id;
    this.name = data.name;
    this.email = data.email;
    this.role = data.role;
  }
}

export default User;
