import 'package:flutter_bloc/flutter_bloc.dart';

import 'package:flutter_app_hotel_management/bloc/home_bloc/home.dart';
import 'package:flutter_app_hotel_management/data/repositorys/room_repository.dart';
import '../../data/repositorys/customer_repository.dart';
import '../../data/repositorys/service_repository.dart';

class HomeBloc extends Bloc<HomeEvent, HomeState> {
  final RoomRepository roomRepo;
  final ServiceRepository serviceRepo;
  final CustomerRepository customerRepo;

  HomeBloc({
    required HomeState initState,
    required this.roomRepo,
    required this.serviceRepo,
    required this.customerRepo,
  }) : super(HomeInitState());

  @override
  Stream<HomeState> mapEventToState(HomeEvent event) async* {
    if (event is HomeRoomStartEvent) {
      yield* _mapHomeRoomStartToState();
    } else if (event is HomeServiceStartEvent) {
      yield* _mapHomeServiceStartToState();
    } else if (event is HomeCustomerStartEvent) {
      yield* _mapHomeCustomerStartToState();
    }
  }

  Stream<HomeState> _mapHomeRoomStartToState() async* {
    yield HomeRoomLoadingState(); // Trạng thái đang tải

    try {
      // Gọi hàm lấy danh sách phòng từ repository
      final response = await roomRepo.getAllRooms(0, "", 1, 10);

      if (response.status == 200) {
        // Nếu lấy dữ liệu thành công
        if (response.data?.length == 0)
          yield HomeRoomNoDataState("không có dữ liệu");
        else
          yield HomeRoomSuccessState(response.data!);
      } else {
        // Nếu có lỗi khi lấy dữ liệu
        yield HomeRoomErrorState(
            'lấy thông tin thất bại: (${response.status.toString()}): ${response.message}');
      }
    } catch (e) {
      // Nếu xảy ra lỗi không mong muốn
      yield HomeRoomErrorState('An error occurred: $e');
    }
  }

  Stream<HomeState> _mapHomeServiceStartToState() async* {
    yield HomeServiceLoadingState();

    try {
      // Gọi hàm lấy danh sách phòng từ repository
      final response = await serviceRepo.getAllServices(0, "", 1, 10);

      if (response.status == 200) {
        // Nếu lấy dữ liệu thành công
        if (response.data?.length == 0) {
          yield HomeServiceNoDataState("không có dữ liệu");
        } else {
          yield HomeServiceSuccessState(response.data!);
        }
      } else {
        // Nếu có lỗi khi lấy dữ liệu
        yield HomeServiceErrorState(
            'lấy thông tin thất bại: (${response.status.toString()}): ${response.message}');
      }
    } catch (e) {
      // Nếu xảy ra lỗi không mong muốn
      yield HomeServiceErrorState('An error occurred: $e');
    }
  }

  Stream<HomeState> _mapHomeCustomerStartToState() async* {
    yield HomeCustomerLoadingState();

    try {
      // Gọi hàm lấy danh sách phòng từ repository
      final response = await customerRepo.getAllCustomers("", 1, 10);

      if (response.status == 200) {
        // Nếu lấy dữ liệu thành công
        if (response.data?.length == 0)
          yield HomeCustomerNoDataState("không có dữ liệu");
        else
          yield HomeCustomerSuccessState(response.data!);
      } else {
        // Nếu có lỗi khi lấy dữ liệu
        yield HomeCustomerErrorState(
            'lấy thông tin thất bại: (${response.status.toString()}): ${response.message}');
      }
    } catch (e) {
      // Nếu xảy ra lỗi không mong muốn
      yield HomeCustomerErrorState('An error occurred: $e');
    }
  }
}
