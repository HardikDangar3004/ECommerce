import 'package:flutter/widgets.dart';

/// Centralized padding and margin constants and helpers
class UISpacing {
  // Padding constants
  static const double padding_30 = 30;
  static const double padding_24 = 24;
  static const double padding_20 = 20;
  static const double padding_18 = 18;
  static const double padding_16 = 16;
  static const double padding_15 = 15;
  static const double padding_14 = 14;
  static const double padding_12 = 12;
  static const double padding_11 = 11;
  static const double padding_10 = 10;
  static const double padding_8 = 8;
  static const double padding_7 = 7;
  static const double padding_6 = 6;
  static const double padding_5 = 5;
  static const double padding_4 = 4;
  static const double padding_3 = 3;
  static const double padding_2 = 2;
  static const double padding_1 = 1;
  static const double padding_32 = 32;
  static const double padding_48 = 48;
  static const double padding_64 = 64;

  // Margin constants (same values)
  static const double margin_30 = 30;
  static const double margin_24 = 24;
  static const double margin_20 = 20;
  static const double margin_18 = 18;
  static const double margin_16 = 16;
  static const double margin_15 = 15;
  static const double margin_14 = 14;
  static const double margin_12 = 12;
  static const double margin_11 = 11;
  static const double margin_10 = 10;
  static const double margin_8 = 8;
  static const double margin_7 = 7;
  static const double margin_6 = 6;
  static const double margin_5 = 5;
  static const double margin_4 = 4;
  static const double margin_3 = 3;
  static const double margin_2 = 2;
  static const double margin_1 = 1;
  // convenience duplicates removed (margin_8 and margin_16 already defined)

  // EdgeInsets helpers for convenience
  static EdgeInsets all(double v) => EdgeInsets.all(v);
  static EdgeInsets symmetric({double horizontal = 0, double vertical = 0}) =>
      EdgeInsets.symmetric(horizontal: horizontal, vertical: vertical);
  static EdgeInsets only({
    double left = 0,
    double top = 0,
    double right = 0,
    double bottom = 0,
  }) => EdgeInsets.only(left: left, top: top, right: right, bottom: bottom);
}
