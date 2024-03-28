import 'dart:convert';

import 'package:shared_preferences/shared_preferences.dart';
import 'package:http/http.dart' as http;

import '../../routes/api_routes.dart';
import '../../utils/utils.dart';
import '../models/category_room_model.dart';

class CategoryRoomRepository {
  Future<ApiResponsePagination<CategoryRoomModel>> getAllCategoryRooms(
      String search, int currentPage, int pageSize) async {
    try {
      SharedPreferences prefs = await SharedPreferences.getInstance();
      String? accessToken = prefs.getString('accessToken');

      final response = await http.get(
        Uri.parse(
            '${ApiRoutes.apiUrl_CategoryRoom}?&search=$search&currentPage=$currentPage&pageSize=$pageSize'),
        headers: {
          'accept': 'application/json',
          'Authorization': 'Bearer $accessToken',
        },
      );

      if (response.statusCode == 200) {
        final Map<String, dynamic> responseData = json.decode(response.body);

        final List<dynamic> CategoryRoomsData = responseData['data'] ?? [];
        final List<CategoryRoomModel> CategoryRooms =
            CategoryRoomsData.map((room) => CategoryRoomModel.fromJson(room))
                .toList(); // Map directly to List<RoomModel>

        final meta = PaginationMeta(
          totalItems: responseData['totalItems'] ?? 0,
          currentPage: responseData['currentPage'] ?? 0,
          pageSize: responseData['pageSize'] ?? 0,
        );

        return ApiResponsePagination<CategoryRoomModel>(
          data: CategoryRooms,
          status: response.statusCode,
          meta: meta,
        );
      } else {
        return ApiResponsePagination<CategoryRoomModel>(
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
      return ApiResponsePagination<CategoryRoomModel>(
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

  Future<ApiResponse<CategoryRoomModel>> addCategoryRoom(
      String categoryName) async {
    try {
      SharedPreferences prefs = await SharedPreferences.getInstance();
      String? accessToken = prefs.getString('accessToken');

      final response = await http.post(
        Uri.parse(ApiRoutes.apiUrl_CategoryRoom),
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

        final dynamic categoryRoomData = responseData['data'] ?? [];
        final CategoryRoomModel categoryRoom =
            CategoryRoomModel.fromJson(categoryRoomData);

        return ApiResponse<CategoryRoomModel>(
          data: categoryRoom,
          message: responseData['message'],
          status: response.statusCode,
        );
      } else {
        return ApiResponse<CategoryRoomModel>(
          data: null,
          message:
              'Failed to add Category Room. Status Code: ${response.statusCode}',
          status: response.statusCode,
        );
      }
    } catch (error) {
      return ApiResponse<CategoryRoomModel>(
        data: null,
        message: 'Error: $error',
        status: 500,
      );
    }
  }

  Future<ApiResponse<bool>> updateCategoryRoom(
      String roomId, String categoryName) async {
    try {
      SharedPreferences prefs = await SharedPreferences.getInstance();
      String? accessToken = prefs.getString('accessToken');

      final response = await http.put(
        Uri.parse('${ApiRoutes.apiUrl_CategoryRoom}/$roomId'),
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
          message: 'Category Room updated successfully.',
          status: response.statusCode,
        );
      } else {
        return ApiResponse<bool>(
          data: false,
          message:
              'Failed to update Category Room. Status Code: ${response.statusCode}',
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

  Future<ApiResponse<bool>> deleteCategoryRoom(String roomId) async {
    try {
      SharedPreferences prefs = await SharedPreferences.getInstance();
      String? accessToken = prefs.getString('accessToken');

      final response = await http.delete(
        Uri.parse('${ApiRoutes.apiUrl_CategoryRoom}/$roomId'),
        headers: {
          'accept': 'text/plain',
          'Authorization': 'Bearer $accessToken',
        },
      );

      if (response.statusCode == 200) {
        // Trả về true khi xóa thành công
        return ApiResponse<bool>(
          data: true,
          message: 'Category Room deleted successfully.',
          status: response.statusCode,
        );
      } else {
        // Trả về false khi xóa thất bại
        return ApiResponse<bool>(
          data: false,
          message:
              'Failed to delete Category Room. Status Code: ${response.statusCode}',
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
