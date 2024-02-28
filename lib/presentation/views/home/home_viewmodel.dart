import 'package:flutter_app_hotel_management/data/models/room_model.dart';
import 'package:flutter_app_hotel_management/data/api_services/room_api_service.dart';
import 'package:flutter_app_hotel_management/utils/api_response.dart';

class HomeViewModel {
  List<RoomModel> roomData = [];
  late List<bool> selectedItems;
  final int _pageSize = 10;
  late String search;
  late int currentPage = 1;

  Future<ApiResponsePagination<RoomModel>> getAllRooms(
      String search, int currentPage) async {
    // Sử dụng hàm từ ApiHelper
    return await ApiRoomService.getAllRooms(search, currentPage, _pageSize);
  }
}
