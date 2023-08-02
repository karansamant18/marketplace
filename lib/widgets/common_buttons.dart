import 'package:flutter/material.dart';
import 'package:flutter_mobile_bx/view/bottom_bar.dart';
import 'package:flutter_svg/svg.dart';
import 'package:webviewx/webviewx.dart';

import '../const/color.dart';
import '../const/image.dart';
import '../helpers/sizes.dart';
import '../helpers/user_auth.dart';

class CommonButton {
  static Widget gradientButton(
      BuildContext context, String title, void Function()? onTap,
      {Widget? trailing}) {
    return Center(
      child: GestureDetector(
        onTap: onTap,
        child: Container(
          // width: ww() / 2.7,
          decoration: BoxDecoration(
            gradient: const LinearGradient(
              begin: Alignment.topLeft,
              end: Alignment.bottomRight,
              colors: [
                Color(0xffE13662),
                Color(0xffEB4954),
                Color(0xffD346F0),
              ],
            ),
            borderRadius: BorderRadius.circular(30),
          ),
          padding: EdgeInsets.symmetric(
              horizontal: ww() * 0.05, vertical: hh() * 0.012),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              const SizedBox(),
              Text(
                title,
                style: TextStyle(
                  color: ConstColor.whiteColor,
                  fontSize: hh() * 0.018,
                  fontWeight: FontWeight.bold,
                ),
              ),
              trailing ??
                  SvgPicture.asset(
                    ConstImage.flashIcon,
                  )
            ],
          ),
        ),
      ),
    );
  }

  static Widget outlinedButton(
    BuildContext context,
    String title,
    void Function()? onTap,
  ) {
    return Center(
      child: GestureDetector(
        onTap: onTap,
        child: Container(
          width: ww() / 2.7,
          decoration: BoxDecoration(
              color: Colors.transparent,
              borderRadius: BorderRadius.circular(30),
              border: Border.all(color: Colors.white)),
          padding: EdgeInsets.symmetric(
              horizontal: ww() * 0.05, vertical: hh() * 0.012),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              const SizedBox(),
              Text(
                title,
                style: TextStyle(
                  color: ConstColor.whiteColor,
                  fontSize: hh() * 0.018,
                  fontWeight: FontWeight.bold,
                ),
              ),
              SvgPicture.asset(
                ConstImage.flashIcon,
              )
            ],
          ),
        ),
      ),
    );
  }

  static Widget solidButton(
      BuildContext context, String title, void Function()? onTap,
      {Widget trailing = const Icon(
        Icons.arrow_forward_ios_rounded,
        color: Colors.red,
      ),
      Color bgColor = Colors.white,
      TextStyle titleStyle = const TextStyle(
        color: Colors.red,
        fontSize: 18,
        fontWeight: FontWeight.bold,
      )}) {
    return Center(
      child: GestureDetector(
        onTap: onTap,
        child: Container(
          // width: ww() / 2.7,
          decoration: BoxDecoration(
              color: bgColor,
              borderRadius: BorderRadius.circular(30),
              border: Border.all(color: Colors.white)),
          padding: EdgeInsets.symmetric(
              horizontal: ww() * 0.05, vertical: hh() * 0.012),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              const SizedBox(),
              Text(
                title,
                style: titleStyle,
              ),
              trailing
            ],
          ),
        ),
      ),
    );
  }

  Widget logoutButton(BuildContext context) {
    return CommonButton.gradientButton(
      context,
      "Logout",
      () {
        UserAuth.allLogout();
      },
      trailing: Icon(
        Icons.arrow_forward_ios_rounded,
        color: Colors.white,
      ),
    );
  }

  static Widget loginButton({required BuildContext context, Widget? nextPage}) {
    return CommonButton.solidButton(
      context,
      "Login",
      () {
        UserAuth()
            .showLoginBlinkX(afterLoginPage: nextPage ?? BottomBarScreen());
      },
    );
  }

  static Widget createAccountButton(
      {required BuildContext context, Widget? nextPage}) {
    return CommonButton.solidButton(
      context,
      "Create Account",
      () {
             Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => SafeArea(
                          child: Scaffold(
                            body: WebViewX(
                              height: double.infinity,
                              width: double.infinity,
                              javascriptMode: JavascriptMode.unrestricted,
                              initialSourceType: SourceType.url,
                              initialContent: "https://signup.blinkx.in/diy/mobile",
                            ),
                          ),
                        ),
                      ),
                    );
        // UserAuth()
        //     .showLoginBlinkX(afterLoginPage: nextPage ?? BottomBarScreen());
      },
    );
  }
}
