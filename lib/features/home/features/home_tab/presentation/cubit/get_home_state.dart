part of 'get_home_cubit.dart';

sealed class GetHomeState extends Equatable {
  const GetHomeState();

  @override
  List<Object> get props => [];
}

final class GetHomeInitial extends GetHomeState {}

final class GetHomeLoading extends GetHomeState {}

final class GetHomeSuccess extends GetHomeState {
  final HomeEntity home;

  const GetHomeSuccess(this.home);
}

final class GetHomeError extends GetHomeState {
  final ApiException exception;

  const GetHomeError(this.exception);
}
