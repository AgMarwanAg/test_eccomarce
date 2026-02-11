 import 'package:test_eccomarce/features/product_details/data/product_details_apis.dart';
import 'package:test_eccomarce/shared/dio_client/response_model.dart';
import 'package:test_eccomarce/shared/dio_client/result.dart';
import 'package:test_eccomarce/shared/models/product_model.dart';

abstract class ProductDetailsRepo {
  Future<Result<ProductModel>> getProduct(int id);
}

class ProductDetailsRepoImpl implements ProductDetailsRepo{
  final ProductDetailsApis _apis;
  ProductDetailsRepoImpl(this._apis);
  @override
  Future<Result<ProductModel>> getProduct(int id) {
    return Result.handleApiResponse(_apis.getProduct(id), (data) {
      ResponseModel responseBody=ResponseModel.fromJson(data);
      return ProductModel.fromJson(responseBody.data);
    },);
  }

}