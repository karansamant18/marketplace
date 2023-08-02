// ignore_for_file: prefer_const_literals_to_create_immutables, prefer_const_constructors

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_mobile_bx/const/keys.dart';
import 'package:flutter_mobile_bx/view/blinkx_profile/api/blinkx_user_api.dart';
import 'package:flutter_svg/svg.dart';
import 'package:fluttertoast/fluttertoast.dart';

import '../../../const/color.dart';
import '../../../const/image.dart';
import '../../../const/styles.dart';
import '../../../helpers/navigation_context.dart';
import '../../../helpers/sizes.dart';
import '../../../widgets/common_buttons.dart';
import '../../bottom_bar.dart';

class EnterProfileScreen extends StatefulWidget {
  EnterProfileScreen({super.key});

  @override
  State<EnterProfileScreen> createState() => _EnterProfileScreenState();
}

class _EnterProfileScreenState extends State<EnterProfileScreen> {
  late TextEditingController nameController;

  late GlobalKey<FormState> formKey;
  @override
  void initState() {
    nameController = TextEditingController();
    formKey = GlobalKey<FormState>();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.transparent,
      body: SingleChildScrollView(
        padding: EdgeInsets.only(
            bottom: MediaQuery.of(Navigation().context).viewInsets.bottom + 10),
        child: Container(
          height: hh(),
          width: ww(),
          decoration: BoxDecoration(
            gradient: LinearGradient(
              colors: [
                Color.fromARGB(255, 235, 73, 84),
                // Color.fromARGB(255, 0, 0, 0),
                Color.fromARGB(255, 0, 0, 0),
                Color.fromARGB(255, 0, 0, 0),
                Color.fromARGB(255, 0, 0, 0),
                Color.fromARGB(255, 0, 0, 0),
                Color.fromARGB(0, 0, 0, 0),
              ],
              begin: Alignment.topLeft,
              end: Alignment.centerRight,
            ),
          ),
          child: Padding(
            padding: const EdgeInsets.all(28.0),
            child: Column(children: [
              sh(height: 30),
              Row(
                children: [
                  SvgPicture.asset(
                    ConstImage.appLogoSvg,
                    color: ConstColor.whiteColor,
                    width: ww() * 0.23,
                  ),
                ],
              ),
              sh(height: 15),
              Column(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Container(
                    height: hh() / 3,
                    width: ww() / 2,
                    child: ClipRRect(
                      borderRadius: BorderRadius.circular(20),
                      child: Image.asset(
                        ConstImage.onBoarding2,
                        fit: BoxFit.fill,
                      ),
                    ),
                  ),
                  sh(height: 10),
                  // Text(
                  //   "Research with high \nlevel accuracy",
                  //   textAlign: TextAlign.center,
                  //   style: sTitleLarge.copyWith(fontSize: hh() / 24),
                  // ),
                  Form(
                    key: formKey,
                    child: Container(
                      decoration: BoxDecoration(
                          // color: Colors.red,
                          // border: Border(
                          //   bottom:
                          //       BorderSide(color: ConstColor.greyColor, width: 2),
                          // ),
                          ),
                      child: TextFormField(
                        controller: nameController,
                        style: sTitleLarge.copyWith(fontSize: hh() / 50),
                        decoration: InputDecoration(
                          // border: InputBorder.none,
                          contentPadding:
                              EdgeInsets.symmetric(horizontal: ww() * 0.05),

                          enabledBorder: OutlineInputBorder(
                              borderSide:
                                  const BorderSide(color: ConstColor.greyColor),
                              borderRadius: BorderRadius.circular(30)),
                          // border: OutlineInputBorder(
                          //     borderSide:
                          //         const BorderSide(color: ConstColor.greyColor),
                          //     borderRadius: BorderRadius.circular(30)),
                          hintText: 'Enter Your firstname',

                          hintStyle: TextStyle(color: ConstColor.greyColor),
                        ),
                        validator: (value) {
                          if (value!.isEmpty) {
                            return "Please enter your firstname";
                          } else if (value.contains(" ")) {
                            return "Please enter only firstname";
                          } else {
                            return null;
                          }
                        },
                      ),
                    ),
                  ),
                  sh(height: 40),
                  Text("Username is needed to \ncreate your profile",
                      textAlign: TextAlign.center,
                      style: sBodySmall.copyWith(
                        color: Colors.white,
                      )),
                ],
              ),
              Spacer(),
              Row(
                children: [
                  Expanded(
                    child: CommonButton.solidButton(context, "Save", () {
                      _updateName();
                    }),
                  ),
                ],
              ),
              sh(height: 10),
            ]),
          ),
        ),
      ),
    );
  }

  _updateName() async {
    bool data = formKey.currentState!.validate();
    if (data) {
      Map<String, dynamic> data = {
        'firstName': nameController.text,
        'phoneNo': preferences.getString(Keys.userPhoneNo) ?? "",
      };
      bool status = await BlinkxUserApi().updateUserProfileApi(data);
      if (status) {
        Fluttertoast.showToast(
          msg: "Name has been updated",
          toastLength: Toast.LENGTH_SHORT,
          gravity: ToastGravity.BOTTOM,
          timeInSecForIosWeb: 1,
          backgroundColor: ConstColor.greenColor37,
          textColor: Colors.white,
          fontSize: 16.0,
        );
        Navigator.pushAndRemoveUntil(
          context,
          MaterialPageRoute(
            builder: (context) => BottomBarScreen(),
          ),
          (Route<dynamic> route) => route is BottomBarScreen,
        );
      } else {
        Fluttertoast.showToast(
          msg: "Failed to update the name, Please try again.",
          toastLength: Toast.LENGTH_SHORT,
          gravity: ToastGravity.BOTTOM,
          timeInSecForIosWeb: 1,
          backgroundColor: const Color.fromARGB(255, 236, 54, 67),
          textColor: Colors.white,
          fontSize: 16.0,
        );
      }
    }
  }
}
