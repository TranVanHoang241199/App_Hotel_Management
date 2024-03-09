import 'dart:convert';
import 'package:flutter_app_hotel_management/data/models/user_model.dart';
import 'package:flutter_app_hotel_management/routes/api_routes.dart';
import 'package:flutter_app_hotel_management/utils/api_response.dart';
import 'package:http/http.dart' as http;

class AuthRepository {
  static const Map<String, String> _headers = {
    "Content-Type": "application/json",
  };

  Future<ApiResponseAuth> loginUser(String username, String password) async {
    final Map<String, String> data = {
      "userName": username,
      "password": password,
    };
    try {
      final response = await http.post(
        Uri.parse(ApiRoutes.apiUrl_auth_login), // link api
        headers: _headers,
        body: jsonEncode(data),
      );

      final responseData = jsonDecode(response.body);
      if (response.statusCode == 200) {
        return ApiResponseAuth.fromJson(responseData);
      } else {
        return ApiResponseAuth(
            status: response.statusCode, message: responseData['message']);
      }
    } catch (error) {
      return ApiResponseAuth(
        status: 500,
        message: 'Error occurred while processing the request.',
      );
    }
  }

  Future<ApiResponse<UserModel>> registerUser(UserModel model) async {
    try {
      final response = await http.post(
        Uri.parse(ApiRoutes.apiUrl_auth_register),
        headers: _headers,
        body: jsonEncode(model.toJson()),
      );

      final responseData = jsonDecode(response.body);

      return response.statusCode == 200
          ? ApiResponse<UserModel>(
              status: 200,
              data: UserModel.fromJson(responseData['data']),
              message: "Success",
            )
          : ApiResponse<UserModel>(
              status: response.statusCode,
              message: responseData['message'],
            );
    } catch (error) {
      return ApiResponse<UserModel>(
        status: 500,
        message: 'Error occurred while processing the request.',
      );
    }
  }

  // static Future<ApiResponse<Int>> checkUsername(String username) async {
  //   try {
  //     final response = await http.get(
  //       Uri.parse('${ApiRoutes.apiUrl_auth_getUsername}?usename=$username'),
  //       headers: _headers,
  //     );

  //     final responseData = jsonDecode(response.body);

  //     return response.statusCode == 200
  //         ? ApiResponse<Int>(
  //             status: 200,
  //             data: responseData['data'],
  //             message: "Success",
  //           )
  //         : ApiResponse<Int>(
  //             status: response.statusCode,
  //             message: responseData['message'],
  //           );
  //   } catch (error) {
  //     return ApiResponse<Int>(
  //       status: 500,
  //       message: 'Error occurred while processing the request.',
  //     );
  //   }
  // }
}
