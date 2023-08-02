import 'package:flutter/material.dart';
import 'package:flutter_mobile_bx/const/color.dart';
import 'package:flutter_svg/flutter_svg.dart';

import '../const/image.dart';

class Logo extends StatelessWidget {
  const Logo({super.key});

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return SvgPicture.asset(
      ConstImage.appLogoSvg,
      // height: 100,
      color: ConstColor.whiteColor,
      width: size.width * 0.3,
      // width: size.width * 0.2,

      // fit: BoxFit.fill,
    );
  }
}
