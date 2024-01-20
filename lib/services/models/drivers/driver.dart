import 'dart:collection';
import 'package:urban_transit_admin/services/models/metro_station/metro_station.dart';

class Driver extends MapView<String, dynamic> {
  late String? driverName;
  late String? driverBusDetails;
  late String? driverID;
  late MetroStation? assignedStation;
  late MetroStation? destinationStation;

  Driver({
    this.driverName,
    this.driverBusDetails,
    this.driverID,
    this.assignedStation,
    this.destinationStation,
  }) : super({
          "driverName": driverName,
          "driverBusDetails": driverBusDetails,
          "driverID": driverID,
          "assignedStation": assignedStation,
          "destinationStation": destinationStation,
        });

  Driver.fromJSON({required Map<String, dynamic> json})
      : this(
          driverName: json["driverName"] ?? "",
          driverBusDetails: json["driverBusDetails"] ?? "",
          driverID: json["driverID"] ?? "",
        );

  @override
  String toString() =>
      "\nName: $driverName \nBus: $driverBusDetails \nID: $driverID \nAss: $assignedStation \nDest: $destinationStation";
}
