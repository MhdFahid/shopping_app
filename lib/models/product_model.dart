class Product {
  final int id;
  final String name;
  final String image;
  final String price;
  final String oldprice;
  final String category;
  final String description;
  final String? slug;

  Product({
    required this.id,
    required this.name,
    required this.image,
    required this.price,
    required this.oldprice,
    required this.category,
    required this.description,
    this.slug,
  });

  factory Product.fromJson(Map<String, dynamic> json) {
    return Product(
      id: json['productId'] ?? json['id'] ?? 0,
      name: json['name'] ?? '',
      image: json['image'] ?? '',
      price: json['price']?.toString() ?? '0.00',
      oldprice: json['oldprice']?.toString() ?? '0.00',
      category: json['category'] ?? '',
      description: json['description'] ?? '',
      slug: json['slug'],
    );
  }

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is Product && runtimeType == other.runtimeType && id == other.id;

  @override
  int get hashCode => id.hashCode;
}
