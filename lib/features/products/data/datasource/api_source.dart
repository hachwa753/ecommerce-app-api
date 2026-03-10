import 'dart:developer';

import 'package:dio/dio.dart';
import 'package:ecommerceappapi/core/network/dio_client.dart';
import 'package:ecommerceappapi/features/products/domain/model/category.dart';
import 'package:ecommerceappapi/features/products/domain/model/product.dart';

class ApiSource {
  final Dio dio = DioClient().client;

  Future<List<Product>> fetchProducts() async {
    try {
      final response = await dio.get("/products");
      final List data = response.data['products'];

      if (response.statusCode == 200) {
        final product = data.map((e) => Product.fromMap(e)).toList();
        product.shuffle();
        return product;
      } else {
        throw Exception("Failed to fetch users: ${response.statusCode}");
      }
    } on DioException catch (e) {
      throw Exception('Failed to fetch products: ${e.message}');
    }
  }

  Future<List<CategoryModel>> fetchCategories() async {
    try {
      final response = await dio.get("/products/categories");
      final List data = response.data;
      // log(data.toString());
      if (response.statusCode == 200) {
        return data.map((e) => CategoryModel.fromMap(e)).toList();
      } else {
        throw Exception("Failed to fetch categories: ${response.statusCode}");
      }
    } on DioException catch (e) {
      throw Exception('Failed to fetch categories: ${e.message}');
    }
  }

  Future<List<Product>> fetchProductByCategory(String category) async {
    try {
      final response = await dio.get("/products/category/$category");
      final List data = response.data['products'];
      log(data.length.toString());
      if (response.statusCode == 200) {
        return data.map((e) => Product.fromMap(e)).toList();
      } else {
        throw Exception("Failed to fetch categories: ${response.statusCode}");
      }
    } on DioException catch (e) {
      throw Exception('Failed to fetch categories: ${e.message}');
    }
  }

  Future<Product> fetchProduct(int id) async {
    try {
      final response = await dio.get("/products/$id");
      if (response.statusCode == 200) {
        return Product.fromMap(response.data);
      } else {
        throw Exception("Failed to fetch product: ${response.statusCode}");
      }
    } on DioException catch (e) {
      throw Exception('Failed to fetch product: ${e.message}');
    }
  }

  Future<List<Product>> searchProduct(String searchQuery) async {
    try {
      final response = await dio.get(
        "/products/search",
        queryParameters: {"q": searchQuery},
      );
      final List data = response.data['products'] ?? [];

      log(data.length.toString());
      if (response.statusCode == 200) {
        return data.map((e) => Product.fromMap(e)).toList();
      } else {
        throw Exception("Failed to fetch categories: ${response.statusCode}");
      }
    } on DioException catch (e) {
      throw Exception('Failed to fetch product: ${e.message}');
    }
  }
}
