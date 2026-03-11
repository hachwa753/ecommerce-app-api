// ignore_for_file: public_member_api_docs, sort_constructors_first
part of 'cart_bloc.dart';

enum CartStatus { initial, loading, loaded, failure }

class CartState extends Equatable {
  final CartStatus cartStatus;
  final List<Cart> cart;
  final String? msz;
  const CartState({
    this.cartStatus = CartStatus.initial,
    this.cart = const [],
    this.msz,
  });

  @override
  List<Object?> get props => [cartStatus, cart, msz];

  CartState copyWith({CartStatus? cartStatus, List<Cart>? cart, String? msz}) {
    return CartState(
      cartStatus: cartStatus ?? this.cartStatus,
      cart: cart ?? this.cart,
      msz: msz ?? this.msz,
    );
  }
}
