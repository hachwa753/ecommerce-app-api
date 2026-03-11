import 'package:ecommerceappapi/features/carts/data/datasource/cart_api_source.dart';
import 'package:ecommerceappapi/features/carts/domain/model/cart.dart';
import 'package:ecommerceappapi/features/carts/domain/repo/cart_repo.dart';
import 'package:ecommerceappapi/features/products/domain/model/product.dart';

class CartRepoImpl implements CartRepo {
  final CartApiSource cartApiSource;

  CartRepoImpl(this.cartApiSource);
  @override
  Future<List<Cart>> getAllCarts() {
    return cartApiSource.getAllCartList();
  }

  @override
  Future<Cart> addToCart(Product product) async {
    return cartApiSource.addToCart(product.id);
  }
}
