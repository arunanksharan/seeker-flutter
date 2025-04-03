import 'package:flutter/material.dart';

class AppSpacing {
  static const double space0 = 0.0;
  static const double space0_5 = 2.0;
  static const double space1 = 4.0;
  static const double space2 = 8.0;
  static const double space3 = 12.0;
  static const double space4 = 16.0;
  static const double space5 = 20.0;
  static const double space6 = 24.0;
  static const double space7 = 28.0;
  static const double space8 = 32.0;
  static const double space9 = 36.0;
  static const double space10 = 40.0;
  static const double space12 = 48.0;
  static const double space16 = 64.0;
  static const double space20 = 80.0;
  static const double space24 = 96.0;
  static const double space32 = 128.0;
  static const double space40 = 160.0;
  static const double space48 = 192.0;
  static const double space56 = 224.0;
  static const double space64 = 256.0;

  // Convenience EdgeInsets
  static const EdgeInsets all0 = EdgeInsets.all(space0);
  static const EdgeInsets all1 = EdgeInsets.all(space1);
  static const EdgeInsets all2 = EdgeInsets.all(space2);
  static const EdgeInsets all3 = EdgeInsets.all(space3);
  static const EdgeInsets all4 = EdgeInsets.all(space4);
  static const EdgeInsets all5 = EdgeInsets.all(space5);
  static const EdgeInsets all6 = EdgeInsets.all(space6);

  static const EdgeInsets symmetricH1 = EdgeInsets.symmetric(horizontal: space1);
  static const EdgeInsets symmetricH2 = EdgeInsets.symmetric(horizontal: space2);
  static const EdgeInsets symmetricH3 = EdgeInsets.symmetric(horizontal: space3);
  static const EdgeInsets symmetricH4 = EdgeInsets.symmetric(horizontal: space4);
  static const EdgeInsets symmetricH5 = EdgeInsets.symmetric(horizontal: space5);
  static const EdgeInsets symmetricH6 = EdgeInsets.symmetric(horizontal: space6);

  static const EdgeInsets symmetricV1 = EdgeInsets.symmetric(vertical: space1);
  static const EdgeInsets symmetricV2 = EdgeInsets.symmetric(vertical: space2);
  static const EdgeInsets symmetricV3 = EdgeInsets.symmetric(vertical: space3);
  static const EdgeInsets symmetricV4 = EdgeInsets.symmetric(vertical: space4);
  static const EdgeInsets symmetricV5 = EdgeInsets.symmetric(vertical: space5);
  static const EdgeInsets symmetricV6 = EdgeInsets.symmetric(vertical: space6);
}

class AppRadius {
  static const double none = 0.0;
  static const double sm = 2.0;
  static const double md = 4.0;
  static const double lg = 8.0;
  static const double xl = 12.0;
  static const double xxl = 16.0;
  static const double xxxl = 24.0;
  static const double full = 9999.0;

  // Convenience BorderRadius
  static const BorderRadius radiusNone = BorderRadius.all(Radius.circular(none));
  static const BorderRadius radiusSm = BorderRadius.all(Radius.circular(sm));
  static const BorderRadius radiusMd = BorderRadius.all(Radius.circular(md));
  static const BorderRadius radiusLg = BorderRadius.all(Radius.circular(lg));
  static const BorderRadius radiusXl = BorderRadius.all(Radius.circular(xl));
  static const BorderRadius radiusXXl = BorderRadius.all(Radius.circular(xxl));
  static const BorderRadius radiusXXXl = BorderRadius.all(Radius.circular(xxxl));
  static const BorderRadius radiusFull = BorderRadius.all(Radius.circular(full));
}

// Note: Direct translation of shadows is tricky as Flutter's elevation handles it differently.
// We can define BoxShadows if needed, but often relying on Material widget elevation is simpler.
class AppShadows {
  static const List<BoxShadow> none = [];

  static const List<BoxShadow> xs = [
    BoxShadow(
      color: Color.fromRGBO(0, 0, 0, 0.05),
      offset: Offset(0, 1),
      blurRadius: 1.0,
    ),
  ];

  static const List<BoxShadow> sm = [
    BoxShadow(
      color: Color.fromRGBO(0, 0, 0, 0.1),
      offset: Offset(0, 1),
      blurRadius: 2.0,
    ),
  ];

  static const List<BoxShadow> md = [
    BoxShadow(
      color: Color.fromRGBO(0, 0, 0, 0.1),
      offset: Offset(0, 2),
      blurRadius: 4.0,
    ),
  ];

  static const List<BoxShadow> lg = [
    BoxShadow(
      color: Color.fromRGBO(0, 0, 0, 0.1),
      offset: Offset(0, 4),
      blurRadius: 6.0,
    ),
  ];

  static const List<BoxShadow> xl = [
    BoxShadow(
      color: Color.fromRGBO(0, 0, 0, 0.1),
      offset: Offset(0, 6),
      blurRadius: 8.0,
    ),
  ];
}
