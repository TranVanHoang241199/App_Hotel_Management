import 'dart:convert';

import 'package:shared_preferences/shared_preferences.dart';
import 'package:http/http.dart' as http;

import '../../routes/api_routes.dart';
import '../../utils/utils.dart';
import '../models/category_service_model.dart';

class CategoryServiceRepository {
  Future<ApiResponsePagination<CategoryServiceModel>> getAllCategoryServices(
      String search, int currentPage, int pageSize) async {
    try {
      SharedPreferences prefs = await SharedPreferences.getInstance();
      String? accessToken = prefs.getString('accessToken');

      final response = await http.get(
        Uri.parse(
            '${ApiRoutes.apiUrl_CategoryService}?&search=$search&currentPage=$currentPage&pageSize=$pageSize'),
        headers: {
          'accept': 'application/json',
          'Authorization': 'Bearer $accessToken',
        },
      );

      if (response.statusCode == 200) {
        final Map<String, dynamic> responseData = json.decode(response.body);

        final List<dynamic> categoryServicesData = responseData['data'] ?? [];
        final List<CategoryServiceModel> categoryServices = categoryServicesData
            .map((service) => CategoryServiceModel.fromJson(service))
            .toList(); // Map directly to List<ServiceModel>

        final meta = PaginationMeta(
          totalItems: responseData['totalItems'] ?? 0,
          currentPage: responseData['currentPage'] ?? 0,
          pageSize: responseData['pageSize'] ?? 0,
        );

        return ApiResponsePagination<CategoryServiceModel>(
          data: categoryServices,
          status: response.statusCode,
          meta: meta,
        );
      } else {
        return ApiResponsePagination<CategoryServiceModel>(
          status: response.statusCode,
          data: null,
          meta: PaginationMeta(
            totalItems: 0,
            currentPage: 0,
            pageSize: 0,
          ),
          message: 'Failed to load data. Status Code: ${response.statusCode}',
        );
      }
    } catch (error) {
      return ApiResponsePagination<CategoryServiceModel>(
        status: 500,
        data: null,
        meta: PaginationMeta(
          totalItems: 0,
          currentPage: 0,
          pageSize: 0,
        ),
        message: 'Error: $error',
      );
    }
  }

  Future<ApiResponse<CategoryServiceModel>> addCategoryService(
      String categoryName) async {
    try {
      SharedPreferences prefs = await SharedPreferences.getInstance();
      String? accessToken = prefs.getString('accessToken');

      final response = await http.post(
        Uri.parse(ApiRoutes.apiUrl_CategoryService),
        headers: {
          'accept': 'application/json',
          'Authorization': 'Bearer $accessToken',
          'Content-Type': 'application/json',
        },
        body: jsonEncode({
          'categoryname': categoryName,
        }),
      );

      if (response.statusCode == 200) {
        final Map<String, dynamic> responseData = json.decode(response.body);

        final dynamic categoryServiceData = responseData['data'] ?? [];
        final CategoryServiceModel categoryService =
            CategoryServiceModel.fromJson(categoryServiceData);

        return ApiResponse<CategoryServiceModel>(
          data: categoryService,
          message: responseData['message'],
          status: response.statusCode,
        );
      } else {
        return ApiResponse<CategoryServiceModel>(
          data: null,
          message:
              'Failed to add Category Service. Status Code: ${response.statusCode}',
          status: response.statusCode,
        );
      }
    } catch (error) {
      return ApiResponse<CategoryServiceModel>(
        data: null,
        message: 'Error: $error',
        status: 500,
      );
    }
  }

  Future<ApiResponse<bool>> updateCategoryService(
      String ServiceId, String categoryName) async {
    try {
      SharedPreferences prefs = await SharedPreferences.getInstance();
      String? accessToken = prefs.getString('accessToken');

      final response = await http.put(
        Uri.parse('${ApiRoutes.apiUrl_CategoryService}/$ServiceId'),
        headers: {
          'accept': 'application/json',
          'Authorization': 'Bearer $accessToken',
          'Content-Type': 'application/json',
        },
        body: jsonEncode({
          'categoryname': categoryName,
        }),
      );

      if (response.statusCode == 200) {
        return ApiResponse<bool>(
          data: true,
          message: 'Category Service updated successfully.',
          status: response.statusCode,
        );
      } else {
        return ApiResponse<bool>(
          data: false,
          message:
              'Failed to update Category Service. Status Code: ${response.statusCode}',
          status: response.statusCode,
        );
      }
    } catch (error) {
      return ApiResponse<bool>(
        data: false,
        message: 'Error: $error',
        status: 500,
      );
    }
  }

  Future<ApiResponse<bool>> deleteCategoryService(String ServiceId) async {
    try {
      SharedPreferences prefs = await SharedPreferences.getInstance();
      String? accessToken = prefs.getString('accessToken');

      final response = await http.delete(
        Uri.parse('${ApiRoutes.apiUrl_CategoryService}/$ServiceId'),
        headers: {
          'accept': 'text/plain',
          'Authorization': 'Bearer $accessToken',
        },
      );

      if (response.statusCode == 200) {
        // Trả về true khi xóa thành công
        return ApiResponse<bool>(
          data: true,
          message: 'Category Service deleted successfully.',
          status: response.statusCode,
        );
      } else {
        // Trả về false khi xóa thất bại
        return ApiResponse<bool>(
          data: false,
          message:
              'Failed to delete Category Service. Status Code: ${response.statusCode}',
          status: response.statusCode,
        );
      }
    } catch (error) {
      return ApiResponse<bool>(
        data: false,
        message: 'Error: $error',
        status: 500,
      );
    }
  }
}
