import 'package:flutter/material.dart';
import 'package:latlng/latlng.dart';
import 'package:map/map.dart';
import 'package:urban_transit_admin/theme/theme.dart';

class PolylinePainter extends CustomPainter {
  PolylinePainter(this.transformer);

  final MapTransformer transformer;

  @override
  void paint(Canvas canvas, Size size) {
    final paint = Paint()..strokeWidth = 4;

    for (var line in _lines) {
      paint.color = line.color;

      for (int i = 0; i < line.stations.length - 1; i++) {
        var p1 = transformer.toOffset(line.stations[i].position);
        var p2 = transformer.toOffset(line.stations[i + 1].position);

        var dash = line.stations[i].underConstruction ||
            line.stations[i + 1].underConstruction;

        if (dash) {
          var dir = (p2 - p1);

          var dist = dir.distance;
          var dirn = dir / dist;

          var count = (dist / 16).ceil();
          var step = dist / count;

          for (int i = 0; i < count; i++) {
            var c = p1 + dirn * (step * i.toDouble());
            canvas.drawCircle(c, 3, paint);
          }
        } else {
          canvas.drawLine(p1, p2, paint);
        }
      }
    }
  }

  // Since this Sky painter has no fields, it always paints
  // the same thing and semantics information is the same.
  // Therefore we return false here. If we had fields (set
  // from the constructor) then we would return true if any
  // of them differed from the same fields on the oldDelegate.
  @override
  bool shouldRepaint(PolylinePainter oldDelegate) => false;
  @override
  bool shouldRebuildSemantics(PolylinePainter oldDelegate) => false;
}

//! METRO STATIONS
final _ikorodu = MetroStation(
  name: "Ikorodu",
  position: const LatLng(6.616865, 3.508072),
);
final _cms = MetroStation(
  name: "CMS",
  position: const LatLng(6.4488, 3.3910),
);
final _anthony = MetroStation(
  name: "Anthony",
  position: const LatLng(6.5594, 3.3689),
);
final _ikotun = MetroStation(
  name: "Ikotun",
  position: const LatLng(6.5479921, 3.2678211),
);
final _ikeja = MetroStation(
  name: "Ikeja",
  position: const LatLng(6.5921, 3.3386),
);

//! LINES
final _line1 = MetroLine(
  name: 'Line 1',
  color: AppThemeColours.appGreen,
  stations: [
    _ikorodu,
    _anthony,
    _cms,
  ],
);

final _line2 = MetroLine(
  name: 'Line 2',
  color: AppThemeColours.appAmber,
  stations: [
    _ikeja,
    _ikotun,
  ],
);

final _lines = [
  _line1,
  _line2,
];

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
