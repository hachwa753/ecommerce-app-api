// ignore_for_file: public_member_api_docs, sort_constructors_first
part of 'search_bloc.dart';

enum SearchStatus { initial, loading, loaded, failure }

class SearchState extends Equatable {
  final SearchStatus searchStatus;
  final String? msz;
  final List<Product> product;
  const SearchState({
    this.searchStatus = SearchStatus.initial,
    this.msz,
    this.product = const [],
  });

  @override
  List<Object?> get props => [searchStatus, product, msz];

  SearchState copyWith({
    SearchStatus? searchStatus,
    String? msz,
    List<Product>? product,
  }) {
    return SearchState(
      searchStatus: searchStatus ?? this.searchStatus,
      msz: msz ?? this.msz,
      product: product ?? this.product,
    );
  }
}
