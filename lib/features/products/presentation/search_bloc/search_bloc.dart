import 'package:ecommerceappapi/features/products/domain/model/product.dart';
import 'package:ecommerceappapi/features/products/domain/repo/product_repo.dart';
import 'package:ecommerceappapi/features/products/presentation/product_bloc/product_bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

part 'search_event.dart';
part 'search_state.dart';

class SearchBloc extends Bloc<SearchEvent, SearchState> {
  final ProductRepo productRepo;
  SearchBloc(this.productRepo) : super(SearchState()) {
    on<FetchProductsByQuery>(_fetchProductByQuery);
    on<ClearEvent>(_clearEvent);
  }

  void _fetchProductByQuery(
    FetchProductsByQuery event,
    Emitter<SearchState> emit,
  ) async {
    emit(state.copyWith(searchStatus: SearchStatus.loading));
    try {
      final product = await productRepo.searchProducts(event.query);
      emit(state.copyWith(searchStatus: SearchStatus.loaded, product: product));
    } catch (e) {
      emit(state.copyWith(searchStatus: SearchStatus.failure, msz: "Failed"));
    }
  }

  void _clearEvent(ClearEvent event, Emitter<SearchState> emit) async {
    emit(state.copyWith(product: [], searchStatus: SearchStatus.initial));
  }
}
