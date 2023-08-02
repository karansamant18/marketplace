import 'package:flutter/material.dart';

import '../../../../const/image.dart';
import '../../../../const/styles.dart';
import '../../../../helpers/sizes.dart';
import '../../../../widgets/common_buttons.dart';
import '../../../bottom_bar.dart';

class AuthCard {
  static Widget loginCard(BuildContext context,{ String text = "Login to your BlinkX account \nto see holdings",Widget? nextPage }) {
    return Container(
        decoration: gradientDeco.copyWith(
            borderRadius: BorderRadius.all(Radius.circular(20))),
        // height: hh() / 3,
        // width: ww() / 1.4,
        child: Column(
          children: [
            sh(height: 30),
            Image.asset(
              ConstImage.onBoarding2,
              height: hh() / 5,
            ),
            sh(height: 30),
            Text(
            text ,
              style: sTitleLarge,
              textAlign: TextAlign.center,
            ),
            // sh(height: 30),
            // Text(
            //   "Click login to generate session",
            //   textAlign: TextAlign.center,
            //   style:
            //       sBodySmall.copyWith(color: Colors.white, fontSize: hh() / 50),
            // ),
            sh(height: 30),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: CommonButton.loginButton(context: context,nextPage: nextPage ?? BottomBarScreen()),
            )
          ],
        ));
  }

  static Widget createAccountCard(BuildContext context) {
    return Container(
        decoration: gradientDeco.copyWith(
            borderRadius: BorderRadius.all(Radius.circular(20))),
        // height: hh() / 3,
        // width: ww() / 1.4,
        child: Column(
          children: [
            sh(height: 30),
            Image.asset(
              ConstImage.onBoarding2,
              height: hh() / 5,
            ),
            sh(height: 30),
            Text(
              "Join the BlinkX \nfamily",
              style: sTitleLarge,
              textAlign: TextAlign.center,
            ),
            sh(height: 30),
            Text(
              "Login to start \nyour investment journey!",
              textAlign: TextAlign.center,
              style:
                  sBodySmall.copyWith(color: Colors.white, fontSize: hh() / 50),
            ),
            sh(height: 30),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: CommonButton.createAccountButton(context: context),
            )
          ],
        ));
  }
}
