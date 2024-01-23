import 'dart:async';
import 'dart:math';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:location/location.dart';
import 'package:urban_transit_admin/screens/dashboard/map/helpers/map_helpers.dart';
import 'package:urban_transit_admin/services/models/drivers/driver.dart';
import 'package:urban_transit_admin/services/repository/directions_repository.dart';
import 'package:urban_transit_admin/shared/utils/app_extensions.dart';
import 'package:urban_transit_admin/theme/theme.dart';

typedef MapControllerState = ({
  LatLng? userLocation,
  Set<Polyline>? polylines,
  Set<Marker>? markers,
  Set<Circle>? circles,
  GoogleMapController? mapController,
  CameraPosition? cameraPosition,
});

final mapControllerProvider =
    AsyncNotifierProvider<MapController, MapControllerState>(
  MapController.new,
);

class MapController extends AsyncNotifier<MapControllerState> {
  final Location _location = Location();

  @override
  FutureOr<MapControllerState> build() async {
    final userLocation = await _getUserLocation();

    return (
      userLocation: userLocation,
      polylines: null,
      markers: null,
      circles: null,
      mapController: null,
      cameraPosition: CameraPosition(
        target: userLocation,
        zoom: 12.0,
      ),
    );
  }

  //!
  //!
  Future<void> init({required GoogleMapController controller}) async {
    state = AsyncData((
      userLocation: state.value!.userLocation!,
      polylines: null,
      markers: null,
      circles: null,
      mapController: controller,
      cameraPosition: state.value!.cameraPosition,
    ));
  }

  //!
  //! USER LOCATION
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
  //! _CREATE DRIVER MARKERS
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
  //! ON DRIVER MARKER TAP
  void _onDriverMarkerTap(Driver driver) async {
    await _getDirections(
      origin: driver.assignedStation!.position,
      destination: driver.destinationStation!.position,
    );

    state.value!.mapController
        ?.showMarkerInfoWindow(MarkerId(driver.driverID!));
  }

  //!
  //! GET BOUNDS
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

  //!
  //!
  Future<void> _getDirections({
    required LatLng origin,
    required LatLng destination,
  }) async {
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

      state = AsyncData((
        userLocation: state.value!.userLocation,
        polylines: polylines,
        markers: markers,
        circles: circles,
        mapController: state.value!.mapController,
        cameraPosition: state.value!.cameraPosition,
      ));

      state.value!.mapController
          ?.animateCamera(CameraUpdate.newLatLngBounds(bounds, 50));
    } else {
      "Error getting directions".log();
    }
  }

  //!
  //! UPDATE DRIVERS
  Future<void> updateDrivers() async {
    final List<Driver> drivers = List.generate(
      5,
      (index) {
        final assignedStation = MapHelper.lines
            .expand((line) => line.stations)
            .toList()
            .elementAt(
              index % MapHelper.lines.expand((line) => line.stations).length,
            );

        return Driver(
          driverID: "Driver_$index",
          driverName: "Driver $index",
          driverBusDetails: "Bus_$index",
          assignedStation: assignedStation,
          destinationStation: MapHelper.getDestinationPoint(
            startPoint: assignedStation,
          ),
        );
      },
    );

    final markers = _createDriverMarkers(drivers: drivers);

    state = AsyncData((
      userLocation: state.value!.userLocation,
      polylines: state.value!.polylines,
      markers: markers,
      circles: state.value!.circles,
      mapController: state.value!.mapController,
      cameraPosition: state.value!.cameraPosition,
    ));
  }

  //!
  //! UPDATE POLY LINES
  Future<void> updatePolylines({
    required LatLng origin,
    required LatLng destination,
  }) async {
    DirectionsRepository directionsRepository = DirectionsRepository();

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

      state = AsyncData((
        userLocation: state.value!.userLocation,
        polylines: polylines,
        markers: markers,
        circles: circles,
        mapController: state.value!.mapController,
        cameraPosition: state.value!.cameraPosition,
      ));

      state.value!.mapController
          ?.animateCamera(CameraUpdate.newLatLngBounds(bounds, 50));
    } else {
      "Error getting directions".log();
    }
  }
}
