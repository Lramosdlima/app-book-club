// ignore_for_file: non_constant_identifier_names

class User {
  int? id;
  String? name;
  String? email;
  String? password;
  String? profile_picture;

  User({
    this.id,
    this.name,
    this.email,
    this.password,
    this.profile_picture,
  });

  factory User.fromMap(Map<String, dynamic> map) {
    return User(
      id: map["id"] as int?,
      name: map["name"] as String?,
      email: map["email"] as String?,
      password: map["password"] as String?,
      profile_picture: map["profile_picture"] as String?,
    );
  }
}
