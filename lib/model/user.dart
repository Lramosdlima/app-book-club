class User {
  int? id;
  String? name;
  String? email;
  String? password;
  String? profilePicture;

  User({
    this.id,
    this.name,
    this.email,
    this.password,
    this.profilePicture,
  });

  factory User.fromMap(Map<String, dynamic> map) {
    return User(
      id: map["id"] as int?,
      name: map["name"] as String?,
      email: map["email"] as String?,
      password: map["password"] as String?,
      profilePicture: map["profilePicture"] as String?,
    );
  }
}
