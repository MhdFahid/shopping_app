import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'home_controller.dart';
import '../../services/auth_service.dart';
import '../../models/product_model.dart';
import '../../models/banner_model.dart';
import '../../models/brand_model.dart';
import '../product_list/product_list_page.dart';
import '../product_details/product_details_page.dart';
import '../cart/cart_controller.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      context.read<HomeController>().getHomeData();
    });
  }

  @override
  Widget build(BuildContext context) {
    final controller = context.watch<HomeController>();

    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: const Color(0xFF7B3A00),
        elevation: 0,
        leading: Padding(
          padding: const EdgeInsets.all(10.0),
          child: Image.asset('assets/images/logo_ico.png', height: 30),
        ),
        actions: [
          IconButton(
            onPressed: () {},
            icon: const Icon(Icons.search, color: Colors.white),
          ),
          IconButton(
            onPressed: () {},
            icon: const Icon(Icons.favorite_border, color: Colors.white),
          ),
          Stack(
            children: [
              IconButton(
                onPressed: () {},
                icon: const Icon(
                  Icons.notifications_outlined,
                  color: Colors.white,
                ),
              ),
              Positioned(
                right: 12,
                top: 12,
                child: Container(
                  width: 8,
                  height: 8,
                  decoration: const BoxDecoration(
                    color: Colors.white,
                    shape: BoxShape.circle,
                  ),
                ),
              ),
            ],
          ),
          const SizedBox(width: 8),
        ],
      ),
      body: RefreshIndicator(
        onRefresh: () => controller.getHomeData(),
        color: const Color(0xFF7B3A00),
        child: controller.isLoading && controller.homeData == null
            ? const Center(
                child: CircularProgressIndicator(color: Color(0xFF7B3A00)),
              )
            : controller.error != null
            ? SingleChildScrollView(
                physics: const AlwaysScrollableScrollPhysics(),
                child: SizedBox(
                  height: MediaQuery.of(context).size.height - 100,
                  child: Center(child: Text("Error: ${controller.error}")),
                ),
              )
            : SingleChildScrollView(
                physics: const AlwaysScrollableScrollPhysics(),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const SizedBox(height: 16),

                    // 🔶 Banner Slider
                    if (controller.homeData?.banner1.isNotEmpty ?? false)
                      SizedBox(
                        height: 180,
                        child: PageView.builder(
                          itemCount: controller.homeData!.banner1.length,
                          itemBuilder: (context, index) {
                            final banner = controller.homeData!.banner1[index];
                            return Padding(
                              padding: const EdgeInsets.symmetric(
                                horizontal: 16,
                              ),
                              child: Container(
                                width: MediaQuery.of(context).size.width - 100,
                                decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(10),
                                  gradient: const LinearGradient(
                                    colors: [
                                      Color(0xFFFF8C2B),
                                      Color(0xFFFFB066),
                                    ],
                                  ),
                                  image: banner.image.isNotEmpty
                                      ? DecorationImage(
                                          image: NetworkImage(
                                            "${AuthService.imageBaseUrl}/images/banner/${banner.image}",
                                          ),
                                          fit: BoxFit.cover,
                                        )
                                      : null,
                                ),
                                child: Padding(
                                  padding: const EdgeInsets.all(16),
                                  child: Row(
                                    children: [
                                      Expanded(
                                        child: Column(
                                          crossAxisAlignment:
                                              CrossAxisAlignment.start,
                                          children: [
                                            Text(
                                              banner.title ?? '',
                                              style: const TextStyle(
                                                fontSize: 20,
                                                fontWeight: FontWeight.bold,
                                                color: Colors.white,
                                              ),
                                            ),
                                            const SizedBox(height: 8),
                                            Text(
                                              banner.subTitle ?? '',
                                              style: const TextStyle(
                                                color: Colors.white,
                                              ),
                                            ),
                                            const Spacer(),
                                            ElevatedButton(
                                              style: ElevatedButton.styleFrom(
                                                backgroundColor: Colors.white,
                                                foregroundColor: Colors.orange,
                                                shape: RoundedRectangleBorder(
                                                  borderRadius:
                                                      BorderRadius.circular(20),
                                                ),
                                              ),
                                              onPressed: () {},
                                              child: Text('Shop Now'),
                                            ),
                                          ],
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                              ),
                            );
                          },
                        ),
                      ),

                    const SizedBox(height: 24),

                
                    sectionTitle('Categories'),
                    SizedBox(
                      height: 110,
                      child: ListView.builder(
                        padding: const EdgeInsets.symmetric(horizontal: 16),
                        scrollDirection: Axis.horizontal,
                        itemCount: controller.homeData?.categories.length ?? 0,
                        itemBuilder: (context, index) {
                          final wrapper =
                              controller.homeData!.categories[index];
                          final category = wrapper.category;
                          return Padding(
                            padding: const EdgeInsets.only(right: 16),
                            child: GestureDetector(
                              onTap: () {
                                Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                    builder: (_) => ProductListPage(
                                      categorySlug: category.slug,
                                      categoryName: category.name,
                                    ),
                                  ),
                                );
                              },
                              child: Column(
                                children: [
                                  CircleAvatar(
                                    radius: 35,
                                    backgroundColor: Colors.white,
                                    backgroundImage: category.image.isNotEmpty
                                        ? NetworkImage(
                                            "${AuthService.imageBaseUrl}/images/category/${category.image}",
                                          )
                                        : const AssetImage(
                                                'assets/images/cat.png',
                                              )
                                              as ImageProvider,
                                  ),
                                  const SizedBox(height: 8),
                                  Text(
                                    category.name,
                                    textAlign: TextAlign.center,
                                    style: const TextStyle(fontSize: 12),
                                  ),
                                ],
                              ),
                            ),
                          );
                        },
                      ),
                    ),

                    const SizedBox(height: 16),

                    
                    if (controller.homeData?.recentViews.isNotEmpty ??
                        false) ...[
                      sectionTitle(
                        'Recent Views',
                        onTap: () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (_) => const ProductListPage(),
                            ),
                          );
                        },
                      ),
                      productList(controller.homeData!.recentViews),
                      const SizedBox(height: 16),
                    ],

                    // 🔶 Our Products
                    sectionTitle(
                      'Our Products',
                      onTap: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (_) => const ProductListPage(),
                          ),
                        );
                      },
                    ),
                    productList(controller.homeData?.ourProducts),

                    const SizedBox(height: 16),

                    
                    sectionTitle(
                      'Flash Sail',
                      onTap: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (_) => const ProductListPage(),
                          ),
                        );
                      },
                    ),
                    productList(controller.homeData?.flashSail),

                    const SizedBox(height: 16),

                    
                    if (controller.homeData?.suggestedProducts.isNotEmpty ??
                        false) ...[
                      sectionTitle(
                        'Suggested Products',
                        onTap: () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (_) => const ProductListPage(),
                            ),
                          );
                        },
                      ),
                      productList(controller.homeData!.suggestedProducts),
                      const SizedBox(height: 16),
                    ],

                    
                    if (controller.homeData?.banner2.isNotEmpty ?? false)
                      promoBanner(controller.homeData!.banner2[0]),

                    const SizedBox(height: 16),

                    
                    sectionTitle(
                      'Best Selling',
                      onTap: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (_) => const ProductListPage(),
                          ),
                        );
                      },
                    ),
                    productList(controller.homeData?.bestSeller),

                    const SizedBox(height: 16),

                    
                    if (controller.homeData?.featuredBrands.isNotEmpty ??
                        false) ...[
                      sectionTitle('Top Brands'),
                      brandList(controller.homeData!.featuredBrands),
                      const SizedBox(height: 16),
                    ],

                    const SizedBox(height: 32),
                  ],
                ),
              ),
      ),
    );
  }

  Widget sectionTitle(String title, {VoidCallback? onTap}) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(
            title,
            style: const TextStyle(
              fontSize: 18,
              fontWeight: FontWeight.bold,
              color: Color(0xFF7B3A00),
            ),
          ),
          if (onTap != null)
            GestureDetector(
              onTap: onTap,
              child: const Text(
                'See All',
                style: TextStyle(
                  color: Color(0xFF7B3A00),
                  fontWeight: FontWeight.w500,
                ),
              ),
            ),
        ],
      ),
    );
  }

  Widget productList(List<Product>? products) {
    if (products == null || products.isEmpty) {
      return const SizedBox(
        height: 100,
        child: Center(child: Text("No products found")),
      );
    }
    return SizedBox(
      height: 290,
      child: ListView.builder(
        padding: const EdgeInsets.symmetric(horizontal: 16),
        scrollDirection: Axis.horizontal,
        itemCount: products.length,
        itemBuilder: (context, index) {
          final product = products[index];
          return GestureDetector(
            onTap: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (_) => ProductDetailsPage(product: product),
                ),
              );
            },
            child: Container(
              width: 180,
              margin: const EdgeInsets.only(right: 16),
              padding: const EdgeInsets.all(12),
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(16),
                boxShadow: [
                  BoxShadow(
                    color: Colors.black.withOpacity(0.05),
                    blurRadius: 10,
                    offset: const Offset(0, 4),
                  ),
                ],
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const Align(
                    alignment: Alignment.topRight,
                    child: Icon(Icons.favorite_border, size: 18),
                  ),
                  Center(
                    child: product.image.isNotEmpty
                        ? Image.network(
                            "${AuthService.imageBaseUrl}/images/product/${product.image}",
                            height: 100,
                            errorBuilder: (context, error, stackTrace) =>
                                Image.asset(
                                  'assets/images/product.png',
                                  height: 100,
                                ),
                          )
                        : Image.asset('assets/images/product.png', height: 100),
                  ),
                  const SizedBox(height: 8),
                  Text(
                    product.category,
                    style: const TextStyle(fontSize: 12, color: Colors.grey),
                  ),
                  const SizedBox(height: 4),
                  Text(
                    product.name,
                    style: const TextStyle(
                      fontWeight: FontWeight.w600,
                      fontSize: 14,
                    ),
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                  ),
                  const SizedBox(height: 4),
                  Text(
                    '₹${product.price}',
                    style: const TextStyle(
                      color: Color(0xFF7B3A00),
                      fontWeight: FontWeight.bold,
                      fontSize: 16,
                    ),
                  ),
                  const Spacer(),
                  SizedBox(
                    width: double.infinity,
                    child: OutlinedButton.icon(
                      onPressed: () {
                        context.read<CartController>().addToCart(product);
                        ScaffoldMessenger.of(context).showSnackBar(
                          SnackBar(
                            content: Text("${product.name} added to cart!"),
                            behavior: SnackBarBehavior.floating,
                            backgroundColor: const Color(0xFF7B3A00),
                          ),
                        );
                      },
                      icon: const Icon(Icons.shopping_cart_outlined, size: 16),
                      label: const Text('Add', style: TextStyle(fontSize: 12)),
                      style: OutlinedButton.styleFrom(
                        foregroundColor: const Color(0xFF7B3A00),
                        side: const BorderSide(color: Color(0xFF7B3A00)),
                        padding: const EdgeInsets.symmetric(vertical: 8),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(12),
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          );
        },
      ),
    );
  }

  Widget promoBanner(BannerModel banner) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16),
      child: Container(
        height: 100,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(16),
          image: DecorationImage(
            image: NetworkImage(
              "${AuthService.imageBaseUrl}/images/banner/${banner.image}",
            ),
            fit: BoxFit.cover,
          ),
        ),
      ),
    );
  }

  Widget brandList(List<BrandModel> brands) {
    return SizedBox(
      height: 80,
      child: ListView.builder(
        padding: const EdgeInsets.symmetric(horizontal: 16),
        scrollDirection: Axis.horizontal,
        itemCount: brands.length,
        itemBuilder: (context, index) {
          final brand = brands[index];
          return Container(
            margin: const EdgeInsets.only(right: 12),
            width: 80,
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(12),
              border: Border.all(color: Colors.grey.shade200),
            ),
            child: ClipRRect(
              borderRadius: BorderRadius.circular(12),
              child: Image.network(
                "${AuthService.imageBaseUrl}/images/brand/${brand.image}",
                fit: BoxFit.contain,
                errorBuilder: (context, error, stackTrace) =>
                    const Icon(Icons.business, color: Colors.grey),
              ),
            ),
          );
        },
      ),
    );
  }
}
