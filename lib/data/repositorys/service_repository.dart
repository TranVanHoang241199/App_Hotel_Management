import 'dart:convert';
import 'package:flutter_app_hotel_management/routes/api_routes.dart';
import 'package:flutter_app_hotel_management/utils/api_response.dart';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';

import '../models/service_model.dart';

class ServiceRepository {
  Future<ApiResponsePagination<ServiceModel>> getAllServices(
      int status, String search, int currentPage, int pageSize) async {
    try {
      SharedPreferences prefs = await SharedPreferences.getInstance();
      String? accessToken = prefs.getString('accessToken');

      final response = await http.get(
        Uri.parse(
            '${ApiRoutes.apiUrl_service}?status=$status&search=$search&currentPage=$currentPage&pageSize=$pageSize'),
        headers: {
          'accept': 'application/json',
          'Authorization': 'Bearer $accessToken',
        },
      );

      if (response.statusCode == 200) {
        final Map<String, dynamic> responseData = json.decode(response.body);

        final List<dynamic> servicesData = responseData['data'] ?? [];
        print(" repo2------------" + servicesData.toString());
        final List<ServiceModel> services = servicesData
            .map((Service) => ServiceModel.fromJson(Service))
            .toList(); // Map directly to List<ServiceModel>

        final meta = PaginationMeta(
          totalItems: responseData['totalItems'] ?? 0,
          currentPage: responseData['currentPage'] ?? 0,
          pageSize: responseData['pageSize'] ?? 0,
        );

        return ApiResponsePagination<ServiceModel>(
          data: services,
          status: response.statusCode,
          meta: meta,
        );
      } else {
        return ApiResponsePagination<ServiceModel>(
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
      return ApiResponsePagination<ServiceModel>(
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

  Future<ApiResponse<ServiceModel>> addService(
      ServiceModel serviceModel) async {
    try {
      SharedPreferences prefs = await SharedPreferences.getInstance();
      String? accessToken = prefs.getString('accessToken');
      print(" chuc mung vao repo -----------------");
      final response = await http.post(
        Uri.parse(ApiRoutes.apiUrl_service),
        headers: {
          'accept': 'application/json',
          'Authorization': 'Bearer $accessToken',
          'Content-Type': 'application/json',
        },
        body: jsonEncode(serviceModel
            .toJson()), // Sử dụng phương thức toJson của ServiceModel để chuyển đổi thành JSON
      );

      if (response.statusCode == 200) {
        final Map<String, dynamic> responseData = json.decode(response.body);

        final dynamic serviceData = responseData['data'] ?? {};
        final ServiceModel Service = ServiceModel.fromJson(serviceData);

        return ApiResponse<ServiceModel>(
          data: Service,
          message: responseData['message'],
          status: response.statusCode,
        );
      } else {
        return ApiResponse<ServiceModel>(
          data: null,
          message: 'Failed to add Service. Status Code: ${response.statusCode}',
          status: response.statusCode,
        );
      }
    } catch (error) {
      return ApiResponse<ServiceModel>(
        data: null,
        message: 'Error: $error',
        status: 500,
      );
    }
  }

  Future<ApiResponse<bool>> updateService(
      String serviceId, ServiceModel serviceModel) async {
    try {
      SharedPreferences prefs = await SharedPreferences.getInstance();
      String? accessToken = prefs.getString('accessToken');

      final response = await http.put(
        Uri.parse('${ApiRoutes.apiUrl_service}/$serviceId'),
        headers: {
          'accept': 'application/json',
          'Authorization': 'Bearer $accessToken',
          'Content-Type': 'application/json',
        },
        body: jsonEncode(serviceModel.toJson()),
      );

      if (response.statusCode == 200) {
        return ApiResponse<bool>(
          data: true,
          message: 'Service updated successfully.',
          status: response.statusCode,
        );
      } else {
        return ApiResponse<bool>(
          data: false,
          message:
              'Failed to update Service. Status Code: ${response.statusCode}',
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

  Future<ApiResponse<bool>> deleteService(String serviceId) async {
    try {
      SharedPreferences prefs = await SharedPreferences.getInstance();
      String? accessToken = prefs.getString('accessToken');

      final response = await http.delete(
        Uri.parse('${ApiRoutes.apiUrl_service}/$serviceId'),
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
