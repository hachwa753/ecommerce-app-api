import 'package:ecommerceappapi/features/products/domain/model/category.dart';
import 'package:ecommerceappapi/features/products/domain/model/product.dart';

abstract class ProductRepo {
  Future<List<Product>> getAllProducts();
  Future<List<CategoryModel>> getAllCategories();

  Future<List<Product>> getProductsByCategory(String category);
  Future<Product> getProductDetail(int id);
  Future<List<Product>> searchProducts(String query);
}
