import 'banner_model.dart';
import 'category_model.dart';
import 'product_model.dart';
import 'brand_model.dart';

class HomeDataModel {
  final int success;
  final String message;
  final List<BannerModel> banner1;
  final List<BannerModel> banner2;
  final List<BannerModel> banner3;
  final List<BannerModel> banner4;
  final List<BannerModel> banner5;
  final List<Product> recentViews;
  final List<Product> ourProducts;
  final List<Product> suggestedProducts;
  final List<Product> flashSail;
  final List<Product> newArrivals;
  final List<Product> bestSeller;
  final List<CategoryWrapper> categories;
  final List<BrandModel> featuredBrands;
  final int cartCount;

  HomeDataModel({
    required this.success,
    required this.message,
    required this.banner1,
    required this.banner2,
    required this.banner3,
    required this.banner4,
    required this.banner5,
    required this.recentViews,
    required this.ourProducts,
    required this.suggestedProducts,
    required this.flashSail,
    required this.newArrivals,
    required this.bestSeller,
    required this.categories,
    required this.featuredBrands,
    required this.cartCount,
  });

  factory HomeDataModel.fromJson(Map<String, dynamic> json) {
    return HomeDataModel(
      success: json['success'] ?? 0,
      message: json['message'] ?? '',
      banner1:
          (json['banner1'] as List?)
              ?.map((e) => BannerModel.fromJson(e))
              .toList() ??
          [],
      banner2:
          (json['banner2'] as List?)
              ?.map((e) => BannerModel.fromJson(e))
              .toList() ??
          [],
      banner3:
          (json['banner3'] as List?)
              ?.map((e) => BannerModel.fromJson(e))
              .toList() ??
          [],
      banner4:
          (json['banner4'] as List?)
              ?.map((e) => BannerModel.fromJson(e))
              .toList() ??
          [],
      banner5:
          (json['banner5'] as List?)
              ?.map((e) => BannerModel.fromJson(e))
              .toList() ??
          [],
      recentViews:
          (json['recentviews'] as List?)
              ?.map((e) => Product.fromJson(e))
              .toList() ??
          [],
      ourProducts:
          (json['our_products'] as List?)
              ?.map((e) => Product.fromJson(e))
              .toList() ??
          [],
      suggestedProducts:
          (json['suggested_products'] as List?)
              ?.map((e) => Product.fromJson(e))
              .toList() ??
          [],
      flashSail:
          (json['flash_sail'] as List?)
              ?.map((e) => Product.fromJson(e))
              .toList() ??
          [],
      newArrivals:
          (json['newarrivals'] as List?)
              ?.map((e) => Product.fromJson(e))
              .toList() ??
          [],
      bestSeller:
          (json['best_seller'] as List?)
              ?.map((e) => Product.fromJson(e))
              .toList() ??
          [],
      categories:
          (json['categories'] as List?)
              ?.map((e) => CategoryWrapper.fromJson(e))
              .toList() ??
          [],
      featuredBrands:
          (json['featuredbrands'] as List?)
              ?.map((e) => BrandModel.fromJson(e))
              .toList() ??
          [],
      cartCount: json['cartcount'] ?? 0,
    );
  }
}
