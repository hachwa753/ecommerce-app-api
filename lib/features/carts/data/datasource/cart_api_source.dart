import 'dart:developer';

import 'package:dio/dio.dart';
import 'package:ecommerceappapi/core/network/dio_client.dart';
import 'package:ecommerceappapi/features/carts/domain/model/cart.dart';

class CartApiSource {
  final Dio dio = DioClient().client;

  Future<List<Cart>> getAllCartList() async {
    try {
      final response = await dio.get("/carts/user/200");
      final List data = response.data['carts'];
      // log("Cart length: ${data.toString()}");
      log("First cart: ${data[0]}");
      if (response.statusCode == 200) {
        return data.map((cart) => Cart.fromMap(cart)).toList();
      } else {
        throw Exception("Failed to fetch users: ${response.statusCode}");
      }
    } on DioException catch (e) {
      throw Exception('Failed to fetch products: ${e.message}');
    }
  }

  Future<Cart> addToCart(int productId) async {
    try {
      final response = await dio.post(
        "/carts/add",
        data: {
          "userId": 200,
          "products": [
            {"id": productId, "quantity": 1},
          ],
        },
      );
      if (response.statusCode == 200 || response.statusCode == 201) {
        return Cart.fromMap(response.data);
      } else {
        throw Exception("Failed to add to cart");
      }
    } on DioException catch (e) {
      throw Exception("Add to cart failed: ${e.message}");
    }
  }
}
