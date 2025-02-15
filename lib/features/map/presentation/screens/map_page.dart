import 'package:flutter/material.dart';
import 'package:flutter_map/flutter_map.dart';
import 'package:latlong2/latlong.dart';

class MapScreen extends StatelessWidget {
  final LatLng initialCenter;
  final List<LatLng> sellingPoints;

  const MapScreen({
    super.key,
    required this.initialCenter,
    required this.sellingPoints,
  });

  @override
  Widget build(BuildContext context) {
    final Polyline optimizedRoute = Polyline(
      points: sellingPoints,
      color: Colors.orangeAccent,
      strokeWidth: 5.0,
    );

    return Scaffold(
      body: FlutterMap(
        options: MapOptions(
          initialCenter: initialCenter,
          initialZoom: 13.5,
        ),
        children: [
          TileLayer(
            urlTemplate:
                "https://{s}.basemaps.cartocdn.com/light_all/{z}/{x}/{y}{r}.png",
            subdomains: const ['a', 'b', 'c'],
          ),
          PolylineLayer(polylines: [optimizedRoute]),
          MarkerLayer(
            markers: sellingPoints
                .map(
                  (point) => Marker(
                    width: 60.0,
                    height: 60.0,
                    point: point,
                    child: const Icon(
                      Icons.store,
                      color: Colors.black,
                      size: 30,
                    ),
                  ),
                )
                .toList(),
          ),
          if (sellingPoints.isNotEmpty)
            MarkerLayer(
              markers: [
                Marker(
                  width: 120.0,
                  height: 40.0,
                  point: sellingPoints[sellingPoints.length ~/ 2],
                  child: Container(
                    padding: const EdgeInsets.all(6),
                    decoration: BoxDecoration(
                      color: Colors.white.withOpacity(0.9),
                      borderRadius: BorderRadius.circular(6),
                    ),
                    child: const Text(
                      "Optimized Route",
                      style: TextStyle(
                        fontSize: 14,
                        color: Colors.blue,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                ),
              ],
            ),
        ],
      ),
    );
  }
}