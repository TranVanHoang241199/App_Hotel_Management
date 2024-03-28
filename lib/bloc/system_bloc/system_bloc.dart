import 'dart:async';

import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:rxdart/rxdart.dart';

import '../../data/repositorys/category_room_repository.dart';
import '../../data/repositorys/category_service_repository.dart';
import '../../data/repositorys/room_repository.dart';
import '../../data/repositorys/service_repository.dart';
import '../../utils/utils.dart';
import 'system.dart';

class SystemBloc extends Bloc<SystemEvent, SystemState> {
  final CategoryRoomRepository categoryRoomRepo;
  final RoomRepository roomRepo;
  final CategoryServiceRepository categoryServiceRepo;
  final ServiceRepository serviceRepo;

  final _categoryRoomNameSubject = BehaviorSubject<String>();
  final _categoryServiceNameSubject = BehaviorSubject<String>();

  SystemBloc(
      {required SystemState initState,
      required this.categoryRoomRepo,
      required this.roomRepo,
      required this.categoryServiceRepo,
      required this.serviceRepo})
      : super(SystemInitState());

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
    if (event is SystemCategoryServiceStartEvent) {
      yield* _mapSystemCategoryServiceStartToState();
    } else if (event is SystemCategoryServiceCreatePressed) {
      yield* _mapSystemCategoryServiceCreateEvent(event);
    } else if (event is SystemCategoryServiceDeletePressed) {
      yield* _mapSystemCategoryServiceDeleteEvent(event);
    }
    // End: CategoryService

    /// Begin: service
    else if (event is SystemServiceStartEvent) {
      yield* _mapSystemServiceStartToState();
    } else if (event is SystemCategoryServiceSelectEvent) {
      yield* _mapSystemCategoryServiceSelectToState();
    } else if (event is SystemServiceCreatePressedEvent) {
      yield* _mapSystemServiceCreateState(event);
    } else if (event is SystemServiceUpdatePressedEvent) {
      yield* _mapSystemServiceUpdateState(event);
    } else if (event is SystemServiceDeletePressedEvent) {
      yield* _mapSystemDeleteState(event);
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
      } else {
        // Xử lý khi thêm thất bại

        yield SystemCategoryRoomCreatetUpdateErrorState(
            'cap nhat thông tin thất bại: (${response.status.toString()}): ${response.message}',
            event.categoryName);
      }
      yield* _mapSystemCategoryRoomStartToState();
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
      } else {
        // Xử lý khi xóa thất bại
        yield SystemCategoryRoomDeleteErrorState(
            'Failed to delete category room. Status Code: ${response.status}');
      }
      yield* _mapSystemCategoryRoomStartToState();
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
      final response = await roomRepo.addRoom(event.roomModel);
      if (response.status == 200) {
        // Xử lý khi thêm thành công
        yield SystemRoomMessageSuccessState('thanh cong');
      } else {
        // Xử lý khi thêm thất bại

        yield SystemRoomCreatetUpdateErrorState(
            'cap nhat thông tin thất bại: (${response.status.toString()}): ${response.message}',
            event.roomModel.roomName);
      }
      yield* _mapSystemRoomStartToState();
    } catch (e) {
      // Xử lý khi có lỗi xảy ra
      print(e);
      yield SystemRoomCreatetUpdateErrorState('An error occurred: $e', "");
    }
  }

  Stream<SystemState> _mapSystemRoomUpdateState(event) async* {
    yield SystemRoomLoadingState();

    try {
      final response = await roomRepo.addRoom(event.roomModel);
      if (response.status == 200) {
        // Xử lý khi thêm thành công
        yield SystemRoomMessageSuccessState('thanh cong');
      } else {
        // Xử lý khi thêm thất bại

        yield SystemRoomCreatetUpdateErrorState(
            'cap nhat thông tin thất bại: (${response.status.toString()}): ${response.message}',
            event.categoryName);
      }
      yield* _mapSystemRoomStartToState();
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
      } else {
        // Xử lý khi xóa thất bại
        yield SystemRoomDeleteErrorState(
            'Failed to delete category room. Status Code: ${response.status}');
      }
      yield* _mapSystemRoomStartToState();
    } catch (e) {
      // Xử lý khi có lỗi xảy ra
      yield SystemRoomDeleteErrorState('An error occurred: $e');
    }
  }
  // End: Room

  // Begin: Category service
  Stream<SystemState> _mapSystemCategoryServiceStartToState() async* {
    yield SystemCategoryServiceLoadingState();
    try {
      final response =
          await categoryServiceRepo.getAllCategoryServices("", 1, 10);

      if (response.status == 200) {
        if (response.data?.length == 0) {
          yield SystemCategoryServiceNoDataState("khong co du lieu");
        } else {
          yield SystemCategoryServiceDataSuccessState(response.data!);
        }
      } else {
        yield SystemCategoryServiceDataErrorState(
            'lấy thông tin thất bại: (${response.status.toString()}): ${response.message}');
      }
    } catch (e) {
      yield SystemCategoryServiceDataErrorState('An error occurred: $e');
    }
  }

  Stream<SystemState> _mapSystemCategoryServiceCreateEvent(event) async* {
    yield SystemCategoryServiceLoadingState();

    try {
      // Thực hiện các thao tác liên quan đến việc tạo mới danh mục phòng ở đây

      // Ví dụ:
      //Gọi hàm từ Repository để thêm danh mục phòng
      final response =
          await categoryServiceRepo.addCategoryService(event.categoryName);
      if (response.status == 200) {
        // Xử lý khi thêm thành công
        yield SystemCategoryServiceMessageSuccessState(
            event.categoryName + 'thanh cong');
      } else {
        // Xử lý khi thêm thất bại

        yield SystemCategoryServiceCreatetUpdateErrorState(
            'cap nhat thông tin thất bại: (${response.status.toString()}): ${response.message}',
            event.categoryName);
      }
      yield* _mapSystemCategoryServiceStartToState();
    } catch (e) {
      // Xử lý khi có lỗi xảy ra
      yield SystemCategoryServiceCreatetUpdateErrorState(
          'An error occurred: $e', "");
    }
  }

  Stream<SystemState> _mapSystemCategoryServiceDeleteEvent(
      SystemCategoryServiceDeletePressed event) async* {
    yield SystemCategoryServiceLoadingState();

    try {
      // Gọi hàm từ Repository để xóa danh mục phòng
      final response =
          await categoryServiceRepo.deleteCategoryService(event.id);

      if (response.status == 200 && response.data == true) {
        // Xóa thành công, cập nhật lại danh sách danh mục phòng
        yield SystemCategoryServiceMessageSuccessState("xoa thanh cong");
      } else {
        // Xử lý khi xóa thất bại
        yield SystemCategoryServiceDeleteErrorState(
            'Failed to delete category Service. Status Code: ${response.status}');
      }
      yield* _mapSystemCategoryServiceStartToState();
    } catch (e) {
      // Xử lý khi có lỗi xảy ra
      yield SystemCategoryServiceDeleteErrorState('An error occurred: $e');
    }
  }
  // End: Category service

  // Begin: service
  Stream<SystemState> _mapSystemServiceStartToState() async* {
    yield SystemServiceLoadingState();
    try {
      final response = await serviceRepo.getAllServices(0, "", 1, 10);

      if (response.status == 200) {
        if (response.data?.length == 0) {
          yield SystemServiceNoDataState("khong co du lieu");
        } else {
          yield SystemServiceDataSuccessState(response.data!);
        }
      } else {
        yield SystemServiceDataErrorState(
            'lấy thông tin thất bại: (${response.status.toString()}): ${response.message}');
      }
    } catch (e) {
      yield SystemServiceDataErrorState('An error occurred: $e');
    }
  }

  Stream<SystemState> _mapSystemCategoryServiceSelectToState() async* {
    yield SystemServiceLoadingState();
    try {
      final response =
          await categoryServiceRepo.getAllCategoryServices("", 1, 10);

      if (response.status == 200) {
        if (response.data?.length == 0) {
          yield SystemCategoryServiceNoDataSelectState("khong co du lieu");
        } else {
          yield SystemCategoryServiceDataSelectSuccessState(response.data!);
        }
      } else {
        yield SystemCategoryServiceDataSelectErrorState(
            'lấy thông tin thất bại: (${response.status.toString()}): ${response.message}');
      }
    } catch (e) {
      yield SystemCategoryServiceDataErrorState('An error occurred: $e');
    }
  }

  Stream<SystemState> _mapSystemServiceCreateState(event) async* {
    yield SystemServiceLoadingState();

    try {
      final response = await serviceRepo.addService(event.serviceModel);
      if (response.status == 200) {
        // Xử lý khi thêm thành công
        yield SystemServiceMessageSuccessState('thanh cong');
      } else {
        // Xử lý khi thêm thất bại

        yield SystemServiceCreatetUpdateErrorState(
            'cap nhat thông tin thất bại: (${response.status.toString()}): ${response.message}',
            event.ServiceModel.ServiceName);
      }
      yield* _mapSystemServiceStartToState();
    } catch (e) {
      // Xử lý khi có lỗi xảy ra
      print(e);
      yield SystemServiceCreatetUpdateErrorState('An error occurred: $e', "");
    }
  }

  Stream<SystemState> _mapSystemServiceUpdateState(event) async* {
    yield SystemServiceLoadingState();

    try {
      final response = await serviceRepo.addService(event.serviceModel);
      if (response.status == 200) {
        // Xử lý khi thêm thành công
        yield SystemServiceMessageSuccessState('thanh cong');
      } else {
        // Xử lý khi thêm thất bại

        yield SystemServiceCreatetUpdateErrorState(
            'cap nhat thông tin thất bại: (${response.status.toString()}): ${response.message}',
            event.categoryName);
      }
      yield* _mapSystemServiceStartToState();
    } catch (e) {
      // Xử lý khi có lỗi xảy ra
      yield SystemServiceCreatetUpdateErrorState('An error occurred: $e', "");
    }
  }

  Stream<SystemState> _mapSystemServiceDeleteState(event) async* {
    yield SystemServiceLoadingState();

    try {
      // Gọi hàm từ Repository để xóa danh mục phòng
      final response = await serviceRepo.deleteService(event.id);

      if (response.status == 200 && response.data == true) {
        // Xóa thành công, cập nhật lại danh sách danh mục phòng
        yield SystemServiceMessageSuccessState("xoa thanh cong");
      } else {
        // Xử lý khi xóa thất bại
        yield SystemServiceDeleteErrorState(
            'Failed to delete category Service. Status Code: ${response.status}');
      }
      yield* _mapSystemServiceStartToState();
    } catch (e) {
      // Xử lý khi có lỗi xảy ra
      yield SystemServiceDeleteErrorState('An error occurred: $e');
    }
  }
  // End: service

  var categoryRoomNameValidation =
      StreamTransformer<String, String>.fromHandlers(
          handleData: (username, sink) {
    sink.add(Validation.validateCategoryRoomName(username));
  });

  Stream<String> get categoryRoomNameStream =>
      _categoryRoomNameSubject.stream.transform(categoryRoomNameValidation);
  Sink<String> get categoryRoomNameSink => _categoryRoomNameSubject.sink;

  var categoryServiceNameValidation =
      StreamTransformer<String, String>.fromHandlers(
          handleData: (username, sink) {
    sink.add(Validation.validateCategoryServiceName(username));
  });

  Stream<String> get categoryServiceNameStream =>
      _categoryServiceNameSubject.stream
          .transform(categoryServiceNameValidation);
  Sink<String> get categoryServiceNameSink => _categoryServiceNameSubject.sink;

  @override
  Future<void> close() {
    // login
    _categoryRoomNameSubject.close();
    _categoryServiceNameSubject.close();
    return super.close();
  }
}
