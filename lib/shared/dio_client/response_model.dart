/// A generic model representing a standard response structure with data, message, and success indicators.
/// [note] this class may change based on backend structure
class ResponseModel<T> {
  /// The data data of type T.
  T? data;

  /// A message associated with the response.
  String? message;

  /// Indicates the success status of the response.
  bool? success;

  /// Default constructor for creating a [ResponseModel] instance.
  ResponseModel({this.data, this.message, this.success});

  /// Constructor to create a [ResponseModel] instance from JSON data.
  ResponseModel.fromJson(Map<String, dynamic> json) {
    data = json as T?;
    message = json['message'] as String?;
    success = json['success'] as bool?;
  }
}
