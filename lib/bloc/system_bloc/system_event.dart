import 'package:equatable/equatable.dart';
import 'package:flutter_app_hotel_management/data/models/room_model.dart';

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
  final RoomModel room;

  SystemRoomCreatePressedEvent({required this.room});
}

class SystemRoomUpdatePressedEvent extends SystemEvent {
  final RoomModel room;

  SystemRoomUpdatePressedEvent({required this.room});
}

class SystemRoomDeletePressedEvent extends SystemEvent {
  final String id;

  SystemRoomDeletePressedEvent({required this.id});
}
// End: Room

class SystemCategoryServiceStartEvent extends SystemEvent {}

class SystemCategoryServicePressed extends SystemEvent {}

class SystemServiceStartEvent extends SystemEvent {}

class SystemServicePressed extends SystemEvent {}
