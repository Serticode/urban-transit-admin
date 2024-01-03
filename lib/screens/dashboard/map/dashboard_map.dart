import 'dart:math';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:latlng/latlng.dart';
import 'package:location/location.dart';
import 'package:map/map.dart';
import 'package:urban_transit_admin/screens/dashboard/map/helpers/map_helpers.dart';
import 'package:urban_transit_admin/shared/utils/app_extensions.dart';
import 'package:urban_transit_admin/theme/theme.dart';

class DashboardMap extends StatefulWidget {
  const DashboardMap({super.key});

  @override
  State<DashboardMap> createState() => _DashboardMapState();
}

class _DashboardMapState extends State<DashboardMap>
    with AutomaticKeepAliveClientMixin {
  final Location location = Location();
  late MapController controller;
  late LatLng _userLocation;
  @override
  bool get wantKeepAlive => true;

  @override
  void initState() {
    super.initState();
    controller = MapController(location: const LatLng(0, 0));
    _getUserLocation();
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
                      painter: ViewportPainter(
                        transformer.getViewport(),
                      ),
                    ),
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
          backgroundColor: AppThemeColours.appBlue,
          elevation: 42,
          child: const Icon(Icons.my_location),
        ));
  }
}

class ViewportPainter extends CustomPainter {
  ViewportPainter(this.viewport);
  final Rect viewport;

  @override
  void paint(Canvas canvas, Size size) {
    final paint = Paint()
      ..style = PaintingStyle.stroke
      ..color = Colors.white
      ..strokeWidth = 1;

    canvas.drawRect(viewport, paint);
  }

  @override
  bool shouldRepaint(covariant ViewportPainter oldDelegate) =>
      oldDelegate.viewport != viewport;
}
