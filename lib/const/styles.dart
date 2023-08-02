import 'package:flutter/material.dart';
import 'package:flutter_mobile_bx/const/color.dart';

import '../helpers/sizes.dart';

TextStyle sTitleLarge = TextStyle(
  color: ConstColor.whiteColor,
  fontSize: hh() * 0.03,
  fontWeight: FontWeight.w600,
);
TextStyle sTitleMedium = TextStyle(
  color: ConstColor.whiteColor,
  fontSize: hh() * 0.015,
  fontWeight: FontWeight.w700,
);
TextStyle sTitleSmall = TextStyle(
  color: ConstColor.whiteColor,
  fontSize: hh() * 0.005,
  fontWeight: FontWeight.w400,
);
TextStyle sBodySmall = TextStyle(
  color: ConstColor.blackColor,
  fontSize: hh() * 0.017,
);

   BoxDecoration gradientDeco = BoxDecoration(
                    gradient: LinearGradient(
                      begin: Alignment.centerLeft,
                      end: Alignment.centerRight,
                      colors: [
                        Color(0xFFE13662),
                        Color(0xffEB4954),
                        ConstColor.violetF0Color,
                      ],
                    ),
                    // borderRadius: BorderRadius.circular(10),
                  );
