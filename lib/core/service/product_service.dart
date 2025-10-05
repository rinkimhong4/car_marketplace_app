import 'package:car_marketplace_app/core/data/product_data.dart';
import 'package:car_marketplace_app/core/models/product_detail_model.dart';

/// Service class for managing product data.
/// In a real application, this would handle API calls, caching, etc.
class ProductService {
  /// Fetches all available products.
  /// Currently returns static data, but could be replaced with API calls.
  Future<List<ProductDetail>> fetchProducts() async {
    // Simulate network delay
    await Future.delayed(const Duration(milliseconds: 500));
    return products;
  }

  /// Fetches a product by its title.
  /// Returns null if not found.
  Future<ProductDetail?> fetchProductByTitle(String title) async {
    await Future.delayed(const Duration(milliseconds: 200));
    return products.firstWhere(
      (product) => product.title == title,
      orElse: () => throw Exception('Product not found'),
    );
  }
}
