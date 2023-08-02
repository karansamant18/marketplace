import 'package:flutter/material.dart';
import 'package:flutter_mobile_bx/const/color.dart';
import 'package:flutter_mobile_bx/const/image.dart';
import 'package:flutter_mobile_bx/const/keys.dart';
import 'package:flutter_mobile_bx/const/strings.dart';
import 'package:flutter_mobile_bx/const/styles.dart';
import 'package:flutter_mobile_bx/helpers/sizes.dart';
import 'package:flutter_mobile_bx/view/auth/controller/auth_controller.dart';
import 'package:flutter_mobile_bx/view/bottom_bar.dart';
import 'package:flutter_mobile_bx/widgets/loder.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:pin_code_fields/pin_code_fields.dart';

import '../auth/screen/update_profile_screen.dart';

class OnBoardingScreen extends StatefulWidget {
  OnBoardingScreen({super.key, this.fromBasket = false});
  bool fromBasket;

  @override
  State<OnBoardingScreen> createState() => _OnBoardingScreenState();
}

class _OnBoardingScreenState extends State<OnBoardingScreen> {
  AuthController authController = AuthController();
  TextEditingController phoneNoController = TextEditingController();
  TextEditingController otpController = TextEditingController();
  final GlobalKey<FormState> formKey = GlobalKey<FormState>();
  final GlobalKey<FormState> otpFormKey = GlobalKey<FormState>();

  String otpText = '';
  int _selectedIndex = 0;

  @override
  void dispose() {
    phoneNoController.dispose();
    otpController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Scaffold(
      body: PageView.builder(
        itemCount: 3,
        physics: const NeverScrollableScrollPhysics(),
        itemBuilder: (context, index) {
          return Stack(
            children: [
              _buildBakeground(size),
              _buildView(size),
            ],
          );
        },
      ),
    );
  }

  Widget _buildView(Size size) {
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: size.width * 0.05),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          SizedBox(height: size.height * 0.05),
          Align(
            alignment: Alignment.topLeft,
            child: SvgPicture.asset(
              ConstImage.appLogoSvg,
              color: ConstColor.whiteColor,
              height: size.height * 0.05,
            ),
          ),
          Padding(
            padding: EdgeInsets.symmetric(horizontal: size.width * 0.05),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              verticalDirection: VerticalDirection.up,
              children: [
                SizedBox(height: size.height * 0.05),
                Container(
                  height: size.height / 3,
                  width: size.width / 1.5,
                  child: Image.asset(
                    _selectedIndex == 0
                        ? ConstImage.onBoarding1
                        : _selectedIndex == 1
                            ? ConstImage.onBoarding2
                            : ConstImage.onBoarding3,
                  ),
                ),
                SizedBox(height: size.height * 0.05),
                Text(
                  _selectedIndex == 0
                      ? "Feature coming soon!"
                      : _selectedIndex == 1
                          ? ConstStrings.onBoarding2
                          : ConstStrings.onBoarding3,
                  textAlign: TextAlign.center,
                  style: sTitleMedium.copyWith(fontSize: hh() / 40),
                ),
                SizedBox(height: size.height * 0.03),
                Text(
                  _selectedIndex == 0
                      ? ConstStrings.onBoarding1SubText
                      : _selectedIndex == 1
                          ? ConstStrings.onBoarding2SubText
                          : ConstStrings.onBoarding3SubText,
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    color: ConstColor.whiteColor.withOpacity(0.8),
                    fontSize: size.height * 0.015,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                SizedBox(height: size.height * 0.03),
                Text(
                  _selectedIndex == 0
                      ? ConstStrings.onBoarding1
                      : _selectedIndex == 1
                          ? ConstStrings.onBoarding2
                          : ConstStrings.onBoarding3,
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    color: ConstColor.whiteColor,
                    fontSize: size.height * 0.04,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                SizedBox(height: size.height * 0.03),
                widget.fromBasket
                    ? SizedBox.shrink()
                    : Row(
                        children: [
                          _buildButton(
                            size: size,
                            image: ConstImage.arrowRightIcon,
                            onTap: () {
                              setState(() {
                                if (_selectedIndex == 0) {
                                  _selectedIndex = 1;
                                } else if (_selectedIndex == 1) {
                                  _selectedIndex = 2;
                                } else {
                                  phoneNoController.clear();
                                  _buildPhoneSheet(size);
                                }
                              });
                            },
                            title: 'Next',
                          ),
                          SizedBox(width: size.width * 0.07),
                          _buildLoginButton(size),
                        ],
                      )
              ],
            ),
          ),
        ],
      ),
    );
  }

  // Login Button
  Widget _buildLoginButton(Size size) {
    return _buildButton(
      size: size,
      image: ConstImage.flashIcon,
      onTap: () {
        phoneNoController.clear();
        // _buildOTPSheet(context, size);
        _buildPhoneSheet(size);
      },
      title: 'Login',
    );
  }

  Future<dynamic> _buildPhoneSheet(Size size) {
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
                    'Enter your phone \nnumber',
                    style: TextStyle(
                      color: ConstColor.violetColor,
                      fontSize: size.height * 0.03,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                  IconButton(
                    onPressed: () {
                      Navigator.of(context).pop();
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
                'We will send an SMS with a verification \ncode on this number',
                style: TextStyle(
                  color: ConstColor.greyColor,
                  fontSize: size.height * 0.015,
                  fontWeight: FontWeight.bold,
                ),
              ),
              SizedBox(height: size.height * 0.035),
              Form(
                key: formKey,
                child: TextFormField(
                  autofocus: true,
                  controller: phoneNoController,
                  keyboardType: TextInputType.number,
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
                    hintText: 'Enter Phone Number',
                    prefixIcon: const Padding(
                      padding: EdgeInsets.all(15),
                      child: Text('+91 '),
                    ),
                  ),
                  validator: (value) {
                    if (value!.isEmpty) {
                      return "Please Enter a Phone Number";
                    } else if (!RegExp(
                            r'^\s*(?:\+?(\d{1,3}))?[-. (]*(\d{3})[-. )]*(\d{3})[-. ]*(\d{4})(?: *x(\d+))?\s*$')
                        .hasMatch(value)) {
                      return "Please Enter a Valid Phone Number";
                    } else {
                      return null;
                    }
                  },
                ),
              ),
              SizedBox(height: size.height * 0.035),
              _buildButtonView(
                context,
                size,
                'Get OTP',
                () async {
                  if (formKey.currentState!.validate()) {
                    if (phoneNoController.text != '') {
                      showLoader(context);
                      final response = await authController.sendOtpController(
                          phoneNo: "91${phoneNoController.text.trim()}");
                      if (response.status == 200) {
                        if (!mounted) return;
                        hideLoder(context);
                        // Navigator.of(context).pop();
                        _buildOTPSheet(context, size);
                      } else {
                        if (!mounted) return;
                        hideLoder(context);
                      }
                    }
                  }
                },
              ),
              SizedBox(height: size.height / 3),
            ],
          ),
        );
      },
    );
  }

  Widget _buildButtonView(
    BuildContext context,
    Size size,
    String title,
    void Function()? onTap,
  ) {
    return Center(
      child: GestureDetector(
        onTap: onTap,
        child: Container(
          width: size.width / 2.7,
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

  Future<void> _buildOTPSheet(BuildContext context, Size size) {
    return showModalBottomSheet(
      context: context,
      isDismissible: false,
      isScrollControlled: true,
      backgroundColor: ConstColor.whiteColor,
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
                  Expanded(
                    child: Text(
                      'Enter the OTP sent on \n+91 ${phoneNoController.text}',
                      style: TextStyle(
                        color: ConstColor.violetColor,
                        fontSize: size.height * 0.025,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                  ),
                  IconButton(
                    onPressed: () {
                      // otpController.dispose();
                      Navigator.of(context).pop();
                    },
                    icon: const Icon(
                      Icons.edit,
                      color: ConstColor.violet4BColor,
                    ),
                  ),
                  IconButton(
                    onPressed: () {
                      // otpController.dispose();
                      Navigator.of(context).pop();
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
                "we've sent you a verification \ncode",
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
                  child: Form(
                    key: otpFormKey,
                    child: PinCodeTextField(
                      length: 6,
                      obscureText: false,
                      autoDisposeControllers: false,
                      animationType: AnimationType.fade,
                      pinTheme: PinTheme(
                        selectedFillColor:
                            ConstColor.greyColor.withOpacity(0.6),
                        inactiveColor: ConstColor.greyColor.withOpacity(0.7),
                        inactiveFillColor:
                            ConstColor.greyColor.withOpacity(0.7),
                        shape: PinCodeFieldShape.box,
                        disabledColor: ConstColor.greyColor.withOpacity(0.7),
                        activeColor: ConstColor.greyColor.withOpacity(0.7),
                        borderRadius: BorderRadius.circular(8),
                        fieldHeight: 50,
                        fieldWidth: 40,
                        borderWidth: 1,
                        activeFillColor: Colors.white,
                      ),
                      animationDuration: Duration(milliseconds: 300),
                      backgroundColor: ConstColor.whiteColor,
                      enableActiveFill: true,
                      controller: otpController,
                      onCompleted: (v) {
                        setState(() {
                          otpText = v;
                        });
                      },
                      onChanged: (value) {},
                      validator: (value) {
                        if (value!.isEmpty) {
                          return "Please Enter a OTP";
                        } else if (value.length != 6) {
                          return "Please Enter a OTP";
                        } else {
                          return null;
                        }
                      },
                      beforeTextPaste: (text) {
                        return true;
                      },
                      appContext: context,
                    ),
                  ),
                  // OtpTextField(
                  //   numberOfFields: 6,
                  //   autoFocus: true,
                  //   handleControllers: (controllers) {
                  //     debugPrint(controllers);
                  //   },
                  //   focusedBorderColor: ConstColor.greyColor,
                  //   margin:
                  //       const EdgeInsets.symmetric(horizontal: 5, vertical: 15),
                  //   borderRadius: BorderRadius.circular(50),
                  //   borderColor: ConstColor.greyColor,
                  //   decoration: const InputDecoration(
                  //     contentPadding: EdgeInsets.zero,
                  //     focusedBorder: OutlineInputBorder(
                  //       borderSide: BorderSide(color: ConstColor.greyColor),
                  //     ),
                  //     border: OutlineInputBorder(
                  //       borderSide: BorderSide(color: ConstColor.greyColor),
                  //     ),
                  //   ),
                  //   showFieldAsBox: true,
                  //   onCodeChanged: (String code) {},
                  //   onSubmit: (String verificationCode) {
                  //     setState(() {
                  //       otpText = verificationCode;
                  //     });
                  //   },
                  // ),
                ),
              ),
              SizedBox(height: size.height * 0.035),
              _buildButtonView(
                context,
                size,
                'Submit',
                () async {
                  if (otpFormKey.currentState!.validate()) {
                    if (phoneNoController.text != '') {
                      showLoader(context);
                      final response = await authController.verifyOtpController(
                          phoneNo: phoneNoController.text.trim(), otp: otpText);
                      if (response.data?.status != 'error') {
                        if (!mounted) return;
                        hideLoder(context);
                        preferences.setString(Keys.accessToken,
                            "Bearer ${response.data?.data?.accessToken}");
                        preferences.setString(Keys.userPhoneNo,
                            response.data?.data?.phoneNo ?? '');
                        if (response.data?.data?.profile.toString() ==
                            "false") {
                          Navigator.pushReplacement(
                            context,
                            MaterialPageRoute(
                              builder: (context) => EnterProfileScreen(),
                            ),
                          );
                        } else {
                          Navigator.pushReplacement(
                            context,
                            MaterialPageRoute(
                              builder: (context) => const BottomBarScreen(),
                            ),
                          );
                        }
                      } else {
                        if (!mounted) return;
                        hideLoder(context);
                      }
                    }
                  }
                },
              ),
              SizedBox(height: size.height / 2.7),
            ],
          ),
        );
      },
    );
  }

  //Build Button View
  Widget _buildButton(
      {required Size size,
      required String title,
      required String image,
      required void Function() onTap}) {
    return Expanded(
      child: GestureDetector(
        onTap: onTap,
        child: Container(
          decoration: BoxDecoration(
            border: Border.all(
              color: ConstColor.whiteColor,
              width: 2,
            ),
            borderRadius: BorderRadius.circular(size.height * 0.05),
          ),
          padding: EdgeInsets.symmetric(
            vertical: 10,
            horizontal: size.width * 0.04,
          ),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              const SizedBox(),
              Text(
                title,
                style: TextStyle(
                  color: ConstColor.whiteColor,
                  fontSize: size.height * 0.02,
                  fontWeight: FontWeight.bold,
                ),
              ),
              SvgPicture.asset(image)
            ],
          ),
        ),
      ),
    );
  }

  // Background
  Widget _buildBakeground(Size size) {
    return Container(
      height: size.height,
      width: size.width,
      decoration: BoxDecoration(
        gradient: LinearGradient(
          begin: Alignment.topLeft,
          end: Alignment.centerRight,
          colors: _selectedIndex == 0
              ? [
                  Color.fromARGB(255, 235, 73, 84),
                  // Color.fromARGB(255, 0, 0, 0),
                  Color.fromARGB(255, 0, 0, 0),
                  Color.fromARGB(255, 0, 0, 0),
                  Color.fromARGB(255, 0, 0, 0),
                  Color.fromARGB(255, 0, 0, 0),
                  Color.fromARGB(255, 0, 0, 0),
                ]
              : _selectedIndex == 1
                  ? [
                      Color(0xff542961),
                      Color(0xff542961).withOpacity(0.9),
                      Color(0xffD346F0),
                      Color(0xffD346F0).withOpacity(0.7),
                    ]
                  : [
                      Color(0xffB66ACA).withOpacity(0.9),
                      Color(0xff181DF3).withOpacity(0.6),
                      Color(0xff181DF3).withOpacity(0.7),
                      Color(0xff181DF3).withOpacity(0.8),
                      Color(0xff181DF3),
                    ],
        ),
      ),
    );
  }
}
