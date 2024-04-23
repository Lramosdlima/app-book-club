class Author {
  final int? id;
  final String? name;
  final String? description;
  final String? photo;

  Author({
    this.id,
    this.name,
    this.description,
    this.photo,
  });

  factory Author.fromMap(Map<String, dynamic> map) {
    return Author(
      id: map["id"] as int?,
      name: map["name"] as String?,
      description: map["description"] as String?,
      photo: map["photo"] as String?,
    );
  }
}
