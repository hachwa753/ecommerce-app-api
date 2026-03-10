import 'package:ecommerceappapi/features/products/data/datasource/api_source.dart';
import 'package:ecommerceappapi/features/products/domain/model/category.dart';
import 'package:ecommerceappapi/features/products/domain/model/product.dart';
import 'package:ecommerceappapi/features/products/domain/repo/product_repo.dart';

class ProductRepoImpl implements ProductRepo {
  final ApiSource apiSource;

  ProductRepoImpl(this.apiSource);

  @override
  Future<List<Product>> getAllProducts() async {
    return apiSource.fetchProducts();
  }

  @override
  Future<List<CategoryModel>> getAllCategories() {
    return apiSource.fetchCategories();
  }

  @override
  Future<List<Product>> getProductsByCategory(String category) {
    return apiSource.fetchProductByCategory(category);
  }

  @override
  Future<Product> getProductDetail(int id) {
    return apiSource.fetchProduct(id);
  }

  @override
  Future<List<Product>> searchProducts(String query) {
    return apiSource.searchProduct(query);
  }
}
