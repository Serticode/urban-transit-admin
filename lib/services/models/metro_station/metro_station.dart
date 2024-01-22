import 'package:google_maps_flutter/google_maps_flutter.dart';

class MetroLine {
  const MetroLine({
    required this.name,
    required this.stations,
  });

  final String name;
  final List<MetroStation> stations;
}

class MetroStation {
  const MetroStation({
    required this.name,
    required this.position,
    this.underConstruction = false,
  });

  final String name;
  final LatLng position;
  final bool underConstruction;

  @override
  String toString() => "\nSta: $name \nPos: $position";

  @override
  bool operator ==(covariant MetroStation other) {
    if (identical(this, other)) return true;

    return other.name == name &&
        other.position == position &&
        other.underConstruction == underConstruction;
  }

  @override
  int get hashCode {
    return name.hashCode ^ position.hashCode ^ underConstruction.hashCode;
  }
}
