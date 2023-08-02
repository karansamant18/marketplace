import 'package:flutter/material.dart';
import 'package:flutter_mobile_bx/const/color.dart';
import 'package:flutter_mobile_bx/helpers/sizes.dart';

class Pill {
  static Widget textPill({
    required String head,
    required String value,
    TextStyle headStyle = const TextStyle(
      color: ConstColor.whiteColor,
    ),
    TextStyle valueStyle = const TextStyle(
      color: ConstColor.whiteColor,
    ),
    double gapHeight = 0.01,
    CrossAxisAlignment crossAxisAlignment = CrossAxisAlignment.center,
    MainAxisAlignment mainAxisAlignment = MainAxisAlignment.center,
  }) {
    return Column(
      mainAxisAlignment: mainAxisAlignment,
      crossAxisAlignment: crossAxisAlignment,
      children: [
        Text(
          head,
          style: headStyle,
        ),
        SizedBox(height: hh() * gapHeight),
        Text(
          value,
          style: valueStyle,
        ),
        // Container(
        //   margin: EdgeInsets.symmetric(
        //     horizontal: ww() * 0.01,
        //   ),
        //   padding: EdgeInsets.symmetric(
        //     vertical: hh() * 0.01,
        //     horizontal: ww() * 0.02,
        //   ),
        //   child: Text('NA'),
        // )
      ],
    );
  }

  static Widget widgetTextPill({
    required Widget head,
    required String value,
    double gapHeight = 0.01,
    CrossAxisAlignment crossAxisAlignment = CrossAxisAlignment.center,
    MainAxisAlignment mainAxisAlignment = MainAxisAlignment.center,
    TextStyle valueStyle = const TextStyle(
      color: ConstColor.whiteColor,
    ),
  }) {
    return Column(
      mainAxisAlignment: mainAxisAlignment,
      crossAxisAlignment: crossAxisAlignment,
      children: [
        head,
        SizedBox(height: hh() * gapHeight),
        Text(
          value,
          style: valueStyle,
        ),
      ],
    );
  }
}
