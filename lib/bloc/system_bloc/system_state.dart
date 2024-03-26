import 'package:equatable/equatable.dart';

import '../../data/models/category_room_model.dart';

class SystemState extends Equatable {
  const SystemState();
  @override
  // TODO: implement props
  List<Object?> get props => throw UnimplementedError();
}

class SystemInitState extends SystemState {}

class SystemCategoryRoomLoadingState extends SystemState {}

class SystemCategoryRoomSuccessState extends SystemState {
  final List<CategoryRoomModel> listCategoryRoom;
  const SystemCategoryRoomSuccessState(this.listCategoryRoom);
}

class SystemCategoryRoomNoDataState extends SystemState {
  final String message;
  const SystemCategoryRoomNoDataState(this.message);
}

class SystemCategoryRoomErrorState extends SystemState {
  final String message;
  const SystemCategoryRoomErrorState(this.message);
}
