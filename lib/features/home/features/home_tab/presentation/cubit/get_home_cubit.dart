import 'package:flutter_bloc/flutter_bloc.dart';

import 'package:equatable/equatable.dart';
import 'package:test_eccomarce/features/home/features/home_tab/domain/usecases/get_home_usecase.dart';
import 'package:test_eccomarce/shared/mixin/cancelable_cubit_mixin.dart';

import '../../../../../../shared/dio_client/api_exception.dart';
import '../../domain/entities/home_entity.dart';

part 'get_home_state.dart';

class GetHomeCubit extends Cubit<GetHomeState>
    with CancelableCubitMixin<GetHomeState> {
  final GetHomeUseCase _getHomeUseCase;
  GetHomeCubit(this._getHomeUseCase) : super(GetHomeInitial()) {
    getHome();
  }

  Future<void> getHome() async {
    emit(GetHomeLoading());
    final result = await runCancellable(_getHomeUseCase.call());
    if (result != null) {
      result.fold(
        onSuccess: (data) => emit(GetHomeSuccess(data)),
        onFailure: (exception) => emit(GetHomeError(exception)),
      );
    }
  }
}
