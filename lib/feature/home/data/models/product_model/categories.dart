class Categories {
  final String name;
  final int id;
  final String image;
  Categories({required this.name, required this.id, required this.image});
  Map<String, dynamic> toJson() {
    return {'id': id, 'name': name, 'image': image};
  }

  factory Categories.fromJson(Map<String, dynamic> json) {
    return Categories(
      name: json['name'] ?? '',
      id: json['id'] ?? 0,
      image: json['image'],
    );
  }
}
