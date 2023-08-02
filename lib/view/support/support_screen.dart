// ignore_for_file: prefer_const_constructors
import 'package:flutter/material.dart';
import 'package:flutter_mobile_bx/const/image.dart';
import 'package:flutter_mobile_bx/const/styles.dart';
import 'package:flutter_mobile_bx/helpers/sizes.dart';
import 'package:url_launcher/url_launcher.dart';

class SupportScreen extends StatelessWidget {
  SupportScreen({super.key});
  String mailId = "support.blinkxadvice@blinkx.in";
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        body: Container(
          decoration: gradientDeco,
          child:
              Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
            IconButton(
              icon: Icon(
                Icons.arrow_back,
                color: Colors.white,
              ),
              onPressed: () {
                Navigator.pop(context);
              },
            ),
            sh(),
            Expanded(
              child: Container(
                width: ww(),
                decoration: BoxDecoration(
                    color: Colors.black,
                    borderRadius: BorderRadius.only(
                      topLeft: Radius.circular(20),
                      topRight: Radius.circular(20),
                    )),
                child: Column(
                  // crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    sh(height: 30),
                    Padding(
                      padding: const EdgeInsets.only(left: 30),
                      child: Align(
                        alignment: Alignment.topLeft,
                        child: Text(
                          "Support",
                          style: sTitleLarge,
                        ),
                      ),
                    ),
                    sh(height: 10),
                    Image.asset(
                      ConstImage.onBoarding2,
                      height: hh() / 3.8,
                    ),
                    sh(height: 10),
                    Text(
                      "It looks like you are experiencing \ndifficulties. Don't worry, we are here to \nhelp you!",
                      textAlign: TextAlign.center,
                      style: sBodySmall.copyWith(
                          color: Colors.white, fontSize: hh() / 45),
                    ),
                    sh(height: 15),
                    GestureDetector(
                      onTap: _launchMail,
                      child: RichText(
                          text: TextSpan(
                              text: "Email us at ",
                              style: sBodySmall.copyWith(
                                  color: Colors.white, fontSize: hh() / 45),
                              children: [
                            TextSpan(
                                text: mailId,
                                style: sTitleMedium.copyWith(
                                    color: Color.fromARGB(255, 212, 70, 240),
                                    fontSize: hh() / 45,
                                    decoration: TextDecoration.underline)),
                            TextSpan(
                              text: "\n to get support for your problems.",
                              style: sBodySmall.copyWith(
                                  color: Colors.white, fontSize: hh() / 45),
                            )
                          ])),
                    ),
                  ],
                ),
              ),
            ),
          ]),
        ),
      ),
    );
  }

  _launchMail() async {
    String url = "mailto:" + mailId;
//Uri.parse("mailto:$email?subject=$subject&body=$body");
    var uri = await Uri.parse(url);
    if (await canLaunchUrl(uri)) {
      await launchUrl(uri);
    } else {
      throw 'Could not launch $url';
    }
  }
}
