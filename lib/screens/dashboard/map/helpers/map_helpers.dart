import 'package:flutter/material.dart';
import 'package:latlng/latlng.dart';
import 'package:map/map.dart';
import 'package:urban_transit_admin/theme/theme.dart';

const yourMapBoxAccessToken = '';

//! Legal notice: This url is only used for demo and educational purposes. You need a license key for production use.
String google(int z, int x, int y) {
  //Google Maps
  final url =
      'https://www.google.com/maps/vt/pb=!1m4!1m3!1i$z!2i$x!3i$y!2m3!1e0!2sm!3i420120488!3m7!2sen!5e1105!12m4!1e68!2m2!1sset!2sRoadmap!4e0!5m1!1e0!23i4111425';

  return url;
}

//! Legal notice: This url is only used for demo and educational purposes. You need a license key for production use.
String googleDark(int z, int x, int y) {
  final url =
      'https://maps.googleapis.com/maps/vt?pb=!1m5!1m4!1i$z!2i$x!3i$y!4i256!2m3!1e0!2sm!3i556279080!3m17!2sen-US!3sUS!5e18!12m4!1e68!2m2!1sset!2sRoadmap!12m3!1e37!2m1!1ssmartmaps!12m4!1e26!2m2!1sstyles!2zcC52Om9uLHMuZTpsfHAudjpvZmZ8cC5zOi0xMDAscy5lOmwudC5mfHAuczozNnxwLmM6I2ZmMDAwMDAwfHAubDo0MHxwLnY6b2ZmLHMuZTpsLnQuc3xwLnY6b2ZmfHAuYzojZmYwMDAwMDB8cC5sOjE2LHMuZTpsLml8cC52Om9mZixzLnQ6MXxzLmU6Zy5mfHAuYzojZmYwMDAwMDB8cC5sOjIwLHMudDoxfHMuZTpnLnN8cC5jOiNmZjAwMDAwMHxwLmw6MTd8cC53OjEuMixzLnQ6NXxzLmU6Z3xwLmM6I2ZmMDAwMDAwfHAubDoyMCxzLnQ6NXxzLmU6Zy5mfHAuYzojZmY0ZDYwNTkscy50OjV8cy5lOmcuc3xwLmM6I2ZmNGQ2MDU5LHMudDo4MnxzLmU6Zy5mfHAuYzojZmY0ZDYwNTkscy50OjJ8cy5lOmd8cC5sOjIxLHMudDoyfHMuZTpnLmZ8cC5jOiNmZjRkNjA1OSxzLnQ6MnxzLmU6Zy5zfHAuYzojZmY0ZDYwNTkscy50OjN8cy5lOmd8cC52Om9ufHAuYzojZmY3ZjhkODkscy50OjN8cy5lOmcuZnxwLmM6I2ZmN2Y4ZDg5LHMudDo0OXxzLmU6Zy5mfHAuYzojZmY3ZjhkODl8cC5sOjE3LHMudDo0OXxzLmU6Zy5zfHAuYzojZmY3ZjhkODl8cC5sOjI5fHAudzowLjIscy50OjUwfHMuZTpnfHAuYzojZmYwMDAwMDB8cC5sOjE4LHMudDo1MHxzLmU6Zy5mfHAuYzojZmY3ZjhkODkscy50OjUwfHMuZTpnLnN8cC5jOiNmZjdmOGQ4OSxzLnQ6NTF8cy5lOmd8cC5jOiNmZjAwMDAwMHxwLmw6MTYscy50OjUxfHMuZTpnLmZ8cC5jOiNmZjdmOGQ4OSxzLnQ6NTF8cy5lOmcuc3xwLmM6I2ZmN2Y4ZDg5LHMudDo0fHMuZTpnfHAuYzojZmYwMDAwMDB8cC5sOjE5LHMudDo2fHAuYzojZmYyYjM2Mzh8cC52Om9uLHMudDo2fHMuZTpnfHAuYzojZmYyYjM2Mzh8cC5sOjE3LHMudDo2fHMuZTpnLmZ8cC5jOiNmZjI0MjgyYixzLnQ6NnxzLmU6Zy5zfHAuYzojZmYyNDI4MmIscy50OjZ8cy5lOmx8cC52Om9mZixzLnQ6NnxzLmU6bC50fHAudjpvZmYscy50OjZ8cy5lOmwudC5mfHAudjpvZmYscy50OjZ8cy5lOmwudC5zfHAudjpvZmYscy50OjZ8cy5lOmwuaXxwLnY6b2Zm!4e0';
  return url;
}

String mapbox(int z, int x, int y) {
  //Mapbox Streets
  final url =
      'https://api.mapbox.com/styles/v1/mapbox/streets-v11/tiles/$z/$x/$y?access_token=$yourMapBoxAccessToken';

  return url;
}

double clamp(double x, double min, double max) {
  if (x < min) x = min;
  if (x > max) x = max;

  return x;
}

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

//!
//!
class PolylinePainter extends CustomPainter {
  PolylinePainter(this.transformer);

  final MapTransformer transformer;

  @override
  void paint(Canvas canvas, Size size) {
    final paint = Paint()..strokeWidth = 4;

    for (var line in lines) {
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

//!
//! SAMPLE STATIONS
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
  color: AppThemeColours.activeButtonBlue,
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

final lines = [
  _line1,
  _line2,
];
