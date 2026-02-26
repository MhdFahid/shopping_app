class BrandModel {
  final int id;
  final String image;
  final String slug;
  final String name;

  BrandModel({
    required this.id,
    required this.image,
    required this.slug,
    required this.name,
  });

  factory BrandModel.fromJson(Map<String, dynamic> json) {
    return BrandModel(
      id: json['id'] ?? 0,
      image: json['image'] ?? '',
      slug: json['slug'] ?? '',
      name: json['name'] ?? '',
    );
  }
}
