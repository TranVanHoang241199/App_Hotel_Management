import 'package:equatable/equatable.dart';
import 'package:flutter_app_hotel_management/data/models/room_model.dart';

import '../../data/models/service_model.dart';

class SystemEvent extends Equatable {
  SystemEvent();
  @override
  // TODO: implement props
  List<Object?> get props => throw UnimplementedError();
}

// Begin: Category Room
class SystemCategoryRoomStartEvent extends SystemEvent {}

class SystemCategoryRoomCreatePressed extends SystemEvent {
  final String categoryName;

  SystemCategoryRoomCreatePressed(this.categoryName);

  @override
  List<Object?> get props => [categoryName];
}

class SystemCategoryRoomDeletePressed extends SystemEvent {
  final String id;

  SystemCategoryRoomDeletePressed(this.id);

  @override
  List<Object?> get props => [id];
}
// End: Category Room

// Begin: Room
class SystemRoomStartEvent extends SystemEvent {}

class SystemCategoryRoomSelectEvent extends SystemEvent {}

class SystemRoomCreatePressedEvent extends SystemEvent {
  final RoomModel roomModel;

  SystemRoomCreatePressedEvent(
      this.roomModel); // Thêm tham số roomModel vào đây
}

class SystemRoomUpdatePressedEvent extends SystemEvent {
  final RoomModel roomModel;

  SystemRoomUpdatePressedEvent(this.roomModel);
}

class SystemRoomDeletePressedEvent extends SystemEvent {
  final String id;

  SystemRoomDeletePressedEvent(this.id);
}
// End: Room

// Begin: Category Service
class SystemCategoryServiceStartEvent extends SystemEvent {}

class SystemCategoryServiceCreatePressed extends SystemEvent {
  final String categoryName;

  SystemCategoryServiceCreatePressed(this.categoryName);

  @override
  List<Object?> get props => [categoryName];
}

class SystemCategoryServiceDeletePressed extends SystemEvent {
  final String id;

  SystemCategoryServiceDeletePressed(this.id);

  @override
  List<Object?> get props => [id];
}
// End: Category Service

// Begin: Service
class SystemServiceStartEvent extends SystemEvent {}

class SystemCategoryServiceSelectEvent extends SystemEvent {}

class SystemServiceCreatePressedEvent extends SystemEvent {
  final ServiceModel serviceModel;

  SystemServiceCreatePressedEvent(this.serviceModel);
}

class SystemServiceUpdatePressedEvent extends SystemEvent {
  final ServiceModel serviceModel;

  SystemServiceUpdatePressedEvent(this.serviceModel);
}

class SystemServiceDeletePressedEvent extends SystemEvent {
  final String id;

  SystemServiceDeletePressedEvent(this.id);
}
// End: Service
