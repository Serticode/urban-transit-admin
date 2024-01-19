import "dart:math";
import "package:google_maps_flutter/google_maps_flutter.dart";
import "package:urban_transit_admin/services/models/metro_station/metro_station.dart";
import "package:urban_transit_admin/theme/theme.dart";

//!
//! SAMPLE STATIONS

class MapHelper {
  const MapHelper();

  static final ikorodu = MetroStation(
    name: "Ikorodu",
    position: const LatLng(6.616865, 3.508072),
  );
  static final cms = MetroStation(
    name: "CMS",
    position: const LatLng(6.4488, 3.3910),
  );
  static final anthony = MetroStation(
    name: "Anthony",
    position: const LatLng(6.5594, 3.3689),
  );
  static final ikotun = MetroStation(
    name: "Ikotun",
    position: const LatLng(6.5479921, 3.2678211),
  );
  static final ikeja = MetroStation(
    name: "Ikeja",
    position: const LatLng(6.5921, 3.3386),
  );

//! LINES
  static final _line1 = MetroLine(
    name: "Line 1",
    color: AppThemeColours.activeButtonBlue,
    stations: [
      ikorodu,
      anthony,
      cms,
    ],
  );

  static final _line2 = MetroLine(
    name: "Line 2",
    color: AppThemeColours.appAmber,
    stations: [
      ikeja,
      ikotun,
    ],
  );

  static final lines = [_line1, _line2];

  //!
  static List<LatLng> switchStartAndEndPoints() {
    Random random = Random();

    final randomLine =
        MapHelper.lines.elementAt(random.nextInt(MapHelper.lines.length));

    final randomStartPoint = randomLine.stations
        .elementAt(random.nextInt(randomLine.stations.length))
        .position;

    final randomEndPoint = randomLine.stations
        .elementAt(random.nextInt(randomLine.stations.length))
        .position;

    return [
      randomStartPoint,
      randomEndPoint,
    ];
  }
}
