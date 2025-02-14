import 'package:flutter/material.dart';
import 'package:flutter_map/flutter_map.dart';
import 'package:latlong2/latlong.dart';

class MapScreen extends StatelessWidget {
  const MapScreen({super.key});

  static const double latAlgiers = 36.7538;
  static const double lngAlgiers = 3.0588;

  @override
  Widget build(BuildContext context) {
    final List<LatLng> sellingPoints = [
      LatLng(latAlgiers, lngAlgiers),
      LatLng(latAlgiers + 0.005, lngAlgiers - 0.007),
      LatLng(latAlgiers + 0.01, lngAlgiers - 0.01),
      LatLng(latAlgiers + 0.015, lngAlgiers - 0.005),
      LatLng(latAlgiers + 0.02, lngAlgiers - 0.002),
      LatLng(latAlgiers + 0.025, lngAlgiers + 0.002),
    ];

    final Polyline optimizedRoute = Polyline(
      points: sellingPoints,
      color: Colors.orangeAccent,
      strokeWidth: 5.0,
    );

    return Scaffold(
      body: FlutterMap(
        options: MapOptions(
          initialCenter: LatLng(latAlgiers, lngAlgiers),
          initialZoom: 13.5, // Slightly zoomed in for better visibility
        ),
        children: [
          TileLayer(
            urlTemplate:
                "https://{s}.basemaps.cartocdn.com/light_all/{z}/{x}/{y}{r}.png",
            subdomains: const ['a', 'b', 'c'],
          ),
          PolylineLayer(
            polylines: [optimizedRoute],
          ),
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
