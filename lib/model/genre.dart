class Genre {
  final int? id;
  final String? name;
  final String? description;

  Genre({
    this.id,
    this.name,
    this.description,
  });

  factory Genre.fromMap(Map<String, dynamic> map) {
    return Genre(
      id: map["id"] as int?,
      name: map["name"] as String?,
      description: map["description"] as String?,
    );
  }
}
