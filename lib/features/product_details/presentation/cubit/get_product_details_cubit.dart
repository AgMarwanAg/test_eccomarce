import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:test_eccomarce/features/product_details/data/repo/product_details_repo.dart';
import 'package:test_eccomarce/shared/dio_client/api_exception.dart';
import 'package:test_eccomarce/shared/mixin/cancelable_cubit_mixin.dart';
import 'package:test_eccomarce/shared/models/product_model.dart';

part 'get_product_details_state.dart';

class GetProductDetailsCubit extends Cubit<GetProductDetailsState> with CancelableCubitMixin{
  final ProductDetailsRepo _repo;
  GetProductDetailsCubit(this._repo) : super(GetProductDetailsInitial());

  void getData(int id)async{
 emit(GetProductDetailsLoading());
    final result = await runCancellable(_repo.getProduct(id));
    if (result != null) {
      result.fold(
        onSuccess: (data) => emit(GetProductDetailsSuccess(data)),
        onFailure: (exception) => emit(GetProductDetailsFailure(exception)),
      );
    }
  }
}  
