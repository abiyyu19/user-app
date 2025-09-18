import 'package:flutter/material.dart';

extension BuildContextEntension<T> on BuildContext {
  Size get screenSize => MediaQuery.sizeOf(this);

  double get screenWidth => screenSize.width;
  double screenWidthPercentage({final double percent = 1}) => screenWidth * percent / 100;

  double get screenHeight => screenSize.height;
  double screenHeightPercentage({final double percent = 1}) => screenHeight * percent / 100;

  double get screenShortestSide => screenSize.shortestSide;
  double get screenLongestSide => screenSize.longestSide;
  bool get isTablet => screenShortestSide > 600;

  Orientation get screenOrientation => MediaQuery.orientationOf(this);
  EdgeInsets get screenPadding => MediaQuery.viewPaddingOf(this);
  EdgeInsets get screenInsets => MediaQuery.viewInsetsOf(this);
  TextTheme get textTheme => Theme.of(this).textTheme;
}
