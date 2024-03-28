import 'dart:convert';
import 'package:flutter_app_hotel_management/data/models/room_model.dart';
import 'package:flutter_app_hotel_management/routes/api_routes.dart';
import 'package:flutter_app_hotel_management/utils/api_response.dart';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';

class RoomRepository {
  Future<ApiResponsePagination<RoomModel>> getAllRooms(
      int status, String search, int currentPage, int pageSize) async {
    try {
      SharedPreferences prefs = await SharedPreferences.getInstance();
      String? accessToken = prefs.getString('accessToken');

      final response = await http.get(
        Uri.parse(
            '${ApiRoutes.apiUrl_room}?status=$status&search=$search&currentPage=$currentPage&pageSize=$pageSize'),
        headers: {
          'accept': 'application/json',
          'Authorization': 'Bearer $accessToken',
        },
      );
      print(" repo1------------" + response.statusCode.toString());
      if (response.statusCode == 200) {
        final Map<String, dynamic> responseData = json.decode(response.body);

        final List<dynamic> roomsData = responseData['data'] ?? [];
        print(" repo2------------" + roomsData.toString());
        final List<RoomModel> rooms = roomsData
            .map((room) => RoomModel.fromJson(room))
            .toList(); // Map directly to List<RoomModel>
        print(" repo2------------" + rooms.length.toString());

        final meta = PaginationMeta(
          totalItems: responseData['totalItems'] ?? 0,
          currentPage: responseData['currentPage'] ?? 0,
          pageSize: responseData['pageSize'] ?? 0,
        );

        return ApiResponsePagination<RoomModel>(
          data: rooms,
          status: response.statusCode,
          meta: meta,
        );
      } else {
        return ApiResponsePagination<RoomModel>(
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
      return ApiResponsePagination<RoomModel>(
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

  Future<ApiResponse<RoomModel>> addRoom(RoomModel roomModel) async {
    try {
      SharedPreferences prefs = await SharedPreferences.getInstance();
      String? accessToken = prefs.getString('accessToken');
      print(" chuc mung vao repo -----------------");
      final response = await http.post(
        Uri.parse(ApiRoutes.apiUrl_room),
        headers: {
          'accept': 'application/json',
          'Authorization': 'Bearer $accessToken',
          'Content-Type': 'application/json',
        },
        body: jsonEncode(roomModel
            .toJson()), // Sử dụng phương thức toJson của RoomModel để chuyển đổi thành JSON
      );

      if (response.statusCode == 200) {
        final Map<String, dynamic> responseData = json.decode(response.body);

        final dynamic roomData = responseData['data'] ?? {};
        final RoomModel room = RoomModel.fromJson(roomData);

        return ApiResponse<RoomModel>(
          data: room,
          message: responseData['message'],
          status: response.statusCode,
        );
      } else {
        return ApiResponse<RoomModel>(
          data: null,
          message: 'Failed to add Room. Status Code: ${response.statusCode}',
          status: response.statusCode,
        );
      }
    } catch (error) {
      return ApiResponse<RoomModel>(
        data: null,
        message: 'Error: $error',
        status: 500,
      );
    }
  }

  Future<ApiResponse<bool>> updateRoom(
      String roomId, RoomModel roomModel) async {
    try {
      SharedPreferences prefs = await SharedPreferences.getInstance();
      String? accessToken = prefs.getString('accessToken');

      final response = await http.put(
        Uri.parse('${ApiRoutes.apiUrl_room}/$roomId'),
        headers: {
          'accept': 'application/json',
          'Authorization': 'Bearer $accessToken',
          'Content-Type': 'application/json',
        },
        body: jsonEncode(roomModel.toJson()),
      );

      if (response.statusCode == 200) {
        return ApiResponse<bool>(
          data: true,
          message: 'Room updated successfully.',
          status: response.statusCode,
        );
      } else {
        return ApiResponse<bool>(
          data: false,
          message: 'Failed to update Room. Status Code: ${response.statusCode}',
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

  Future<ApiResponse<bool>> deleteRoom(String roomId) async {
    try {
      SharedPreferences prefs = await SharedPreferences.getInstance();
      String? accessToken = prefs.getString('accessToken');

      final response = await http.delete(
        Uri.parse('${ApiRoutes.apiUrl_room}/$roomId'),
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
