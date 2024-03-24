import 'package:equatable/equatable.dart';
import 'package:flutter_app_hotel_management/data/models/room_model.dart';

class HomeState extends Equatable {
  const HomeState();
  @override
  // TODO: implement props
  List<Object?> get props => throw UnimplementedError();
}

class HomeInitState extends HomeState {}

// Home - Room
class HomeRoomLoadingState extends HomeState {}

class HomeRoomSuccessState extends HomeState {
  final List<RoomModel> listRoom;
  const HomeRoomSuccessState(this.listRoom);
}

class HomeRoomErrorState extends HomeState {
  final String message;
  const HomeRoomErrorState(this.message);
}
