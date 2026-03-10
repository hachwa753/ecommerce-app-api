part of 'category_bloc.dart';

enum CategoryStatus { initial, loading, loaded, failure }

class CategoryState extends Equatable {
  final List<CategoryModel> category;
  final CategoryStatus categoryStatus;
  final String? msz;
  const CategoryState({
    this.categoryStatus = CategoryStatus.initial,
    this.category = const [],

    this.msz,
  });

  @override
  List<Object?> get props => [categoryStatus, msz, category];

  CategoryState copyWith({
    List<CategoryModel>? category,
    CategoryStatus? categoryStatus,
    String? msz,
  }) {
    return CategoryState(
      category: category ?? this.category,
      categoryStatus: categoryStatus ?? this.categoryStatus,
      msz: msz ?? this.msz,
    );
  }
}
