part of 'product_bloc.dart';

sealed class ProductEvent extends Equatable {
  const ProductEvent();

  @override
  List<Object> get props => [];
}

class FetchAllProducts extends ProductEvent {}

class FetchProductsByCategories extends ProductEvent {
  final String category;
  
  const FetchProductsByCategories(this.category);
}

class FetchProductDetail extends ProductEvent {
  final int id;

  const FetchProductDetail(this.id);
}
