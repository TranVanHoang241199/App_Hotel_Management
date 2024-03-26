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
}
