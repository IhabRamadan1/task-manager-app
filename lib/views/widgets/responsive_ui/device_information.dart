import 'package:flutter/cupertino.dart';

import 'device_type_enum.dart';

class DeviceInformation {
  DeviceType deviceType;
  final double localHeight;
  final double localWidth;
  final double screenHeight;

  final double screenwidth;
  final Orientation orientation;
  DeviceInformation(
      {
        required   this.deviceType,
         required this.localHeight,
         required  this.localWidth,
        required   this.screenHeight,
        required   this.screenwidth,
        required   this.orientation});
}