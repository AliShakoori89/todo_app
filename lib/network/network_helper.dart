import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:todo_app/bloc/network_bloc/bloc.dart';
import 'package:todo_app/bloc/network_bloc/event.dart';

class NetworkHelper {

  static void observeNetwork() {
    Connectivity().onConnectivityChanged.listen((ConnectivityResult result) {
      if (result == ConnectivityResult.none) {
        NetworkBloc().add(NetworkNotify());
      } else {
        NetworkBloc().add(NetworkNotify(isConnected: true));
      }
    });
  }
}