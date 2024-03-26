import 'package:equatable/equatable.dart';

class HomeEvent extends Equatable {
  const HomeEvent();

  @override
  // TODO: implement props
  List<Object?> get props => throw UnimplementedError();
}

class HomeRoomStartEvent extends HomeEvent {}

class HomeServiceStartEvent extends HomeEvent {}

class HomeCustomerStartEvent extends HomeEvent {}

//class HomeStartEvent extends HomeEvent {}
