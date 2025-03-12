import 'dart:async';
import 'dart:io';

import 'package:internet_connection_checker/internet_connection_checker.dart';

abstract class NetworkInfo {
  bool get isConnected;

  bool get isNotConnected;

  void dispose();
}

class NetworkInfoImpl implements NetworkInfo {
  final InternetConnectionChecker _connectionChecker;

  bool _isConnected = true;

  late final StreamSubscription<InternetConnectionStatus> _subscription;

  NetworkInfoImpl(this._connectionChecker) {
    _subscription = _connectionChecker.onStatusChange.listen(
      (InternetConnectionStatus status) {
        if (Platform.isAndroid || Platform.isIOS) {
          _isConnected = status == InternetConnectionStatus.connected;
        } else {
          _isConnected = true;
        }
      },
    );
  }

  @override
  void dispose() {
    _subscription.cancel();
  }

  @override
  bool get isConnected =>
      Platform.isAndroid || Platform.isIOS ? _isConnected : true;

  @override
  bool get isNotConnected =>
      Platform.isAndroid || Platform.isIOS ? !_isConnected : false;
}
