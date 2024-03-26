import 'package:equatable/equatable.dart';

class SystemEvent extends Equatable {
  SystemEvent();
  @override
  // TODO: implement props
  List<Object?> get props => throw UnimplementedError();
}

class SystemCategoryRoomStartEvent extends SystemEvent {}

class SystemCategoryRoomPressed extends SystemEvent {}

class SystemCategoryServiceStartEvent extends SystemEvent {}

class SystemCategoryServicePressed extends SystemEvent {}

class SystemRoomStartEvent extends SystemEvent {}

class SystemRoomPressed extends SystemEvent {}

class SystemServiceStartEvent extends SystemEvent {}

class SystemServicePressed extends SystemEvent {}
