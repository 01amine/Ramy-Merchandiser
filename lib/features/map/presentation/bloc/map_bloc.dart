import 'package:bloc/bloc.dart';

import 'map_event.dart';
import 'map_state.dart';

class MapBloc extends Bloc<MapEvent, MapState> {
  MapBloc()
      : super(MapUpdated(
          36.7729333,
          3.0588445,
        ));

  Stream<MapState> mapEventToState(MapEvent event) async* {
    if (event is UpdateLocationEvent) {
      yield MapUpdated(event.latitude, event.longitude);
    }
  }
}
