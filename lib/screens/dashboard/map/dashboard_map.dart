import 'dart:math';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter_polyline_points/flutter_polyline_points.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
//import 'package:latlng/latlng.dart';
import 'package:location/location.dart';
import 'package:map/map.dart';
import 'package:urban_transit_admin/screens/dashboard/map/helpers/map_helpers.dart';
import 'package:urban_transit_admin/shared/utils/app_extensions.dart';

/* class DashboardMap extends StatefulWidget {
  const DashboardMap({Key? key}) : super(key: key);

  @override
  DashboardMapState createState() => DashboardMapState();
}

class DashboardMapState extends State<DashboardMap>
    with AutomaticKeepAliveClientMixin {
  final Location location = Location();
  late MapController controller;
  late LatLng _userLocation;
  @override
  bool get wantKeepAlive => true;

  final stations = <MetroStation>[];

  @override
  void initState() {
    controller = MapController(location: const LatLng(0, 0));
    _getUserLocation();
    var all = lines.expand((element) => element.stations).toSet();
    stations.addAll(all);
    super.initState();
  }

  Future<void> _getUserLocation() async {
    try {
      final locationData = await location.getLocation();
      setState(() {
        _userLocation = LatLng(
          locationData.latitude ?? 0,
          locationData.longitude ?? 0,
        );
        controller.center = _userLocation;
        controller = controller;
      });
    } catch (e) {
      'Error getting location: $e'.log();
    }
  }

  void _gotoDefault() {
    controller.center = _userLocation;
    controller.zoom = 14;
    setState(() {});
  }

  void _onDoubleTap(MapTransformer transformer, Offset position) {
    const delta = 0.5;
    final zoom = clamp(controller.zoom + delta, 2, 18);

    transformer.setZoomInPlace(zoom, position);
    setState(() {});
  }

  Offset? _dragStart;
  double _scaleStart = 1.0;
  void _onScaleStart(ScaleStartDetails details) {
    _dragStart = details.focalPoint;
    _scaleStart = 1.0;
  }

  void _onScaleUpdate(ScaleUpdateDetails details, MapTransformer transformer) {
    final scaleDiff = details.scale - _scaleStart;
    _scaleStart = details.scale;

    if (scaleDiff > 0) {
      controller.zoom += 0.02;
      setState(() {});
    } else if (scaleDiff < 0) {
      controller.zoom -= 0.02;
      setState(() {});
    } else {
      final now = details.focalPoint;
      final diff = now - _dragStart!;
      _dragStart = now;
      transformer.drag(diff.dx, diff.dy);
      setState(() {});
    }
  }

  @override
  Widget build(BuildContext context) {
    super.build(context);

    return Scaffold(
      body: MapLayout(
        controller: controller,
        builder: (context, transformer) {
          return GestureDetector(
            behavior: HitTestBehavior.opaque,
            onDoubleTapDown: (details) => _onDoubleTap(
              transformer,
              details.localPosition,
            ),
            onScaleStart: _onScaleStart,
            onScaleUpdate: (details) => _onScaleUpdate(details, transformer),
            child: Listener(
              behavior: HitTestBehavior.opaque,
              onPointerSignal: (event) {
                if (event is PointerScrollEvent) {
                  final delta = event.scrollDelta.dy / -1000.0;
                  final zoom = clamp(controller.zoom + delta, 2, 18);

                  transformer.setZoomInPlace(zoom, event.localPosition);
                  setState(() {});
                }
              },
              child: Stack(
                children: [
                  TileLayer(
                    builder: (context, x, y, z) {
                      final tilesInZoom = pow(2.0, z).floor();

                      while (x < 0) {
                        x += tilesInZoom;
                      }
                      while (y < 0) {
                        y += tilesInZoom;
                      }

                      x %= tilesInZoom;
                      y %= tilesInZoom;
                      return CachedNetworkImage(
                        imageUrl: google(z, x, y),
                        fit: BoxFit.cover,
                      );
                    },
                  ),
                  CustomPaint(
                    painter: PolylinePainter(transformer),
                  ),
                  ...stations
                      .map(
                        (e) =>
                            _buildStationMarker(e, Colors.black, transformer),
                      )
                      .toList(),
                ],
              ),
            ),
          );
        },
      ),

      //!
      floatingActionButton: FloatingActionButton(
        onPressed: _gotoDefault,
        tooltip: 'My Location',
        child: const Icon(Icons.my_location),
      ),
    );
  }

  Widget _buildStationMarker(
    MetroStation station,
    Color color,
    MapTransformer transformer, {
    IconData icon = Icons.home,
  }) {
    var pos = transformer.toOffset(station.position);

    return Positioned(
      left: pos.dx - 12,
      top: pos.dy - 12,
      width: 24,
      height: 24,
      child: GestureDetector(
        child: Icon(
          icon,
          color: color,
          size: 24,
        ),
        onTap: () {
          showDialog(
            context: context,
            builder: (context) => AlertDialog(
              content: Text('Station: ${station.name}'),
            ),
          );
        },
      ),
    );
  }
} */

class DashboardMap extends ConsumerStatefulWidget {
  const DashboardMap({super.key});

  @override
  ConsumerState<ConsumerStatefulWidget> createState() => _DashboardMapState();
}

class _DashboardMapState extends ConsumerState<DashboardMap> {
  List<LatLng> polyLines = [];

  Future<void> fetchPolyLines() async {
    LatLng start = const LatLng(37.7749, -122.4194); // Start point
    LatLng destination = const LatLng(37.7749, -122.4294); // End point

    List<LatLng> result = await getPolyLines(start, destination);

    setState(() {
      polyLines = result;
    });
  }

  @override
  void initState() {
    super.initState();
    // Example usage
    fetchPolyLines();
  }

  Future<List<LatLng>> getPolyLines(LatLng start, LatLng destination) async {
    List<LatLng> polylinePoints = [];
    PolylinePoints polylinePointsProvider = PolylinePoints();

    PolylineResult result =
        await polylinePointsProvider.getRouteBetweenCoordinates(
      'YOUR_API_KEY', // Replace with your Google Maps API key
      PointLatLng(start.latitude, start.longitude),
      PointLatLng(destination.latitude, destination.longitude),
      travelMode: TravelMode
          .driving, // Specify the travel mode (driving, walking, etc.)
    );

    if (result.points.isNotEmpty) {
      for (var point in result.points) {
        polylinePoints.add(LatLng(point.latitude, point.longitude));
      }
    }

    return polylinePoints;
  }

  @override
  Widget build(BuildContext context) {
    return const GoogleMap(
      initialCameraPosition: CameraPosition(
        target: LatLng(37.7749, -122.4194),
        zoom: 12.0,
      ),
      polylines: {
        //Polyline(data: data, paint: paint)
        /* Polyline(
          polylineId: PolylineId('route'),
          color: Colors.blue,
          points: polyLines,
          width: 4,
        ), */
      },
    );
  }
}
