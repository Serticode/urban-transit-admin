import "package:dio/dio.dart";
import "package:flutter_dotenv/flutter_dotenv.dart";
import "package:google_maps_flutter/google_maps_flutter.dart";
import "package:urban_transit_admin/services/models/directions/directions_model.dart";
import "package:urban_transit_admin/shared/constants/env_constants.dart";
import "package:urban_transit_admin/shared/utils/app_extensions.dart";
import "package:urban_transit_admin/theme/theme.dart";

class DirectionsRepository {
  DirectionsRepository();
  static const String _baseUrl =
      "https://maps.googleapis.com/maps/api/directions/json?";

  final Dio _dio = Dio(
    BaseOptions(
      baseUrl: _baseUrl,
      connectTimeout: const Duration(seconds: 90),
      receiveTimeout: const Duration(seconds: 90),
      responseType: ResponseType.json,
      headers: {
        "Content-Type": "application/json; charset=UTF-8",
      },
    ),
  );

  //! POLY LINES
  Future<Map<String, dynamic>?> fetchPolyLines({
    required LatLng origin,
    required LatLng destination,
  }) async {
    try {
      ("Fetching polylines").log();

      final Directions? directions = await getRouteBetweenCoordinates(
        origin: origin,
        destination: destination,
      );

      if (directions == null) {
        return null;
      }

      ("Done fetching polylines").log();

      final polylines = {
        Polyline(
          polylineId: const PolylineId("direction_polyline"),
          color: AppThemeColours.appBlue,
          width: 5,
          consumeTapEvents: true,
          points: directions.polylinePoints
              .map((e) => LatLng(e.latitude, e.longitude))
              .toList(),
        ),
      };

      final startMarker = Marker(
        markerId: const MarkerId("startMarker"),
        position: origin,
        infoWindow: const InfoWindow(title: "Start Point"),
      );

      final endMarker = Marker(
        markerId: const MarkerId("endMarker"),
        position: destination,
        infoWindow: const InfoWindow(title: "End Point"),
      );

      return {
        "polylines": polylines,
        "startMarker": startMarker,
        "endMarker": endMarker,
      };
    } catch (e) {
      ("Error fetching polylines: $e").log();
      return null;
    }
  }

  //! GET ROUTE COORDINATES
  Future<Directions?> getRouteBetweenCoordinates({
    required LatLng origin,
    required LatLng destination,
  }) async {
    "Get Route".log();

    final response = await _dio.get(
      _baseUrl,
      queryParameters: {
        "origin": "${origin.latitude},${origin.longitude}",
        "destination": "${destination.latitude},${destination.longitude}",
        "key": dotenv.get(
          ENVConstants.mapsApiKey,
        ),
      },
    );

    if (response.statusCode == 200) {
      "Directions response $response".log();

      return Directions.fromMap(map: response.data);
    }

    "Route gotten".log();
    return null;
  }
}
