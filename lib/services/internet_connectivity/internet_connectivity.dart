import 'dart:async';
import 'dart:io';
import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:urban_transit_admin/services/endpoints/endpoints.dart';
import 'package:urban_transit_admin/shared/utils/type_defs.dart';

class ConnectivityService {
  //! CREATE SINGLE INSTANCE
  ConnectivityService._();
  static final _instance = ConnectivityService._();

  //! RETRIEVE INSTANCE
  static ConnectivityService get instance => _instance;

  final Connectivity _networkConnectivity = Connectivity();
  final _controller = StreamController.broadcast();
  Stream get myStream => _controller.stream;

  //! CONNECTIVITY STATE ASSISTERS
  bool hasConnection = false;
  ConnectivityStatus networkStatus = ConnectivityStatus.offline;

  //! ALLOW SUBSCRIPTION TO CONNECTIVITY STATUS / CHANGES
  StreamController<ConnectivityStatus> connectionChangeController =
      StreamController<ConnectivityStatus>.broadcast();

  final Connectivity _connectivity = Connectivity();

  //! INITIALIZE
  void initialize() async {
    ConnectivityResult result = await _networkConnectivity.checkConnectivity();
    _checkStatus(result);
    _networkConnectivity.onConnectivityChanged.listen((result) {
      _checkStatus(result);
    });
  }

  //! CHECK CONNECTION STATUS
  void _checkStatus(ConnectivityResult result) async {
    bool isOnline = false;
    try {
      final result = await InternetAddress.lookup(AppUrls.example);
      isOnline = result.isNotEmpty && result[0].rawAddress.isNotEmpty;
    } on SocketException catch (_) {
      isOnline = false;
    }

    if (!_controller.isClosed) {
      _controller.sink.add({result: isOnline});
    }
  }

  //! LISTEN FOR CHANGES
  Stream<ConnectivityStatus> get connectionChange =>
      connectionChangeController.stream;

  void _connectionChange(ConnectivityResult result) {
    checkConnection();
  }

  //! METHOD TO PERFORM ACTUAL LOOK UP
  Future<bool> checkConnection() async {
    const prevStatus = ConnectivityStatus.offline;

    try {
      final result = await InternetAddress.lookup(AppUrls.example);
      if (result.isNotEmpty && result[0].rawAddress.isNotEmpty) {
        hasConnection = true;
        networkStatus = ConnectivityStatus.online;
      } else {
        hasConnection = false;
        networkStatus = ConnectivityStatus.offline;
      }
    } on SocketException catch (_) {
      hasConnection = false;
      networkStatus = ConnectivityStatus.offline;
    }

    //! STATUS CHANGE SENDS OUT UPDATE TO ALL LISTENERS
    if (prevStatus != networkStatus) {
      connectionChangeController.add(networkStatus);
      onChange();
    }

    return hasConnection;
  }

  //! HELPER METHOD TO LISTEN TO CONTINUOUS CHANGES
  void onChange() {
    _connectivity.onConnectivityChanged.listen(_connectionChange);
  }

  void disposeStream() {
    _controller.close();
  }
}
