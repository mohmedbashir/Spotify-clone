import 'package:flutter/services.dart';

void setStatusBarColor(Color color) {
  SystemChrome.setSystemUIOverlayStyle(SystemUiOverlayStyle(
    statusBarColor: color, // set status bar color
    statusBarIconBrightness: color.computeLuminance() > 0.5
        ? Brightness.dark
        : Brightness
            .light, // set status bar icon brightness based on color luminance
  ));
}
