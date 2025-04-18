// utils/responsive_helper.dart
import 'package:flutter/material.dart';

enum DeviceType { mobile, tablet, desktop }

class ResponsiveHelper {
  static DeviceType getDeviceType(BuildContext context) {
    double width = MediaQuery.of(context).size.width;
    if (width < 600) {
      return DeviceType.mobile;
    } else if (width < 1200) {
      return DeviceType.tablet;
    } else {
      return DeviceType.desktop;
    }
  }

  static bool isMobile(BuildContext context) =>
      getDeviceType(context) == DeviceType.mobile;

  static bool isTablet(BuildContext context) =>
      getDeviceType(context) == DeviceType.tablet;

  static bool isDesktop(BuildContext context) =>
      getDeviceType(context) == DeviceType.desktop;

  static double getContentWidth(BuildContext context) {
    double width = MediaQuery.of(context).size.width;
    if (width < 600) {
      return width * 0.9; // 90% of screen width on mobile
    } else if (width < 1200) {
      return width * 0.85; // 85% of screen width on tablet
    } else {
      return 1140; // Fixed width on desktop
    }
  }

  static EdgeInsets getScreenPadding(BuildContext context) {
    if (isMobile(context)) {
      return EdgeInsets.symmetric(horizontal: 20);
    } else if (isTablet(context)) {
      return EdgeInsets.symmetric(horizontal: 40);
    } else {
      return EdgeInsets.symmetric(horizontal: 60);
    }
  }

  static double getFontSize(BuildContext context, double desktopSize) {
    if (isMobile(context)) {
      return desktopSize * 0.8; // 80% of desktop size on mobile
    } else if (isTablet(context)) {
      return desktopSize * 0.9; // 90% of desktop size on tablet
    } else {
      return desktopSize;
    }
  }
}
