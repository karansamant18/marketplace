// ignore_for_file: prefer_const_constructors

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_mobile_bx/const/color.dart';
import 'package:flutter_mobile_bx/const/keys.dart';
import 'package:flutter_mobile_bx/const/styles.dart';
import 'package:flutter_mobile_bx/helpers/common_functions.dart';
import 'package:flutter_mobile_bx/helpers/sizes.dart';
import 'package:flutter_mobile_bx/helpers/user_auth.dart';
import 'package:flutter_mobile_bx/view/buy_stock/controller/order_place_controller.dart';
import 'package:flutter_mobile_bx/view/user_profile/controller/user_profile_controller.dart';
import 'package:flutter_mobile_bx/view/user_profile/model/user_profile_model.dart';
import 'package:flutter_mobile_bx/widgets/common_buttons.dart';
import 'package:provider/provider.dart';

import '../../const/image.dart';
import '../auth/screen/widget/auth_card.dart';

class UserProfileScreen extends StatefulWidget {
  const UserProfileScreen({super.key});

  @override
  State<UserProfileScreen> createState() => _UserProfileScreenState();
}

class _UserProfileScreenState extends State<UserProfileScreen> {
  UserProfileController userProfileController = UserProfileController();
  OrderPlaceController orderPlaceController = OrderPlaceController();

  UserProfile? userProfile;
  String name = preferences.getString(Keys.userName) ?? "N/A";
  String phone = preferences.getString(Keys.userPhoneNo) ?? "N/A";

  String? availFunds = '0.0';

  @override
  void initState() {
    userProfileController =
        Provider.of<UserProfileController>(context, listen: false);
    orderPlaceController =
        Provider.of<OrderPlaceController>(context, listen: false);
    userProfileController.jmUserProfileController();
    if (UserAuth().isJmClient() && UserAuth().isLoggedInBlinkX()) {
      orderPlaceController.orderLimitsController({
        "Segment": "ALL",
        "Exchange": "ALL",
        "ProductType": "ALL"
      }).then((value) {
        setState(() {
          availFunds = value.data!.data!.availableMargin!.toStringAsFixed(2);
        });
      });
    }

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Scaffold(
      backgroundColor: Colors.transparent,
      body: Container(
        decoration: BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.centerLeft,
            end: Alignment.centerRight,
            colors: ConstColor.mainThemeGradient,
          ),
        ),
        height: hh(),
        width: ww(),
        child: Container(
          // padding: const EdgeInsets.fromLTRB(30, 30, 30, 0),
          child: Column(
            // mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              GestureDetector(
                onTap: () {
                  Navigator.pop(context);
                  // Navigator.push(
                  //   context,
                  //   MaterialPageRoute(
                  //     builder: (context) => BottomBarScreen(),
                  //   ),
                  // );
                },
                child: Container(
                  padding: const EdgeInsets.fromLTRB(30, 50, 30, 10),
                  child: Icon(
                    Icons.arrow_back,
                    size: size.height * 0.035,
                    color: ConstColor.whiteColor,
                  ),
                ),
              ),
              Expanded(
                child: Container(
                  padding: const EdgeInsets.fromLTRB(30, 30, 30, 0),
                  decoration: const BoxDecoration(
                    color: Color.fromARGB(255, 0, 0, 0),
                    borderRadius: BorderRadius.only(
                      topLeft: Radius.circular(25),
                      topRight: Radius.circular(25),
                    ),
                  ),
                  width: ww(),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      // sh(height: 35),
                      Text(
                        "Profile",
                        style: TextStyle(
                          color: ConstColor.whiteColor,
                          fontSize: hh() * 0.03,
                          // fontWeight: FontWeight.bold,
                        ),
                      ),
                      sh(height: 30),
                      buildProfileView(size),
                    ],
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget buildProfileView(Size size) {
    return Consumer<UserProfileController>(builder: (context, value, child) {
      if (value.userProfileModel.data != null) {
        return const Expanded(
          child: SizedBox(
            // height: size.height * 0.618,
            child: Center(child: CircularProgressIndicator()),
          ),
        );
      } else {
        // userProfile = value.userProfileModel.data!.data;
        return Container(
          child: Column(
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Column(
                    children: [
                      Container(
                        padding: const EdgeInsets.all(20),
                        decoration: BoxDecoration(
                          color: Colors.teal,
                          borderRadius: BorderRadius.circular(35),
                        ),
                        child: const Icon(
                          Icons.card_travel_rounded,
                          color: ConstColor.whiteColor,
                          size: 32,
                        ),
                      ),
                      sh(),
                    ],
                  ),
                  sw(width: 20),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      sh(height: 80),
                      Text(
                        name.capitalize(),
                        style: const TextStyle(
                          color: ConstColor.whiteColor,
                          fontSize: 20,
                        ),
                      ),
                      sh(),
                      Row(
                        children: [
                          // Icon(
                          //   Icons.call,
                          //   color: Colors.white,
                          //   size: hh() / 40,
                          // ),
                          // sw(),
                          Text(
                            "Phone: $phone",
                            style: const TextStyle(
                              color: ConstColor.whiteColor,
                            ),
                          ),
                        ],
                      ),
                      // sh(),
                      // Text(
                      //   userProfile?.email ?? "-",
                      //   style: const TextStyle(
                      //     color: ConstColor.whiteColor,
                      //   ),
                      // ),
                      // sh(height: 70),
                      // Text(
                      //   userProfile?.mobileno ?? "-",
                      //   style: const TextStyle(
                      //     color: ConstColor.whiteColor,
                      //   ),
                      // ),
                      // buttonPill(
                      //   size,
                      //   onTapFn: () {},
                      //   title: "Account Details",
                      // ),
                    ],
                  ),
                ],
              ),

              // sh(height: 2),
              sh(height: 40),

              UserAuth().isJmClient()
                  ? UserAuth().isLoggedInBlinkX()
                      ? Padding(
                          padding: EdgeInsets.symmetric(
                            horizontal: 0 * 0.05,
                          ),
                          child: buildFundsView(size),
                        )
                      : AuthCard.loginCard(context,
                          text:
                              "Login to your BlinkX account \nto see funds and holdings",
                          nextPage: UserProfileScreen())
                  : AuthCard.createAccountCard(context),
              // sh(height: 2),
              sh(height: 40),

              // sh(height: 15),
              sh(),
              // Spacer(),

              // Row(
              //   children: [
              //     Expanded(child: CommonButton().logoutButton(context)),
              //   ],
              // ),
            ],
          ),
        );
      }
    });
  }

  Widget _blinkXCard() {
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
              "Create a Demat account to start \nyour investment journey!",
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

  Widget buildKycView(Size size) {
    return Container(
      padding: const EdgeInsets.symmetric(vertical: 15, horizontal: 20),
      decoration: BoxDecoration(
        color: ConstColor.whiteColor,
        borderRadius: BorderRadius.circular(20),
      ),
      child: Row(
        children: [
          const Icon(
            Icons.info,
            color: Color(0xffE43C5E),
            size: 18,
          ),
          sw(),
          const Text(
            "KYC Verification Pending",
            style: TextStyle(
              color: Color(0xffE43C5E),
              fontSize: 11,
            ),
          ),
          const Spacer(),
          buttonPill(
            size,
            onTapFn: () {},
            title: "Complete",
          ),
        ],
      ),
    );
  }

  Widget buildFundsView(Size size) {
    return Container(
      padding: const EdgeInsets.symmetric(vertical: 15, horizontal: 20),
      decoration: BoxDecoration(
        color: ConstColor.whiteColor,
        borderRadius: BorderRadius.circular(20),
      ),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.end,
        children: [
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const Text(
                "FUNDS",
                style: TextStyle(
                  // color: Color(0xffE43C5E),
                  fontSize: 16,
                ),
              ),
              sh(height: 50),
              Text(
                "\u{20B9} ${availFunds.toString()}",
                style: TextStyle(
                  // color: Color(0xffE43C5E),
                  fontSize: 16,
                ),
              ),
            ],
          ),
          const Spacer(),
          Column(
            children: [
              buttonPill(
                size,
                onTapFn: () {},
                title: "Add Funds",
              ),
            ],
          )
        ],
      ),
    );
  }

  Widget buttonPill(
    Size size, {
    required Function() onTapFn,
    required String title,
  }) {
    return GestureDetector(
      onTap: onTapFn,
      child: Container(
        padding: const EdgeInsets.symmetric(vertical: 10, horizontal: 25),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(25),
          gradient: LinearGradient(
            begin: Alignment.centerLeft,
            end: Alignment.centerRight,
            colors: ConstColor.mainThemeGradient,
          ),
        ),
        child: Text(
          title,
          style: const TextStyle(
            color: ConstColor.whiteColor,
            fontSize: 12,
          ),
        ),
      ),
    );
  }
}
