import 'package:equatable/equatable.dart';
import 'package:flutter_app_hotel_management/data/models/room_model.dart';

class HomeState extends Equatable {
  const HomeState();
  @override
  // TODO: implement props
  List<Object?> get props => throw UnimplementedError();
}

class HomeInitState extends HomeState {}

class HomeRoomLoadingState extends HomeState {}

class HomeRoomSuccessState extends HomeState {
  final RoomModel room;
  const HomeRoomSuccessState(this.room);
}

class HomeRoomErrorState extends HomeState {
  final String message;
  const HomeRoomErrorState(this.message);
}
