part of 'search_cubit.dart';

sealed class SearchState extends Equatable {
  const SearchState();

  @override
  List<Object> get props => [];
}

final class SearchInitial extends SearchState {}

final class SearchLoading extends SearchState {}

final class SearchSuccess extends SearchState {
  final List<ProductModel> products;
  final bool hasReachedMax;

  const SearchSuccess(this.products, {this.hasReachedMax = false});

  @override
  List<Object> get props => [products, hasReachedMax];
}

final class SearchFailure extends SearchState {
  final ApiException error;

  const SearchFailure(this.error);

  @override
  List<Object> get props => [error];
}
