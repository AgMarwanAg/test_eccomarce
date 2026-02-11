part of 'get_product_details_cubit.dart';

sealed class GetProductDetailsState extends Equatable {
  const GetProductDetailsState();

  @override
  List<Object> get props => [];
}

final class GetProductDetailsInitial extends GetProductDetailsState {}

final class GetProductDetailsLoading extends GetProductDetailsState {
  const GetProductDetailsLoading();

  @override
  List<Object> get props => [];
}

final class GetProductDetailsSuccess extends GetProductDetailsState {
  final ProductModel product;

  const GetProductDetailsSuccess(this.product);

  @override
  List<Object> get props => [product];
}

final class GetProductDetailsFailure extends GetProductDetailsState {
  final ApiException exception;

  const GetProductDetailsFailure(this.exception);

  @override
  List<Object> get props => [exception];
}