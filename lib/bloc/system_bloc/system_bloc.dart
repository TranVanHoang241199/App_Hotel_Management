import 'package:flutter_bloc/flutter_bloc.dart';

import 'system.dart';

class SystemBloc extends Bloc<SystemEvent, SystemState> {
  SystemBloc({required SystemState initState}) : super(SystemInitState());

  @override
  Stream<SystemState> mapEventToState(SystemEvent event) async* {
    // Begin: CategoryRoom
    if (event is SystemCategoryRoomStartEvent) {
      yield* _mapSystemCategoryRoomStartToState();
    }
    // End: CategoryRoom

    // Begin: room
    else if (event is SystemRoomStartEvent) {
      yield* _mapSystemCategoryServiceStartToState();
    }
    // End: room

    // Begin: CategoryService
    else if (event is SystemCategoryRoomStartEvent) {
      yield* _mapSystemRoomStartToState();
    }
    // End: CategoryService

    // Begin: service
    else if (event is SystemServiceStartEvent) {
      yield* _mapSystemServiceStartToState();
    }
    // End: service

    // Begin: cachs tinh tien
    // End: cachs tinh tien
  }

  _mapSystemCategoryRoomStartToState() {}

  _mapSystemCategoryServiceStartToState() {}

  _mapSystemRoomStartToState() {}

  _mapSystemServiceStartToState() {}
}
