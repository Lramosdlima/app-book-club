class User {
  String? name;
  String? email;
  String? password;

  User({
    this.name,
    this.email,
    this.password,
  });

  factory User.fromMap(Map<String, dynamic> map) {
    return User(
      name: map["name"] as String?,
      email: map["email"] as String?,
      password: map["password"] as String?,
    );
  }
}
