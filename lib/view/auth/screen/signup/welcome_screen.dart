import 'package:flutter/material.dart';
import 'package:flutter_mobile_bx/const/color.dart';
import 'package:flutter_mobile_bx/const/image.dart';
import 'package:flutter_mobile_bx/const/keys.dart';
import 'package:flutter_mobile_bx/view/auth/controller/auth_controller.dart';
import 'package:flutter_mobile_bx/view/auth/screen/signup/pin_success_screen.dart';
import 'package:flutter_mobile_bx/view/bottom_bar.dart';
import 'package:flutter_mobile_bx/widgets/loder.dart';
import 'package:flutter_otp_text_field/flutter_otp_text_field.dart';
import 'package:flutter_svg/flutter_svg.dart';

class WelcomeScreen extends StatefulWidget {
  final String accessToken;
  final String phoneNo;
  const WelcomeScreen({
    super.key,
    required this.accessToken,
    required this.phoneNo,
  });

  @override
  State<WelcomeScreen> createState() => _WelcomeScreenState();
}

class _WelcomeScreenState extends State<WelcomeScreen> {
  AuthController authController = AuthController();
  TextEditingController nameController = TextEditingController();
  bool isConfimEnable = false;

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Scaffold(
      backgroundColor: const Color(0xffD646D1),
      body: SingleChildScrollView(
        child: Column(
          children: [
            _buildBackground(size),
            _buidNameFiled(size),
          ],
        ),
      ),
    );
  }

  //Name Filed
  Widget _buidNameFiled(Size size) {
    return Container(
      height: size.height / 3,
      decoration: const BoxDecoration(
        color: ConstColor.whiteColor,
        borderRadius: BorderRadius.only(
          topLeft: Radius.circular(20),
          topRight: Radius.circular(20),
        ),
      ),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Padding(
            padding: EdgeInsets.symmetric(horizontal: size.width * 0.08),
            child: Column(
              children: [
                SizedBox(height: size.height * 0.05),
                TextFormField(
                  controller: nameController,
                  keyboardType: TextInputType.name,
                  decoration: InputDecoration(
                    contentPadding:
                        EdgeInsets.symmetric(horizontal: size.width * 0.05),
                    focusedBorder: OutlineInputBorder(
                        borderSide:
                            const BorderSide(color: ConstColor.greyColor),
                        borderRadius: BorderRadius.circular(30)),
                    border: OutlineInputBorder(
                        borderSide:
                            const BorderSide(color: ConstColor.greyColor),
                        borderRadius: BorderRadius.circular(30)),
                    hintText: 'Enter First Namer',
                  ),
                ),
                SizedBox(height: size.height * 0.04),
                _buildGetStartedButton(size)
              ],
            ),
          ),
          SizedBox(height: size.height * 0.08),
        ],
      ),
    );
  }

  //Build Get Started Button
  Widget _buildGetStartedButton(Size size) {
    return MaterialButton(
      color: ConstColor.violet61Color,
      padding: EdgeInsets.symmetric(
          vertical: size.height * 0.018, horizontal: size.width * 0.05),
      onPressed: () async {
        showLoader(context);
        final response = await authController.updateFirstNameController(
            userName: nameController.text.trim());

        if (response.status == 200) {
          if (!mounted) return;
          hideLoder(context);
          preferences.setString(
              Keys.accessToken, "Bearer ${widget.accessToken}");
          preferences.setString(Keys.userPhoneNo, widget.phoneNo);
          Navigator.pushReplacement(
            context,
            MaterialPageRoute(
              builder: (context) => const BottomBarScreen(),
            ),
          );
        } else {
          if (!mounted) return;
          hideLoder(context);
        }
      },
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(30)),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(
            'Get Started',
            style: TextStyle(
              color: ConstColor.whiteColor,
              fontSize: size.height * 0.02,
              fontWeight: FontWeight.bold,
            ),
          ),
          Icon(
            Icons.arrow_forward_ios_rounded,
            size: size.height * 0.02,
            color: ConstColor.whiteColor,
          )
        ],
      ),
    );
  }

  Widget _buildBackground(Size size) {
    return Container(
      height: size.height / 1.5,
      decoration: BoxDecoration(
        gradient: LinearGradient(
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
          colors: [
            const Color(0xffE43C5E).withOpacity(0.8),
            const Color(0xffD646D1).withOpacity(0.8),
            const Color(0xffD646D1).withOpacity(0.8),
          ],
        ),
      ),
      child: Padding(
        padding: EdgeInsets.symmetric(horizontal: size.width * 0.05),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            SizedBox(height: size.height * 0.05),
            Image.asset(ConstImage.appLogoImg),
            SizedBox(height: size.height * 0.1),
            Center(
              child: Column(
                children: [
                  Padding(
                    padding: EdgeInsets.only(right: size.width * 0.1),
                    child: SvgPicture.asset(ConstImage.cupIcon),
                  ),
                  SizedBox(height: size.height * 0.05),
                  Text(
                    "Awesome! You're \non board!",
                    textAlign: TextAlign.center,
                    style: TextStyle(
                      color: ConstColor.whiteColor,
                      fontSize: size.height * 0.04,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ],
              ),
            )
          ],
        ),
      ),
    );
  }

  Future<void> _buildSetPinSheet(BuildContext context, Size size) {
    return showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.only(
        topLeft: Radius.circular(size.height * 0.05),
        topRight: Radius.circular(size.height * 0.05),
      )),
      builder: (context) {
        return Padding(
          padding: EdgeInsets.symmetric(horizontal: size.width * 0.05),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              SizedBox(height: size.height * 0.035),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    'Set MPIN',
                    style: TextStyle(
                      color: ConstColor.violetColor,
                      fontSize: size.height * 0.03,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                  IconButton(
                    onPressed: () {
                      Navigator.of(context).pop();
                      setState(() {
                        isConfimEnable = false;
                        // otpText = verificationCode;
                      });
                    },
                    icon: const Icon(
                      Icons.close,
                      color: ConstColor.violet4BColor,
                    ),
                  ),
                ],
              ),
              SizedBox(height: size.height * 0.015),
              Text(
                "Enter your MPIN",
                style: TextStyle(
                  color: ConstColor.greyColor,
                  fontSize: size.height * 0.015,
                  fontWeight: FontWeight.bold,
                ),
              ),
              SizedBox(height: size.height * 0.035),
              SizedBox(
                height: size.height * 0.1,
                child: Center(
                  child: OtpTextField(
                    numberOfFields: 6,
                    autoFocus: true,
                    obscureText: true,
                    focusedBorderColor: ConstColor.greyColor,
                    margin:
                        const EdgeInsets.symmetric(horizontal: 5, vertical: 15),
                    borderRadius: BorderRadius.circular(50),
                    borderColor: ConstColor.greyColor,
                    decoration: const InputDecoration(
                      contentPadding: EdgeInsets.zero,
                      focusedBorder: OutlineInputBorder(
                        borderSide: BorderSide(color: ConstColor.greyColor),
                      ),
                      border: OutlineInputBorder(
                        borderSide: BorderSide(color: ConstColor.greyColor),
                      ),
                    ),
                    showFieldAsBox: true,
                    onCodeChanged: (String code) {},
                    onSubmit: (String verificationCode) {
                      setState(() {
                        isConfimEnable = true;
                        // otpText = verificationCode;
                      });
                    },
                  ),
                ),
              ),
              SizedBox(height: size.height * 0.035),
              _buildButtonView(
                context: context,
                size: size,
                title: 'Confirm',
                onTap: isConfimEnable
                    ? () async {
                        Navigator.pushReplacement(
                          context,
                          MaterialPageRoute(
                            builder: (context) => const PinSucsessScreen(),
                          ),
                        );
                      }
                    : () {},
              ),
              SizedBox(height: size.height / 3),
            ],
          ),
        );
      },
    );
  }

  Widget _buildButtonView({
    required BuildContext context,
    required Size size,
    required String title,
    required void Function() onTap,
  }) {
    return Center(
      child: GestureDetector(
        onTap: onTap,
        child: Container(
          width: size.width / 2.5,
          decoration: BoxDecoration(
            gradient: LinearGradient(
              begin: Alignment.topLeft,
              end: Alignment.bottomRight,
              colors: isConfimEnable
                  ? [
                      const Color(0xffE13662),
                      const Color(0xffEB4954),
                      const Color(0xffD346F0),
                    ]
                  : [
                      const Color(0xffE13662).withOpacity(0.4),
                      const Color(0xffEB4954).withOpacity(0.4),
                      const Color(0xffD346F0).withOpacity(0.4),
                    ],
            ),
            borderRadius: BorderRadius.circular(30),
          ),
          padding: EdgeInsets.symmetric(
              horizontal: size.width * 0.05, vertical: size.height * 0.012),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              const SizedBox(),
              Text(
                title,
                style: TextStyle(
                  color: ConstColor.whiteColor,
                  fontSize: size.height * 0.018,
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
}
