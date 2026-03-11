import 'package:ecommerceappapi/features/carts/domain/model/product_model.dart';

class Cart {
  final int id;
  final List<ProductModel> products;
  final double total;
  final double discountedTotal;
  final int userId;
  final int totalProducts;
  final int totalQuantity;

  Cart({
    required this.id,
    required this.products,
    required this.total,
    required this.discountedTotal,
    required this.userId,
    required this.totalProducts,
    required this.totalQuantity,
  });

  Cart copyWith({
    int? id,
    List<ProductModel>? products,
    double? total,
    double? discountedTotal,
    int? userId,
    int? totalProducts,
    int? totalQuantity,
  }) {
    return Cart(
      id: id ?? this.id,
      products: products ?? this.products,
      total: total ?? this.total,
      discountedTotal: discountedTotal ?? this.discountedTotal,
      userId: userId ?? this.userId,
      totalProducts: totalProducts ?? this.totalProducts,
      totalQuantity: totalQuantity ?? this.totalQuantity,
    );
  }

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'id': id,
      'products': products.map((x) => x.toMap()).toList(),
      'total': total,
      'discountedTotal': discountedTotal,
      'userId': userId,
      'totalProducts': totalProducts,
      'totalQuantity': totalQuantity,
    };
  }

  factory Cart.fromMap(Map<String, dynamic> map) {
    return Cart(
      id: map['id'] as int,
      products: List<ProductModel>.from(
        (map['products'] as List).map(
          (x) => ProductModel.fromMap(x as Map<String, dynamic>),
        ),
      ),
      total: (map['total'] as num).toDouble(), // <- FIX
      discountedTotal: (map['discountedTotal'] as num).toDouble(), // <- FIX
      userId: map['userId'] as int,
      totalProducts: map['totalProducts'] as int,
      totalQuantity: map['totalQuantity'] as int,
    );
  }
}
