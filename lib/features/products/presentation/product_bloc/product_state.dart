// ignore_for_file: public_member_api_docs, sort_constructors_first
part of 'product_bloc.dart';

enum ProductStatus { initial, loading, loaded, failure }

enum DetailProductStatus { initial, loading, loaded, failure }

class ProductState extends Equatable {
  final ProductStatus productStatus;
  final DetailProductStatus detailProductStatus;
  final List<Product> product;
  final List<Product> productbyCat;
  final Product? selectedProduct;
  final String? msz;
  const ProductState({
    this.productStatus = ProductStatus.initial,
    this.detailProductStatus = DetailProductStatus.initial,
    this.product = const [],
    this.productbyCat = const [],
    this.msz,
    this.selectedProduct,
  });

  @override
  List<Object?> get props => [
    productStatus,
    product,
    msz,
    productbyCat,
    selectedProduct,
    detailProductStatus,
  ];

  ProductState copyWith({
    ProductStatus? productStatus,
    DetailProductStatus? detailProductStatus,
    List<Product>? product,
    List<Product>? productbyCat,
    Product? selectedProduct,
    String? msz,
  }) {
    return ProductState(
      productStatus: productStatus ?? this.productStatus,
      detailProductStatus: detailProductStatus ?? this.detailProductStatus,
      product: product ?? this.product,
      productbyCat: productbyCat ?? this.productbyCat,
      selectedProduct: selectedProduct ?? this.selectedProduct,
      msz: msz ?? this.msz,
    );
  }
}
