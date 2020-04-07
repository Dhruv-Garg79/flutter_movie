import 'package:connectivity/connectivity.dart';
import 'package:flutter/widgets.dart';

class NetworkProvider with ChangeNotifier {

  bool _isOnline = true;

  NetworkProvider(){
    Connectivity().onConnectivityChanged.listen((ConnectivityResult result){
      _isOnline = result != ConnectivityResult.none;
      notifyListeners();
    });
  }

  bool get isOnline => _isOnline;
}