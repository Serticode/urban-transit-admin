import "dart:math";
import "package:google_maps_flutter/google_maps_flutter.dart";
import "package:urban_transit_admin/services/models/metro_station/metro_station.dart";

//!
//! SAMPLE STATIONS
class MapHelper {
  const MapHelper();

  static const ikorodu = MetroStation(
    name: "Ikorodu",
    position: LatLng(6.616865, 3.508072),
  );

  static const cms = MetroStation(
    name: "CMS",
    position: LatLng(6.4488, 3.3910),
  );

  static const anthony = MetroStation(
    name: "Anthony",
    position: LatLng(6.5594, 3.3689),
  );

  static const ikotun = MetroStation(
    name: "Ikotun",
    position: LatLng(6.5479921, 3.2678211),
  );

  static const ikeja = MetroStation(
    name: "Ikeja",
    position: LatLng(6.5921, 3.3386),
  );

  //! LINES
  static const _line1 = MetroLine(
    name: "Line 1",
    stations: [
      ikorodu,
      anthony,
      cms,
    ],
  );

  static const _line2 = MetroLine(
    name: "Line 2",
    stations: [
      ikeja,
      ikotun,
    ],
  );

  static const lines = [_line1, _line2];

  //!
  static MetroStation getDestinationPoint({
    required MetroStation startPoint,
  }) {
    Random random = Random();

    final allStations =
        MapHelper.lines.expand((line) => line.stations).toList();

    List<MetroStation> validDestinations =
        allStations.where((station) => station != startPoint).toList();

    final randomStation =
        validDestinations.elementAt(random.nextInt(validDestinations.length));

    return randomStation;
  }
}
