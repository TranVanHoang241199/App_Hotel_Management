import 'package:equatable/equatable.dart';

import '../../data/models/category_room_model.dart';
import '../../data/models/category_service_model.dart';
import '../../data/models/room_model.dart';
import '../../data/models/service_model.dart';

class SystemState extends Equatable {
  const SystemState();
  @override
  // TODO: implement props
  List<Object?> get props => throw UnimplementedError();
}

class SystemInitState extends SystemState {}

// Begin: Category Room
class SystemCategoryRoomLoadingState extends SystemState {}

class SystemCategoryRoomDataSuccessState extends SystemState {
  final List<CategoryRoomModel> listCategoryRoom;
  const SystemCategoryRoomDataSuccessState(this.listCategoryRoom);
}

class SystemCategoryRoomNoDataState extends SystemState {
  final String message;
  const SystemCategoryRoomNoDataState(this.message);
}

class SystemCategoryRoomDataErrorState extends SystemState {
  final String message;
  const SystemCategoryRoomDataErrorState(this.message);
}

class SystemCategoryRoomSuccessCreateState extends SystemState {
  final CategoryRoomModel categoryRoomModel;
  const SystemCategoryRoomSuccessCreateState(this.categoryRoomModel);
}

class SystemCategoryRoomDeleteSuccessState extends SystemState {
  final String message;
  const SystemCategoryRoomDeleteSuccessState(this.message);
}

class SystemCategoryRoomMessageSuccessState extends SystemState {
  final String message;
  const SystemCategoryRoomMessageSuccessState(this.message);
}

class SystemCategoryRoomCreatetUpdateErrorState extends SystemState {
  final String txtName;
  final String message;
  const SystemCategoryRoomCreatetUpdateErrorState(this.message, this.txtName);
}

class SystemCategoryRoomDeleteErrorState extends SystemState {
  final String message;
  const SystemCategoryRoomDeleteErrorState(this.message);
}

// Begin: Category Room
//--------------------------------------------------------------
// Begin: Room
class SystemRoomLoadingState extends SystemState {}

class SystemRoomDataSuccessState extends SystemState {
  final List<RoomModel> listRoom;
  const SystemRoomDataSuccessState(this.listRoom);
}

class SystemCategoryRoomDataSelectSuccessState extends SystemState {
  final List<CategoryRoomModel> listCategoryRoom;
  const SystemCategoryRoomDataSelectSuccessState(this.listCategoryRoom);
}

class SystemRoomNoDataState extends SystemState {
  final String message;
  const SystemRoomNoDataState(this.message);
}

class SystemCategoryRoomNoDataSelectState extends SystemState {
  final String message;
  const SystemCategoryRoomNoDataSelectState(this.message);
}

class SystemRoomDataErrorState extends SystemState {
  final String message;
  const SystemRoomDataErrorState(this.message);
}

class SystemCategoryRoomDataSelectErrorState extends SystemState {
  final String message;
  const SystemCategoryRoomDataSelectErrorState(this.message);
}

class SystemRoomMessageSuccessState extends SystemState {
  final String message;
  const SystemRoomMessageSuccessState(this.message);
}

class SystemRoomCreatetUpdateErrorState extends SystemState {
  final String txtName;
  final String message;
  const SystemRoomCreatetUpdateErrorState(this.message, this.txtName);
}

class SystemRoomDeleteErrorState extends SystemState {
  final String message;
  const SystemRoomDeleteErrorState(this.message);
}

// End: Room
//--------------------------------------------------------------
// Begin: Category Service
class SystemCategoryServiceLoadingState extends SystemState {}

class SystemCategoryServiceDataSuccessState extends SystemState {
  final List<CategoryServiceModel> listCategoryService;
  const SystemCategoryServiceDataSuccessState(this.listCategoryService);
}

class SystemCategoryServiceNoDataState extends SystemState {
  final String message;
  const SystemCategoryServiceNoDataState(this.message);
}

class SystemCategoryServiceDataErrorState extends SystemState {
  final String message;
  const SystemCategoryServiceDataErrorState(this.message);
}

class SystemCategoryServiceSuccessCreateState extends SystemState {
  final CategoryServiceModel categoryServiceModel;
  const SystemCategoryServiceSuccessCreateState(this.categoryServiceModel);
}

class SystemCategoryServiceDeleteSuccessState extends SystemState {
  final String message;
  const SystemCategoryServiceDeleteSuccessState(this.message);
}

class SystemCategoryServiceMessageSuccessState extends SystemState {
  final String message;
  const SystemCategoryServiceMessageSuccessState(this.message);
}

class SystemCategoryServiceCreatetUpdateErrorState extends SystemState {
  final String txtName;
  final String message;
  const SystemCategoryServiceCreatetUpdateErrorState(
      this.message, this.txtName);
}

class SystemCategoryServiceDeleteErrorState extends SystemState {
  final String message;
  const SystemCategoryServiceDeleteErrorState(this.message);
}

// Begin: Category Service
//--------------------------------------------------------------
// Begin: Service
class SystemServiceLoadingState extends SystemState {}

class SystemServiceDataSuccessState extends SystemState {
  final List<ServiceModel> listService;
  const SystemServiceDataSuccessState(this.listService);
}

class SystemCategoryServiceDataSelectSuccessState extends SystemState {
  final List<CategoryServiceModel> listCategoryService;
  const SystemCategoryServiceDataSelectSuccessState(this.listCategoryService);
}

class SystemServiceNoDataState extends SystemState {
  final String message;
  const SystemServiceNoDataState(this.message);
}

class SystemCategoryServiceNoDataSelectState extends SystemState {
  final String message;
  const SystemCategoryServiceNoDataSelectState(this.message);
}

class SystemServiceDataErrorState extends SystemState {
  final String message;
  const SystemServiceDataErrorState(this.message);
}

class SystemCategoryServiceDataSelectErrorState extends SystemState {
  final String message;
  const SystemCategoryServiceDataSelectErrorState(this.message);
}

class SystemServiceMessageSuccessState extends SystemState {
  final String message;
  const SystemServiceMessageSuccessState(this.message);
}

class SystemServiceCreatetUpdateErrorState extends SystemState {
  final String txtName;
  final String message;
  const SystemServiceCreatetUpdateErrorState(this.message, this.txtName);
}

class SystemServiceDeleteErrorState extends SystemState {
  final String message;
  const SystemServiceDeleteErrorState(this.message);
}
// End: Service