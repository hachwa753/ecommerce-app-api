import 'package:ecommerceappapi/features/carts/domain/model/cart.dart';
import 'package:ecommerceappapi/features/carts/domain/repo/cart_repo.dart';
import 'package:ecommerceappapi/features/products/domain/model/product.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

part 'cart_event.dart';
part 'cart_state.dart';

class CartBloc extends Bloc<CartEvent, CartState> {
  final CartRepo cartRepo;
  CartBloc(this.cartRepo) : super(CartState()) {
    on<GetAllCartList>(_fetchAllCartList);
    on<AddProductToCart>(_addProductToCart);
  }

  void _fetchAllCartList(GetAllCartList event, Emitter<CartState> emit) async {
    emit(state.copyWith(cartStatus: CartStatus.loading));
    try {
      final cart = await cartRepo.getAllCarts();
      emit(state.copyWith(cart: cart, cartStatus: CartStatus.loaded));
    } catch (e) {
      emit(state.copyWith(cartStatus: CartStatus.failure, msz: e.toString()));
    }
  }

  void _addProductToCart(
    AddProductToCart event,
    Emitter<CartState> emit,
  ) async {
    await cartRepo.addToCart(event.product);
    try {
      final cart = await cartRepo.getAllCarts();
      emit(state.copyWith(cart: cart, cartStatus: CartStatus.loaded));
    } catch (e) {
      emit(state.copyWith(cartStatus: CartStatus.failure, msz: e.toString()));
    }
  }
}
