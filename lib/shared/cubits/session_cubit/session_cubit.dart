import 'package:flutter_bloc/flutter_bloc.dart';

import 'package:equatable/equatable.dart';

part 'session_state.dart';
/// Manages the state of the user session.
///
/// Listens to the authentication state and emits the corresponding state.
/// If the user is authenticated, it emits [Authenticated] with the user data.
/// If the user is not authenticated, it emits [Unauthenticated].
///
/// The [logout] method is used to log out the user and delete their data from the SharedPreferences.
/// The [deleteAccount] method is used to delete the user's account from the Firebase Authentication.
///
/// The [init] method is used to initialize the state of the user session.
/// The [authenticated] method is used to authenticate the user and emit the authenticated state.
/// The [logout] method is used to log out the user and delete their data from the SharedPreferences.
/// The [deleteAccount] method is used to delete the user's account from the Firebase Authentication.
class SessionCubit extends Cubit<SessionState> {
  SessionCubit() : super(UnAuthenticated());
  void init() {
    // if (UserModel.isAuthenticated) {
    //   final user = UserModel.cache()!;
    //   emit(Authenticated(user));
    // } else {
    //   emit(UnAuthenticated());
    // }
  }

  void authenticated() {
    // if (UserModel.isAuthenticated) {
    //   emit(AuthLoading());
    //   final user = UserModel.cache()!;
    //   emit(Authenticated(user));
    // }
  }

  Future<void> logout({bool callLogout = false}) async {
    emit(AuthLoading());
    // if (callLogout) await sl<AuthApis>().logout();
    // sl<SharedPreferencesService>().delete(AppValues.user);
    // await FirebaseMessaging.instance.deleteToken();
    emit(UnAuthenticated());
  }

  Future<void> deleteAccount() async {
    // await FirebaseMessaging.instance.deleteToken();
    // final Result result = await sl<AuthRepo>().deleteAccount();
    // result.fold(
    //   onSuccess: (data) async {
    //     // sl<SharedPreferencesService>().delete(AppValues.user);
    //     emit(UnAuthenticated());
    //     // await FirebaseMessaging.instance.deleteToken();
    //   },
    //   onFailure: (exception) {
    //     // AppToast.showErrorToast(message: exception.toString());
    //   },
    // );
  }

  bool get isAuthenticated => state is Authenticated;
  bool get isGuset => !isAuthenticated;
}
