import 'dart:convert';
import 'package:flutter_app_hotel_management/routes/api_routes.dart';
import 'package:flutter_app_hotel_management/utils/api_response.dart';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';

import '../models/customer_model.dart';

class CustomerRepository {
  Future<ApiResponsePagination<CustomerModel>> getAllCustomers(
      String search, int currentPage, int pageSize) async {
    try {
      SharedPreferences prefs = await SharedPreferences.getInstance();
      String? accessToken = prefs.getString('accessToken');

      final response = await http.get(
        Uri.parse(
            '${ApiRoutes.apiUrl_customer}?&search=$search&currentPage=$currentPage&pageSize=$pageSize'),
        headers: {
          'accept': 'application/json',
          'Authorization': 'Bearer $accessToken',
        },
      );

      print("url");
      print(" repo1------------" + response.statusCode.toString());
      if (response.statusCode == 200) {
        final Map<String, dynamic> responseData = json.decode(response.body);

        final List<dynamic> customersData = responseData['data'] ?? [];
        print(" repo2------------" + customersData.toString());
        final List<CustomerModel> customers = customersData
            .map((room) => CustomerModel.fromJson(room))
            .toList(); // Map directly to List<RoomModel>
        print(" repo2------------" + customers.length.toString());

        final meta = PaginationMeta(
          totalItems: responseData['totalItems'] ?? 0,
          currentPage: responseData['currentPage'] ?? 0,
          pageSize: responseData['pageSize'] ?? 0,
        );

        return ApiResponsePagination<CustomerModel>(
          data: customers,
          status: response.statusCode,
          meta: meta,
        );
      } else {
        return ApiResponsePagination<CustomerModel>(
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
      return ApiResponsePagination<CustomerModel>(
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
}
