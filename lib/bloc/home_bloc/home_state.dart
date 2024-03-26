import 'package:equatable/equatable.dart';
import 'package:flutter_app_hotel_management/data/models/room_model.dart';

import '../../data/models/customer_model.dart';
import '../../data/models/service_model.dart';

class HomeState extends Equatable {
  const HomeState();
  @override
  // TODO: implement props
  List<Object?> get props => throw UnimplementedError();
}

class HomeInitState extends HomeState {}

// Begin: Room
class HomeRoomLoadingState extends HomeState {}

class HomeRoomSuccessState extends HomeState {
  final List<RoomModel> listRoom;
  const HomeRoomSuccessState(this.listRoom);
}

class HomeRoomNoDataState extends HomeState {
  final String message;
  const HomeRoomNoDataState(this.message);
}

class HomeRoomErrorState extends HomeState {
  final String message;
  const HomeRoomErrorState(this.message);
}
// End: Room

// Begin: Service
class HomeServiceLoadingState extends HomeState {}

class HomeServiceSuccessState extends HomeState {
  final List<ServiceModel> listService;
  const HomeServiceSuccessState(this.listService);
}

class HomeServiceNoDataState extends HomeState {
  final String message;
  const HomeServiceNoDataState(this.message);
}

class HomeServiceErrorState extends HomeState {
  final String message;
  const HomeServiceErrorState(this.message);
}
// End: Service

// Begin: Service
class HomeCustomerLoadingState extends HomeState {}

class HomeCustomerSuccessState extends HomeState {
  final List<CustomerModel> listCustomer;
  const HomeCustomerSuccessState(this.listCustomer);
}

class HomeCustomerNoDataState extends HomeState {
  final String message;
  const HomeCustomerNoDataState(this.message);
}

class HomeCustomerErrorState extends HomeState {
  final String message;
  const HomeCustomerErrorState(this.message);
}
// End: Service