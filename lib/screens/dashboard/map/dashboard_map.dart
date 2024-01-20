import "dart:async";
import "dart:math";
import "package:flutter/material.dart";
import "package:flutter_riverpod/flutter_riverpod.dart";
import "package:google_maps_flutter/google_maps_flutter.dart";
import "package:location/location.dart";
import "package:urban_transit_admin/screens/dashboard/map/helpers/map_helpers.dart";
import "package:urban_transit_admin/services/models/drivers/driver.dart";
import "package:urban_transit_admin/services/repository/directions_repository.dart";
import "package:urban_transit_admin/shared/utils/app_extensions.dart";
import "package:urban_transit_admin/theme/theme.dart";

class DashboardMap extends ConsumerStatefulWidget {
  const DashboardMap({super.key});

  @override
  ConsumerState<ConsumerStatefulWidget> createState() => _DashboardMapState();
}

class _DashboardMapState extends ConsumerState<DashboardMap>
    with AutomaticKeepAliveClientMixin {
  @override
  bool get wantKeepAlive => true;

  LatLng? _userLocation;
  final Location _location = Location();
  List<LatLng> directions = [];
  GoogleMapController? mapController;
  Set<Polyline> polylines = {};
  Set<Marker> markers = {};
  Set<Circle> circles = {};

  void _onMapCreated(GoogleMapController controller) =>
      setState(() => mapController = controller);

  Future<void> _getUserLocation() async {
    try {
      var currentLocation = await _location.getLocation();
      setState(
        () => _userLocation =
            LatLng(currentLocation.latitude!, currentLocation.longitude!),
      );
    } catch (e) {
      ("Error getting user location: $e").log();
    }
  }

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

  void _onDriverMarkerTap(Driver driver) async {
    await getDirections(
      origin: driver.assignedStation!.position,
      destination: driver.destinationStation!.position,
    );

    mapController?.showMarkerInfoWindow(MarkerId(driver.driverID!));
  }

  Future<void> _updateDrivers() async {
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

    setState(() => markers = _createDriverMarkers(drivers: drivers));
  }

  @override
  void initState() {
    super.initState();
    _getUserLocation();
  }

  @override
  Widget build(BuildContext context) {
    super.build(context);

    return Scaffold(
      body: _userLocation == null
          ? const Center(child: CircularProgressIndicator())
          : GoogleMap(
              mapType: MapType.normal,
              onMapCreated: _onMapCreated,
              initialCameraPosition: CameraPosition(
                target: _userLocation!,
                zoom: 12.0,
              ),
              myLocationEnabled: true,
              polylines: polylines,
              markers: {
                Marker(
                  markerId: const MarkerId("userMarker"),
                  position: _userLocation!,
                  infoWindow: const InfoWindow(title: "Your Location"),
                ),
                ...markers,
              },
              circles: circles,
            ),

      //!
      floatingActionButton: FloatingActionButton(
        onPressed: _updateDrivers,
        child: const Icon(Icons.refresh),
      ),
    );
  }

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

      setState(
        () {
          polylines = newPolylines;
          markers = {startMarker, endMarker};
          circles = {
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
        },
      );

      LatLngBounds bounds = getBounds(
        [...polylines.first.points, startMarker.position, endMarker.position],
      );
      mapController?.animateCamera(CameraUpdate.newLatLngBounds(bounds, 50));
    } else {
      "Error getting directions".log();
    }
  }

  LatLngBounds getBounds(List<LatLng> points) {
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
