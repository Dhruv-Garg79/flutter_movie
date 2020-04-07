import 'package:flutter/material.dart';
import 'package:movie/providers/network_provider.dart';
import 'package:provider/provider.dart';

class NetworkWidget extends StatelessWidget {
  final Widget child;
  NetworkWidget({this.child});

  @override
  Widget build(BuildContext context) {
    bool isOnline = Provider.of<NetworkProvider>(context).isOnline;
    return isOnline
        ? child
        : Container(
            alignment: Alignment.center,
            child: Text(
              'No Network! please check your internet connection.',
              textAlign: TextAlign.center,
            ),
          );
  }
}
