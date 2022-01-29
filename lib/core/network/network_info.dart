import 'package:data_connection_checker/data_connection_checker.dart';

/// Find out if the user is online
abstract class NetworkInfo {
  Future<bool> get isConnected;
}

// Put the 3rd party library here so that we can change something different directly here in the future
// Instead of changing the code in different places
class NetworkInfoImpl implements NetworkInfo {
  final DataConnectionChecker connectionChecker;

  NetworkInfoImpl(this.connectionChecker);

  @override
  Future<bool> get isConnected => connectionChecker.hasConnection;
}
