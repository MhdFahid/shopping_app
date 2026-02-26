class CategoryModel {
  final int id;
  final String slug;
  final String image;
  final String name;
  final String? description;

  CategoryModel({
    required this.id,
    required this.slug,
    required this.image,
    required this.name,
    this.description,
  });

  factory CategoryModel.fromJson(Map<String, dynamic> json) {
    return CategoryModel(
      id: json['id'] ?? 0,
      slug: json['slug'] ?? '',
      image: json['image'] ?? '',
      name: json['name'] ?? '',
      description: json['description'],
    );
  }
}

class CategoryWrapper {
  final CategoryModel category;
  final List<dynamic> subcategory;

  CategoryWrapper({required this.category, required this.subcategory});

  factory CategoryWrapper.fromJson(Map<String, dynamic> json) {
    return CategoryWrapper(
      category: CategoryModel.fromJson(json['category']),
      subcategory: json['subcategory'] ?? [],
    );
  }
}
