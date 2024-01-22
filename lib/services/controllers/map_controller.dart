/* import 'dart:math';

import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:location/location.dart';
import 'package:urban_transit_admin/services/models/drivers/driver.dart';
import 'package:urban_transit_admin/services/repository/directions_repository.dart';
import 'package:urban_transit_admin/shared/utils/app_extensions.dart';
import 'package:urban_transit_admin/theme/theme.dart';

/* enum DriverRoute {
  ikorodu,
  cms,
  anthony,
  ikotun,
  ikeja,
  noLocation,
} */

typedef MapControllerState = ({
  LatLng? userLocation,
  Set<Polyline>? polylines,
  Set<Marker>? markers,
  Set<Circle>? circles,
  GoogleMapController? mapController,
});

final mapControllerProvider =
    StateNotifierProvider<MapController, MapControllerState>((ref) {
  return MapController();
});

//!
//!
class MapController extends StateNotifier<MapControllerState> {
  //!
  final Location _location = Location();
  LatLng? get userLocation => state.userLocation;
  Set<Polyline>? get polylines => state.polylines;
  Set<Marker>? get markers => state.markers;
  Set<Circle>? get circles => state.circles;
  GoogleMapController? get mapController => state.mapController;

  MapController()
      : super((
          userLocation: null,
          polylines: null,
          markers: null,
          circles: null,
          mapController: null
        ));

  Future<void> init() async {
    final userLocation = await _getUserLocation();

    state = (
      userLocation: userLocation,
      polylines: null,
      markers: null,
      circles: null,
      mapController: null
    );
  }

  //!
  Future<LatLng> _getUserLocation() async {
    try {
      var currentLocation = await _location.getLocation();

      return LatLng(
        currentLocation.latitude!,
        currentLocation.longitude!,
      );
    } catch (error) {
      ("Error getting user location: $error").log();
      rethrow;
    }
  }

  //!
  Future<void> getPolylines() async {}

  //!
  Future<void> getMarkers() async {}

  //!
  Future<void> getCircles() async {}

  //!
  Set<Marker> _createDriverMarkers({required List<Driver> drivers}) {
    return drivers.map(
      (driver) {
        return Marker(
          markerId: MarkerId(driver.driverID!),
          position: driver.assignedStation!.position,
          onTap: () => _onDriverMarkerTap(driver),
        );
      },
    ).toSet();
  }

  //!
  void _onDriverMarkerTap(Driver driver) async {
    await getDirections(
      origin: driver.assignedStation!.position,
      destination: driver.destinationStation!.position,
    );

    mapController?.showMarkerInfoWindow(MarkerId(driver.driverID!));
  }

  //!
  Future<void> getDirections({
    required LatLng origin,
    required LatLng destination,
  }) async {
    "Get directions Called".log();

    final directionsRepository = DirectionsRepository();

    Map<String, dynamic>? result = await directionsRepository.fetchPolyLines(
      origin: origin,
      destination: destination,
    );

    if (result != null) {
      Set<Polyline> newPolylines = result["polylines"];
      Marker startMarker = result["startMarker"];
      Marker endMarker = result["endMarker"];

      final polylines = newPolylines;
      final markers = {startMarker, endMarker};
      final circles = {
        Circle(
          circleId: CircleId(startMarker.mapsId.value),
          center: startMarker.position,
          radius: 100,
          fillColor: AppThemeColours.appGreen.withOpacity(0.3),
          strokeWidth: 2,
          strokeColor: AppThemeColours.appBlue,
        ),
        Circle(
          circleId: CircleId(endMarker.mapsId.value),
          center: endMarker.position,
          radius: 100,
          fillColor: AppThemeColours.appGreen.withOpacity(0.3),
          strokeWidth: 2,
          strokeColor: AppThemeColours.appBlue,
        ),
      };

      LatLngBounds bounds = _getBounds(
        [...polylines.first.points, startMarker.position, endMarker.position],
      );

      mapController?.animateCamera(CameraUpdate.newLatLngBounds(bounds, 50));
    } else {
      "Error getting directions".log();
    }
  }

  //!
  LatLngBounds _getBounds(List<LatLng> points) {
    double minLat = points[0].latitude;
    double maxLat = points[0].latitude;
    double minLng = points[0].longitude;
    double maxLng = points[0].longitude;

    for (LatLng point in points) {
      minLat = min(minLat, point.latitude);
      maxLat = max(maxLat, point.latitude);
      minLng = min(minLng, point.longitude);
      maxLng = max(maxLng, point.longitude);
    }

    return LatLngBounds(
      southwest: LatLng(minLat, minLng),
      northeast: LatLng(maxLat, maxLng),
    );
  }
}
 */