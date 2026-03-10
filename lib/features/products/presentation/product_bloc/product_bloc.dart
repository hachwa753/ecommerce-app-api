import 'package:ecommerceappapi/features/products/domain/model/product.dart';
import 'package:ecommerceappapi/features/products/domain/repo/product_repo.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

part 'product_event.dart';
part 'product_state.dart';

class ProductBloc extends Bloc<ProductEvent, ProductState> {
  final ProductRepo productRepo;
  ProductBloc(this.productRepo) : super(ProductState()) {
    on<FetchAllProducts>(_fetchAllProducts);
    on<FetchProductsByCategories>(_fetchAllProductsByCategory);
    on<FetchProductDetail>(_fetchSingleProduct);
  }

  void _fetchAllProducts(
    FetchAllProducts event,
    Emitter<ProductState> emit,
  ) async {
    emit(state.copyWith(productStatus: ProductStatus.loading));
    try {
      final products = await productRepo.getAllProducts();

      emit(
        state.copyWith(product: products, productStatus: ProductStatus.loaded),
      );
    } catch (e) {
      emit(
        state.copyWith(productStatus: ProductStatus.failure, msz: e.toString()),
      );
    }
  }

  void _fetchAllProductsByCategory(
    FetchProductsByCategories event,
    Emitter<ProductState> emit,
  ) async {
    emit(state.copyWith(productStatus: ProductStatus.loading));
    try {
      final products = await productRepo.getProductsByCategory(event.category);

      emit(
        state.copyWith(
          productbyCat: products,
          productStatus: ProductStatus.loaded,
        ),
      );
    } catch (e) {
      emit(
        state.copyWith(productStatus: ProductStatus.failure, msz: e.toString()),
      );
    }
  }

  Future<void> _fetchSingleProduct(
    FetchProductDetail event,
    Emitter<ProductState> emit,
  ) async {
    emit(state.copyWith(detailProductStatus: DetailProductStatus.loading));
    try {
      final product = await productRepo.getProductDetail(event.id);
      emit(
        state.copyWith(
          selectedProduct: product,
          detailProductStatus: DetailProductStatus.loaded,
        ),
      );
    } catch (e) {
      emit(
        state.copyWith(
          detailProductStatus: DetailProductStatus.failure,
          msz: e.toString(),
        ),
      );
    }
  }
}
