// import 'package:equatable/equatable.dart';
// import 'package:flutter_bloc/flutter_bloc.dart';
// import 'package:talqah_refactor/core/logging/logger.dart';
// import 'package:talqah_refactor/features/vendor/data/models/vendor_model.dart';
// import 'package:talqah_refactor/features/vendor/data/models/vendors_home_model.dart';
// import 'package:talqah_refactor/features/vendor/data/repo/vendor_repo.dart';
// import 'package:talqah_refactor/shared/dio_client/api_exception.dart';
// import 'package:talqah_refactor/shared/utils/execute_with_retry.dart';
// import 'package:talqah_refactor/shared/widget/image_slider/ads.dart';

// import '../../../data/models/vendor_filter_model.dart';

// part 'get_vendors_state.dart';

// class GetVendorsCubit extends Cubit<GetVendorsState> {
//   final VendorRepo _repo;
//   GetVendorsCubit(this._repo) : super(GetVendorsInitial());
//   VendorFilterModel _model = VendorFilterModel.empty();

//   VendorFilterModel get model => _model;

//   int _currentPage = 1;
//   bool _isLastPage = false;
//   bool _isLoading = false;
//   final List<VendorModel> _allResults = [];
//   List<AdsModel> _currentAds = [];

//   Future<void> getVendors(int id, {bool reset = true}) async {
//   // Guard to prevent concurrent requests remains the same.
//   if (_isLoading) return;

//   _isLoading = true;

//   // State reset logic for pagination remains the same.
//   if (reset) {
//     _currentPage = 1;
//     _isLastPage = false;
//     _allResults.clear();
//     emit(GetVendorsLoading());
//   }

//   await executeWithRetry(
//     action: () => _repo.getVendors(id: id, model: _model.copyWith(page: _currentPage)),
    
//     onFailure: (error) {
//       emit(GetVendorsFailure(error));
//     },

//     onSuccess: (data) {
//       _isLastPage = data.vendors.isEmpty || data.vendors.length < 15;
//       _allResults.addAll(data.vendors);

//       if (reset || _currentAds.isEmpty) {
//         _currentAds = data.ads;
//       }

//       final VendorsHomeModel currentVendorsHomeModel = VendorsHomeModel(
//         vendors: List.unmodifiable(_allResults),
//         ads: List.unmodifiable(_currentAds),
//       );
//       emit(GetVendorsSuccess(
//         currentVendorsHomeModel,
//         hasReachedMax: _isLastPage,
//       ));

//       if (!_isLastPage) _currentPage++;
//     },
//   );
//   _isLoading = false;
// }

//   Future<void> loadMore(int id, {required VendorFilterModel model}) async {
//     if (_isLastPage || _isLoading) return;
//     Logger.debug(_model.toMap());

//     await getVendors(id, reset: false);
//   }

//   void updateModel(VendorFilterModel newModel) {
//     _model = newModel;
//     Logger.debug(_model.toMap());
//     // getVendors(_serviceId, model: _model); // Pass updated model
//   }
// }
