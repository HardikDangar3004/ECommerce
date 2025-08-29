import 'package:flutter/material.dart';

class ResponsiveUtils {
  // Breakpoints for different device types
  static const double mobileBreakpoint = 600;
  static const double tabletBreakpoint = 900;
  static const double desktopBreakpoint = 1200;

  // Screen size detection
  static bool isMobile(BuildContext context) {
    return MediaQuery.of(context).size.width < mobileBreakpoint;
  }

  static bool isTablet(BuildContext context) {
    final width = MediaQuery.of(context).size.width;
    return width >= mobileBreakpoint && width < tabletBreakpoint;
  }

  static bool isDesktop(BuildContext context) {
    return MediaQuery.of(context).size.width >= desktopBreakpoint;
  }

  static bool isMobileOrTablet(BuildContext context) {
    return MediaQuery.of(context).size.width < tabletBreakpoint;
  }

  // Get device type as enum
  static DeviceType getDeviceType(BuildContext context) {
    final width = MediaQuery.of(context).size.width;
    if (width < mobileBreakpoint) {
      return DeviceType.mobile;
    } else if (width < tabletBreakpoint) {
      return DeviceType.tablet;
    } else {
      return DeviceType.desktop;
    }
  }

  // Responsive spacing
  static double getResponsiveSpacing(
    BuildContext context, {
    double mobile = 16.0,
    double tablet = 24.0,
    double desktop = 32.0,
  }) {
    if (isMobile(context)) return mobile;
    if (isTablet(context)) return tablet;
    return desktop;
  }

  // Responsive padding
  static EdgeInsets getResponsivePadding(
    BuildContext context, {
    EdgeInsets? mobile,
    EdgeInsets? tablet,
    EdgeInsets? desktop,
  }) {
    if (isMobile(context)) {
      return mobile ?? const EdgeInsets.all(16.0);
    } else if (isTablet(context)) {
      return tablet ?? const EdgeInsets.all(24.0);
    } else {
      return desktop ?? const EdgeInsets.all(32.0);
    }
  }

  // Responsive font sizes
  static double getResponsiveFontSize(
    BuildContext context, {
    double mobile = 14.0,
    double tablet = 16.0,
    double desktop = 18.0,
  }) {
    if (isMobile(context)) return mobile;
    if (isTablet(context)) return tablet;
    return desktop;
  }

  // Responsive icon sizes
  static double getResponsiveIconSize(
    BuildContext context, {
    double mobile = 20.0,
    double tablet = 24.0,
    double desktop = 28.0,
  }) {
    if (isMobile(context)) return mobile;
    if (isTablet(context)) return tablet;
    return desktop;
  }

  // Responsive grid columns
  static int getResponsiveGridColumns(
    BuildContext context, {
    int mobile = 1,
    int tablet = 2,
    int desktop = 3,
  }) {
    if (isMobile(context)) return mobile;
    if (isTablet(context)) return tablet;
    return desktop;
  }

  // Responsive card dimensions
  static double getResponsiveCardWidth(
    BuildContext context, {
    double mobile = double.infinity,
    double tablet = 300.0,
    double desktop = 350.0,
  }) {
    if (isMobile(context)) return mobile;
    if (isTablet(context)) return tablet;
    return desktop;
  }

  // Responsive aspect ratios
  static double getResponsiveAspectRatio(
    BuildContext context, {
    double mobile = 1.0,
    double tablet = 1.2,
    double desktop = 1.5,
  }) {
    if (isMobile(context)) return mobile;
    if (isTablet(context)) return tablet;
    return desktop;
  }

  // Responsive margins
  static EdgeInsets getResponsiveMargins(
    BuildContext context, {
    EdgeInsets? mobile,
    EdgeInsets? tablet,
    EdgeInsets? desktop,
  }) {
    if (isMobile(context)) {
      return mobile ?? const EdgeInsets.symmetric(horizontal: 16.0);
    } else if (isTablet(context)) {
      return tablet ?? const EdgeInsets.symmetric(horizontal: 32.0);
    } else {
      return desktop ?? const EdgeInsets.symmetric(horizontal: 48.0);
    }
  }

  // Responsive border radius
  static double getResponsiveBorderRadius(
    BuildContext context, {
    double mobile = 8.0,
    double tablet = 12.0,
    double desktop = 16.0,
  }) {
    if (isMobile(context)) return mobile;
    if (isTablet(context)) return tablet;
    return desktop;
  }

  // Responsive elevation
  static double getResponsiveElevation(
    BuildContext context, {
    double mobile = 2.0,
    double tablet = 4.0,
    double desktop = 6.0,
  }) {
    if (isMobile(context)) return mobile;
    if (isTablet(context)) return tablet;
    return desktop;
  }

  // Responsive button height
  static double getResponsiveButtonHeight(
    BuildContext context, {
    double mobile = 48.0,
    double tablet = 56.0,
    double desktop = 64.0,
  }) {
    if (isMobile(context)) return mobile;
    if (isTablet(context)) return tablet;
    return desktop;
  }

  // Responsive input field height
  static double getResponsiveInputHeight(
    BuildContext context, {
    double mobile = 48.0,
    double tablet = 56.0,
    double desktop = 64.0,
  }) {
    if (isMobile(context)) return mobile;
    if (isTablet(context)) return tablet;
    return desktop;
  }

  // Responsive navigation bar height
  static double getResponsiveNavBarHeight(
    BuildContext context, {
    double mobile = 56.0,
    double tablet = 64.0,
    double desktop = 72.0,
  }) {
    if (isMobile(context)) return mobile;
    if (isTablet(context)) return tablet;
    return desktop;
  }

  // Responsive app bar height
  static double getResponsiveAppBarHeight(
    BuildContext context, {
    double mobile = 56.0,
    double tablet = 64.0,
    double desktop = 72.0,
  }) {
    if (isMobile(context)) return mobile;
    if (isTablet(context)) return tablet;
    return desktop;
  }

  // Responsive drawer width
  static double getResponsiveDrawerWidth(
    BuildContext context, {
    double mobile = 280.0,
    double tablet = 320.0,
    double desktop = 360.0,
  }) {
    if (isMobile(context)) return mobile;
    if (isTablet(context)) return tablet;
    return desktop;
  }

  // Responsive bottom sheet height
  static double getResponsiveBottomSheetHeight(
    BuildContext context, {
    double mobile = 0.5,
    double tablet = 0.6,
    double desktop = 0.7,
  }) {
    if (isMobile(context)) return mobile;
    if (isTablet(context)) return tablet;
    return desktop;
  }

  // Responsive dialog width
  static double getResponsiveDialogWidth(
    BuildContext context, {
    double mobile = 0.9,
    double tablet = 0.7,
    double desktop = 0.5,
  }) {
    if (isMobile(context)) return mobile;
    if (isTablet(context)) return tablet;
    return desktop;
  }

  // Responsive snackbar duration
  static Duration getResponsiveSnackBarDuration(
    BuildContext context, {
    Duration mobile = const Duration(seconds: 3),
    Duration tablet = const Duration(seconds: 4),
    Duration desktop = const Duration(seconds: 5),
  }) {
    if (isMobile(context)) return mobile;
    if (isTablet(context)) return tablet;
    return desktop;
  }

  // Responsive animation duration
  static Duration getResponsiveAnimationDuration(
    BuildContext context, {
    Duration mobile = const Duration(milliseconds: 200),
    Duration tablet = const Duration(milliseconds: 300),
    Duration desktop = const Duration(milliseconds: 400),
  }) {
    if (isMobile(context)) return mobile;
    if (isTablet(context)) return tablet;
    return desktop;
  }

  // Responsive scroll physics
  static ScrollPhysics getResponsiveScrollPhysics(BuildContext context) {
    if (isMobile(context)) {
      return const BouncingScrollPhysics();
    } else {
      return const ClampingScrollPhysics();
    }
  }

  // Responsive text scale factor
  static double getResponsiveTextScaleFactor(BuildContext context) {
    if (isMobile(context)) return 1.0;
    if (isTablet(context)) return 1.1;
    return 1.2;
  }

  // Responsive image quality
  static double getResponsiveImageQuality(BuildContext context) {
    if (isMobile(context)) return 0.8;
    if (isTablet(context)) return 0.9;
    return 1.0;
  }

  // Responsive cache size
  static int getResponsiveCacheSize(BuildContext context) {
    if (isMobile(context)) return 50;
    if (isTablet(context)) return 100;
    return 200;
  }
}

enum DeviceType { mobile, tablet, desktop }

// Extension methods for easier usage
extension ResponsiveContext on BuildContext {
  bool get isMobile => ResponsiveUtils.isMobile(this);
  bool get isTablet => ResponsiveUtils.isTablet(this);
  bool get isDesktop => ResponsiveUtils.isDesktop(this);
  bool get isMobileOrTablet => ResponsiveUtils.isMobileOrTablet(this);
  DeviceType get deviceType => ResponsiveUtils.getDeviceType(this);
}
