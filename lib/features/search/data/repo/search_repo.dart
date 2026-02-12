 import 'package:test_eccomarce/core/logging/logger.dart';
import 'package:test_eccomarce/features/search/data/search_api.dart';
import 'package:test_eccomarce/shared/dio_client/response_model.dart';
import 'package:test_eccomarce/shared/dio_client/result.dart';
import 'package:test_eccomarce/shared/models/product_model.dart';

abstract class SearchRepo {
  Future<Result<List<ProductModel>>> search(String?q,int? skip);
}


class SearchRepoImpl implements SearchRepo {
  final SearchApi _api;
  SearchRepoImpl(this._api);
  @override
  Future<Result<List<ProductModel>>> search(String? q, int? skip) {
    return Result.handleApiResponse(_api.search(q,skip), (data) {
        return ProductModel.fromList((ResponseModel.fromJson(data).data['products']));
    }); 
  }
   
  
}