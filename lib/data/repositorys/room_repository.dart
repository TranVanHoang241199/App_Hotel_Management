// api_room_service.dart
import 'dart:convert';
import 'package:flutter_app_hotel_management/data/models/room_model.dart';
import 'package:flutter_app_hotel_management/routes/api_routes.dart';
import 'package:flutter_app_hotel_management/utils/api_response.dart';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';

class RoomRepository {
  static Future<ApiResponsePagination<RoomModel>> getAllRooms(
      String search, int currentPage, int pageSize) async {
    try {
      SharedPreferences prefs = await SharedPreferences.getInstance();
      String? accessToken = prefs.getString('accessToken');

      final response = await http.get(
        Uri.parse(
          '${ApiRoutes.apiUrl_room_GetAllRooms}?currentPage=$currentPage&pageSize=$pageSize',
        ),
        headers: {
          'Authorization': 'Bearer ${accessToken}',
        },
      );

      print('Request Headers: ${response.request?.headers}');
      print('Request Headers: ${response.request?.url}');

      if (response.statusCode == 200) {
        final Map<String, dynamic> responseData = json.decode(response.body);

        final List<dynamic> roomsData = responseData['data'] ?? [];
        final List<RoomModel> rooms = roomsData
            .map((room) => RoomModel.fromJson(room))
            .toList(); // Map directly to List<RoomModel>

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
}
