// Base
// class ApiResponse {
//   int? status;
//   String? message;

//   ApiResponse({this.status, this.message});

//   factory ApiResponse.fromJson(Map<String, dynamic> json) {
//     return ApiResponse(
//       status: json['status'],
//       message: json['message'],
//     );
//   }
// }

class ApiResponse<T> {
  int? status;
  String? message;
  T? data;

  ApiResponse({this.status, this.message, this.data});

  factory ApiResponse.fromJson(
      Map<String, dynamic> json, T Function(dynamic)? fromJsonT) {
    return ApiResponse(
      status: json['status'],
      message: json['message'],
      data: fromJsonT != null ? fromJsonT(json['data']) : null,
    );
  }
}

// Login
class ApiResponseAuth extends ApiResponse {
  String? accessToken;

  ApiResponseAuth({int? status, String? accessToken, String? message})
      : super(status: status, message: message) {
    this.accessToken = accessToken;
  }

  factory ApiResponseAuth.fromJson(Map<String, dynamic> json) {
    return ApiResponseAuth(
      status: json['status'],
      accessToken: json['accessToken'],
      message: json['message'],
    );
  }
}

// tra ve object dung trong post tra ve
// Update ApiResponseObject
class ApiResponseObject<T> extends ApiResponse<T> {
  ApiResponseObject({int? status, T? data, String? message})
      : super(status: status, message: message, data: data);

  factory ApiResponseObject.fromJson(
      Map<String, dynamic> json, T Function(dynamic)? fromJsonT) {
    return ApiResponseObject(
      status: json['status'],
      data: fromJsonT != null ? fromJsonT(json['data']) : null,
      message: json['message'],
    );
  }
}

// Update ApiResponseList
class ApiResponseList<T> extends ApiResponse<List<T>> {
  ApiResponseList({int? status, List<T>? data, String? message})
      : super(status: status, message: message, data: data);

  factory ApiResponseList.fromJson(
      Map<String, dynamic> json, T Function(dynamic)? fromJsonT) {
    return ApiResponseList(
      status: json['status'],
      data: List<T>.from(json['data'].map((item) => fromJsonT!(item))),
      message: json['message'],
    );
  }
}

// Update ApiResponsePagination
class ApiResponsePagination<T> extends ApiResponse<List<T>> {
  PaginationMeta? meta;

  ApiResponsePagination(
      {int? status, List<T>? data, PaginationMeta? meta, String? message})
      : super(status: status, message: message, data: data) {
    this.meta = meta;
  }

  factory ApiResponsePagination.fromJson(
      Map<String, dynamic> json, T Function(dynamic)? fromJsonT) {
    return ApiResponsePagination(
      status: json['status'],
      data: List<T>.from(json['data'].map((item) => fromJsonT!(item))),
      meta: PaginationMeta.fromJson(json['meta']),
      message: json['message'],
    );
  }
}

class PaginationMeta {
  late int totalItems;
  late int totalPage;
  late int currentPage;
  late int pageSize;

  PaginationMeta(
      {required this.totalItems,
      required this.currentPage,
      required this.pageSize});

  factory PaginationMeta.fromJson(Map<String, dynamic> json) {
    return PaginationMeta(
      totalItems: json['totalItems'],
      currentPage: json['currentPage'],
      pageSize: json['pageSize'],
    );
  }
}

// Tính chất generics của Dart giúp chúng ta linh hoạt hóa lớp ApiResponseError.
// Bạn có thể mở rộng chức năng này tùy thuộc vào cấu trúc của lớp ApiResponseError của bạn.
class ApiResponseError extends ApiResponse {
  List<Map<String, String>>? errorDetail;

  ApiResponseError(
      {int? status, String? message, List<Map<String, String>>? errorDetail})
      : super(status: status, message: message) {
    this.errorDetail = errorDetail;
  }

  factory ApiResponseError.fromJson(Map<String, dynamic> json) {
    return ApiResponseError(
      status: json['status'],
      message: json['message'],
      errorDetail: json['errorDetail'] != null
          ? List<Map<String, String>>.from(
              json['errorDetail'].map((item) => Map<String, String>.from(item)))
          : null,
    );
  }
}
