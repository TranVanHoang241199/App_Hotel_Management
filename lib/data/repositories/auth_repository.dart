import 'package:flutter_app_hotel_management/data/api_services/auth_api_service.dart';
import 'package:flutter_app_hotel_management/data/models/user_model.dart';
import 'package:flutter_app_hotel_management/utils/api_response.dart';

class AuthRepository {
  final AuthApiService _authApiService = AuthApiService();

  Future<ApiResponseAuth> loginUser(String username, String password) async {
    try {
      final apiResponse =
          await _authApiService.authenticateUser(username, password);
      return apiResponse;
    } catch (error) {
      return ApiResponseAuth(
        status: 500,
        message: 'Error occurred while processing the request.',
      );
    }
  }

  Future<ApiResponse<UserModel>> registerUser(UserModel model) async {
    try {
      final apiResponse = await _authApiService.registerNewUser(model);
      return apiResponse;
    } catch (error) {
      return ApiResponse<UserModel>(
        status: 500,
        message: 'Error occurred while processing the request.',
      );
    }
  }
}
