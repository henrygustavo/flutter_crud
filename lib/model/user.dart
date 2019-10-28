class User {
  int id;
  String name;
  String email;

  User(this.name, this.email);
  User.withId(this.id, this.name, this.email);
}