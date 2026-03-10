part of 'search_bloc.dart';

sealed class SearchEvent extends Equatable {
  const SearchEvent();

  @override
  List<Object> get props => [];
}

class FetchProductsByQuery extends SearchEvent {
  final String query;
  const FetchProductsByQuery(this.query);
}

class ClearEvent extends SearchEvent {}
