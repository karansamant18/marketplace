import 'package:flutter/material.dart';
import 'package:flutter_mobile_bx/helpers/sizes.dart';
import 'package:flutter_svg/svg.dart';

import '../const/color.dart';
import '../const/image.dart';

class CommonAppBar {
  static AppBar appBar(BuildContext context) {
    return AppBar(
      backgroundColor: Colors.transparent,
      elevation: 0,
      leading: Container(
          child: SvgPicture.asset(
        ConstImage.appLogoSvg,
        // height: 100,
        color: ConstColor.whiteColor,
        width: ww() * 0.8,
        // width: size.width * 0.2,

        // fit: BoxFit.fill,
      )),
    );
  }
}
