import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

class MetroLine {
  MetroLine({
    required this.name,
    required this.color,
    required this.stations,
  });

  final String name;
  final Color color;
  final List<MetroStation> stations;
}

class MetroStation {
  MetroStation({
    required this.name,
    required this.position,
    this.underConstruction = false,
  });

  final String name;
  final LatLng position;
  final bool underConstruction;
}
