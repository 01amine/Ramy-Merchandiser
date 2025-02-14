import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_map/flutter_map.dart';
import 'package:latlong2/latlong.dart';

import '../bloc/map_bloc.dart';
import '../bloc/map_state.dart';

class MapScreen extends StatelessWidget {
  const MapScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: BlocBuilder<MapBloc, MapState>(
        builder: (context, state) {
          if (state is MapUpdated) {
            return FlutterMap(
              options: MapOptions(
                initialCenter: LatLng(state.latitude, state.longitude),
                initialZoom: 13.0,
              ),
              children: [
                TileLayer(
                  urlTemplate:
                      "https://{s}.tile.openstreetmap.org/{z}/{x}/{y}.png",
                  subdomains: ['a', 'b', 'c'],
                ),
                MarkerLayer(
                  markers: [
                    Marker(
                      width: 80.0,
                      height: 80.0,
                      point: LatLng(state.latitude, state.longitude),
                      child: Icon(
                        Icons.location_on,
                        color: Colors.red,
                        size: 40,
                      ),
                    ),
                  ],
                ),
              ],
            );
          }
          return Center(child: Text('Waiting for location updates...'));
        },
      ),
    );
  }
}