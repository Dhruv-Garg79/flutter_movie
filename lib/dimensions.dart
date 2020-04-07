import 'package:flutter/widgets.dart';

class Dimensions{
  
  static const double small = 8.0;
  static const double medium = 16.0;
  static const double big = 20.0;

  static double imageWidth(BuildContext context){
    return MediaQuery.of(context).size.width * 0.35;
  }
}