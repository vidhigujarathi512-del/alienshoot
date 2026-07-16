import 'package:flutter/material.dart';
import 'package:flutter_map/flutter_map.dart';
import 'package:latlong2/latlong.dart';

import '../services/api_service.dart';

class MapScreen extends StatefulWidget {
  const MapScreen({super.key});

  @override
  State<MapScreen> createState() => _MapScreenState();
}

class _MapScreenState extends State<MapScreen> {
  late Future<Map<String, dynamic>> mapData;

  @override
  void initState() {
    super.initState();
    mapData = ApiService.getMapData();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("ResQNet Map"),
      ),
      body: FutureBuilder<Map<String, dynamic>>(
        future: mapData,
        builder: (context, snapshot) {
          if (snapshot.connectionState ==
              ConnectionState.waiting) {
            return const Center(
              child: CircularProgressIndicator(),
            );
          }

          if (snapshot.hasError) {
            return Center(
              child: Text(
                snapshot.error.toString(),
              ),
            );
          }

          final data = snapshot.data!;

          final safeZoneMarkers =
    (data["safe_zones"] as List)
        .where((zone) =>
            zone["latitude"] != null &&
            zone["longitude"] != null)
        .map<Marker>(
          (zone) => Marker(
            point: LatLng(
              (zone["latitude"] as num).toDouble(),
              (zone["longitude"] as num).toDouble(),
            ),
            width: 40,
            height: 40,
            child: const Icon(
              Icons.shield,
              color: Colors.green,
              size: 35,
            ),
          ),
        )
        .toList();

final communityMarkers =
    (data["community_hubs"] as List)
        .where((hub) =>
            hub["latitude"] != null &&
            hub["longitude"] != null)
        .map<Marker>(
          (hub) => Marker(
            point: LatLng(
              (hub["latitude"] as num).toDouble(),
              (hub["longitude"] as num).toDouble(),
            ),
            width: 40,
            height: 40,
            child: const Icon(
              Icons.groups,
              color: Colors.blue,
              size: 35,
            ),
          ),
        )
        .toList();

final relayMarkers =
    (data["relay_nodes"] as List)
        .where((node) =>
            node["latitude"] != null &&
            node["longitude"] != null)
        .map<Marker>(
          (node) => Marker(
            point: LatLng(
              (node["latitude"] as num).toDouble(),
              (node["longitude"] as num).toDouble(),
            ),
            width: 40,
            height: 40,
            child: const Icon(
              Icons.router,
              color: Colors.orange,
              size: 35,
            ),
          ),
        )
        .toList();

final sosMarkers =
    (data["sos_alerts"] as List)
        .where((sos) =>
            sos["latitude"] != null &&
            sos["longitude"] != null)
        .map<Marker>(
          (sos) => Marker(
            point: LatLng(
              (sos["latitude"] as num).toDouble(),
              (sos["longitude"] as num).toDouble(),
            ),
            width: 40,
            height: 40,
            child: const Icon(
              Icons.warning,
              color: Colors.red,
              size: 35,
            ),
          ),
        )
        .toList();

final missingMarkers =
    (data["missing_persons"] as List)
        .where((person) =>
            person["latitude"] != null &&
            person["longitude"] != null)
        .map<Marker>(
          (person) => Marker(
            point: LatLng(
              (person["latitude"] as num).toDouble(),
              (person["longitude"] as num).toDouble(),
            ),
            width: 40,
            height: 40,
            child: const Icon(
              Icons.person_pin_circle,
              color: Colors.black,
              size: 35,
            ),
          ),
        )
        .toList();

          return FlutterMap(
            options: const MapOptions(
              initialCenter: LatLng(
                18.5204,
                73.8567,
              ),
              initialZoom: 12,
            ),
            children: [
              TileLayer(
                urlTemplate:
                    "https://tile.openstreetmap.org/{z}/{x}/{y}.png",
              ),

              MarkerLayer(
                markers: [
                  ...safeZoneMarkers,
                  ...communityMarkers,
                  ...relayMarkers,
                  ...sosMarkers,
                  ...missingMarkers,
                ],
              ),
            ],
          );
        },
      ),
    );
  }
}