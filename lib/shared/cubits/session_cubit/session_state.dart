part of 'session_cubit.dart';

sealed class SessionState extends Equatable {
  const SessionState();

  @override
  List<Object> get props => [];
}

 
final class Authenticated extends SessionState {
  // final UserModel user;
  // const Authenticated(this.user);
}
final class UnAuthenticated extends SessionState {}
final class AuthLoading extends SessionState {}

extension SessionStateExtension on SessionState {
  bool get isAuthenticated => this is Authenticated;
  bool get isUnAuthenticated => this is UnAuthenticated;
  bool get isLoading => this is AuthLoading;
}