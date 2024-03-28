import 'dart:async';

import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:rxdart/rxdart.dart';

import '../../data/repositorys/category_room_repository.dart';
import '../../data/repositorys/room_repository.dart';
import '../../utils/utils.dart';
import 'system.dart';

class SystemBloc extends Bloc<SystemEvent, SystemState> {
  final CategoryRoomRepository categoryRoomRepo;
  final RoomRepository roomRepo;

  final _categoryRoomNameSubject = BehaviorSubject<String>();

  SystemBloc(
      {required SystemState initState,
      required this.categoryRoomRepo,
      required this.roomRepo})
      : super(SystemInitState()) {}

  @override
  Stream<SystemState> mapEventToState(SystemEvent event) async* {
    // Begin: CategoryRoom
    if (event is SystemCategoryRoomStartEvent) {
      yield* _mapSystemCategoryRoomStartToState();
    } else if (event is SystemCategoryRoomCreatePressed) {
      yield* _mapSystemCategoryRoomCreateEvent(event);
    } else if (event is SystemCategoryRoomDeletePressed) {
      yield* _mapSystemCategoryRoomDeleteEvent(event);
    }
    // End: CategoryRoom

    // Begin: room
    else if (event is SystemRoomStartEvent) {
      yield* _mapSystemRoomStartToState();
    } else if (event is SystemCategoryRoomSelectEvent) {
      yield* _mapSystemCategoryRoomSelectToState();
    } else if (event is SystemRoomCreatePressedEvent) {
      yield* _mapSystemRoomCreateState(event);
    } else if (event is SystemRoomUpdatePressedEvent) {
      yield* _mapSystemRoomUpdateState(event);
    } else if (event is SystemRoomDeletePressedEvent) {
      yield* _mapSystemDeleteState(event);
    }
    // End: room

    // Begin: CategoryService
    else if (event is SystemCategoryServiceStartEvent) {
      yield* _mapSystemRoomStartToState();
    }
    // End: CategoryService

    // Begin: service
    else if (event is SystemServiceStartEvent) {
      yield* _mapSystemServiceStartToState();
    }
    // End: service

    // Begin: cachs tinh tien
    // End: cachs tinh tien
  }

  // Begin: Category Room
  Stream<SystemState> _mapSystemCategoryRoomStartToState() async* {
    yield SystemCategoryRoomLoadingState();
    try {
      final response = await categoryRoomRepo.getAllCategoryRooms("", 1, 10);

      if (response.status == 200) {
        if (response.data?.length == 0) {
          yield SystemCategoryRoomNoDataState("khong co du lieu");
        } else {
          yield SystemCategoryRoomDataSuccessState(response.data!);
        }
      } else {
        yield SystemCategoryRoomDataErrorState(
            'lấy thông tin thất bại: (${response.status.toString()}): ${response.message}');
      }
    } catch (e) {
      yield SystemCategoryRoomDataErrorState('An error occurred: $e');
    }
  }

  Stream<SystemState> _mapSystemCategoryRoomCreateEvent(event) async* {
    yield SystemCategoryRoomLoadingState();

    try {
      // Thực hiện các thao tác liên quan đến việc tạo mới danh mục phòng ở đây

      // Ví dụ:
      //Gọi hàm từ Repository để thêm danh mục phòng
      final response =
          await categoryRoomRepo.addCategoryRoom(event.categoryName);
      if (response.status == 200) {
        // Xử lý khi thêm thành công
        yield SystemCategoryRoomMessageSuccessState(
            event.categoryName + 'thanh cong');
        yield* _mapSystemCategoryRoomStartToState();
      } else {
        // Xử lý khi thêm thất bại

        yield SystemCategoryRoomCreatetUpdateErrorState(
            'cap nhat thông tin thất bại: (${response.status.toString()}): ${response.message}',
            event.categoryName);
      }
    } catch (e) {
      // Xử lý khi có lỗi xảy ra
      yield SystemCategoryRoomCreatetUpdateErrorState(
          'An error occurred: $e', "");
    }
  }

  Stream<SystemState> _mapSystemCategoryRoomDeleteEvent(
      SystemCategoryRoomDeletePressed event) async* {
    yield SystemCategoryRoomLoadingState();

    try {
      // Gọi hàm từ Repository để xóa danh mục phòng
      final response = await categoryRoomRepo.deleteCategoryRoom(event.id);

      if (response.status == 200 && response.data == true) {
        // Xóa thành công, cập nhật lại danh sách danh mục phòng
        yield SystemCategoryRoomMessageSuccessState("xoa thanh cong");
        yield* _mapSystemCategoryRoomStartToState();
      } else {
        // Xử lý khi xóa thất bại
        yield SystemCategoryRoomDeleteErrorState(
            'Failed to delete category room. Status Code: ${response.status}');
      }
    } catch (e) {
      // Xử lý khi có lỗi xảy ra
      yield SystemCategoryRoomDeleteErrorState('An error occurred: $e');
    }
  }
  // End: Category Room

  // Begin: Room
  Stream<SystemState> _mapSystemRoomStartToState() async* {
    yield SystemRoomLoadingState();
    try {
      final response = await roomRepo.getAllRooms(0, "", 1, 10);

      if (response.status == 200) {
        if (response.data?.length == 0) {
          yield SystemRoomNoDataState("khong co du lieu");
        } else {
          yield SystemRoomDataSuccessState(response.data!);
        }
      } else {
        yield SystemRoomDataErrorState(
            'lấy thông tin thất bại: (${response.status.toString()}): ${response.message}');
      }
    } catch (e) {
      yield SystemRoomDataErrorState('An error occurred: $e');
    }
  }

  Stream<SystemState> _mapSystemCategoryRoomSelectToState() async* {
    yield SystemRoomLoadingState();
    try {
      final response = await categoryRoomRepo.getAllCategoryRooms("", 1, 10);

      if (response.status == 200) {
        if (response.data?.length == 0) {
          yield SystemCategoryRoomNoDataSelectState("khong co du lieu");
        } else {
          yield SystemCategoryRoomDataSelectSuccessState(response.data!);
        }
      } else {
        yield SystemCategoryRoomDataSelectErrorState(
            'lấy thông tin thất bại: (${response.status.toString()}): ${response.message}');
      }
    } catch (e) {
      yield SystemCategoryRoomDataErrorState('An error occurred: $e');
    }
  }

  Stream<SystemState> _mapSystemRoomCreateState(event) async* {
    yield SystemRoomLoadingState();

    try {
      final response = await roomRepo.addRoom(event);
      if (response.status == 200) {
        // Xử lý khi thêm thành công
        yield SystemRoomMessageSuccessState(event.categoryName + 'thanh cong');
        yield* _mapSystemRoomStartToState();
      } else {
        // Xử lý khi thêm thất bại

        yield SystemRoomCreatetUpdateErrorState(
            'cap nhat thông tin thất bại: (${response.status.toString()}): ${response.message}',
            event.categoryName);
      }
    } catch (e) {
      // Xử lý khi có lỗi xảy ra
      yield SystemRoomCreatetUpdateErrorState('An error occurred: $e', "");
    }
  }

  Stream<SystemState> _mapSystemRoomUpdateState(event) async* {
    yield SystemRoomLoadingState();

    try {
      final response = await roomRepo.addRoom(event);
      if (response.status == 200) {
        // Xử lý khi thêm thành công
        yield SystemRoomMessageSuccessState(event.categoryName + 'thanh cong');
        yield* _mapSystemRoomStartToState();
      } else {
        // Xử lý khi thêm thất bại

        yield SystemRoomCreatetUpdateErrorState(
            'cap nhat thông tin thất bại: (${response.status.toString()}): ${response.message}',
            event.categoryName);
      }
    } catch (e) {
      // Xử lý khi có lỗi xảy ra
      yield SystemRoomCreatetUpdateErrorState('An error occurred: $e', "");
    }
  }

  Stream<SystemState> _mapSystemDeleteState(event) async* {
    yield SystemRoomLoadingState();

    try {
      // Gọi hàm từ Repository để xóa danh mục phòng
      final response = await roomRepo.deleteRoom(event.id);

      if (response.status == 200 && response.data == true) {
        // Xóa thành công, cập nhật lại danh sách danh mục phòng
        yield SystemRoomMessageSuccessState("xoa thanh cong");
        yield* _mapSystemRoomStartToState();
      } else {
        // Xử lý khi xóa thất bại
        yield SystemRoomDeleteErrorState(
            'Failed to delete category room. Status Code: ${response.status}');
      }
    } catch (e) {
      // Xử lý khi có lỗi xảy ra
      yield SystemRoomDeleteErrorState('An error occurred: $e');
    }
  }
  // End: Room

  _mapSystemCategoryServiceStartToState() {}

  _mapSystemServiceStartToState() {}

  var categoryRoomNameValidation =
      StreamTransformer<String, String>.fromHandlers(
          handleData: (username, sink) {
    sink.add(Validation.validateCategoryRoomName(username));
  });

  Stream<String> get categoryRoomNameStream =>
      _categoryRoomNameSubject.stream.transform(categoryRoomNameValidation);
  Sink<String> get categoryRoomNameSink => _categoryRoomNameSubject.sink;

  @override
  Future<void> close() {
    // login
    _categoryRoomNameSubject.close();
    return super.close();
  }
}
