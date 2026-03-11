import 'package:ecommerceappapi/features/carts/domain/model/cart.dart';
import 'package:ecommerceappapi/features/products/domain/model/product.dart';

abstract class CartRepo {
  Future<List<Cart>> getAllCarts();
  Future<Cart> addToCart(Product product);
}
