import 'package:ecommerceappapi/features/products/domain/model/category.dart';
import 'package:ecommerceappapi/features/products/domain/repo/product_repo.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

part 'category_event.dart';
part 'category_state.dart';

class CategoryBloc extends Bloc<CategoryEvent, CategoryState> {
  final ProductRepo repo;
  CategoryBloc(this.repo) : super(CategoryState()) {
    on<FetchAllCategories>(fetchAllCategories);
  }

  void fetchAllCategories(
    CategoryEvent event,
    Emitter<CategoryState> emit,
  ) async {
    emit(state.copyWith(categoryStatus: CategoryStatus.loading));
    try {
      final categories = await repo.getAllCategories();
      emit(
        state.copyWith(
          categoryStatus: CategoryStatus.loaded,
          category: categories,
        ),
      );
    } catch (e) {
      emit(
        state.copyWith(
          categoryStatus: CategoryStatus.failure,
          msz: e.toString(),
        ),
      );
    }
  }
}
