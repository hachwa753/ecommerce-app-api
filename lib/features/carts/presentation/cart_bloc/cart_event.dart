part of 'cart_bloc.dart';

sealed class CartEvent extends Equatable {
  const CartEvent();

  @override
  List<Object> get props => [];
}

class GetAllCartList extends CartEvent {}

class AddProductToCart extends CartEvent {
  final Product product;

  const AddProductToCart(this.product);
}
