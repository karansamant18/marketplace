// ignore_for_file: prefer_const_literals_to_create_immutables, prefer_const_constructors

import 'dart:async';

import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:flutter_mobile_bx/const/color.dart';
import 'package:flutter_mobile_bx/const/styles.dart';
import 'package:flutter_mobile_bx/helpers/sizes.dart';
import 'package:flutter_mobile_bx/view/blinkx_profile/api/blinkx_user_api.dart';
import 'package:flutter_mobile_bx/view/user_profile/api/user_profile_api.dart';
import 'package:flutter_mobile_bx/widgets/common_buttons.dart';
import 'package:flutter_svg/svg.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:pin_code_fields/pin_code_fields.dart';
import '../../const/image.dart';
import '../../const/keys.dart';
import '../../widgets/common_textfield.dart';
import '../../widgets/loder.dart';
import '../auth/controller/auth_controller.dart';
import '../bottom_bar.dart';
import '../auth/screen/update_profile_screen.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  final GlobalKey<FormState> formKey = GlobalKey<FormState>();
  TextEditingController phoneNoController = TextEditingController();
  AuthController authController = AuthController();
  TextEditingController otpController = TextEditingController();
  String otpText = '';
  final GlobalKey<FormState> otpFormKey = GlobalKey<FormState>();
  // Bottom sheet timer
  Duration duration = Duration();
  Timer? timer;
  int seconds = 60;

  //to access setState of sheet
  late Function sheetSetState;

  // Start timer method
  void startTimer() {
    setState(() {
      seconds = 60;
    });
    //Not related to the answer but you should consider resetting the timer when it starts
    timer?.cancel();
    duration = duration = Duration();

    debugPrint("timer start");
    timer = Timer.periodic(Duration(seconds: 1), (_) => subTime());
  }

  void subTime() {
    if (seconds == 0) {
      sheetSetState(() {
        timer!.cancel();
      });
    } else {
      sheetSetState(() {
        seconds = seconds - 1;
      });
    }
  }

  @override
  void dispose() {
    timer!.cancel();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;

    return Scaffold(
      backgroundColor: Colors.transparent,
      body: Container(
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
          child: Column(
            children: [
              sh(height: 30),
              Row(
                children: [
                  SvgPicture.asset(
                    ConstImage.appLogoSvg,
                    color: ConstColor.whiteColor,
                    width: size.width * 0.23,
                  ),
                ],
              ),
              sh(height: 15),
              _buildPage(),
              sh(height: 15),
              CommonButton.outlinedButton(context, "Login", () {
                _buildPhoneSheet(size);
              })
            ],
          ),
        ),
      ),
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
                            .hasMatch(value) ||
                        value.length != 10) {
                      return "Please Enter a Valid Phone Number";
                    } else {
                      return null;
                    }
                  },
                ),
              ),
              SizedBox(height: size.height * 0.015),
              Text(
                "By submitting this, I agree to terms and conditions, research calls disclaimers and its terms and conditions.",
                style: TextStyle(
                  color: ConstColor.greyColor,
                  fontSize: size.height * 0.0125,
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
                        // startTimer(state: setStates);
                        startTimer();
                        _buildOTPSheet(context, size);
                      } else {
                        Fluttertoast.showToast(
                          msg: 'Too Many Atempts, Please Wait for Some time',
                          toastLength: Toast.LENGTH_SHORT,
                          gravity: ToastGravity.TOP,
                          timeInSecForIosWeb: 1,
                          backgroundColor: Colors.red,
                          textColor: Colors.white,
                          fontSize: 16.0,
                        );
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
                      otpController.text = "";
                      timer!.cancel();
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
                      timer!.cancel();
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
                      keyboardType: TextInputType.number,
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
              // SizedBox(height: size.height * 0.035),
              _buildResendOtp(size),
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
                        timer!.cancel();
                        if (!mounted) return;
                        preferences.setString(Keys.accessToken,
                            "Bearer ${response.data?.data?.accessToken}");

                        preferences.setString(Keys.userPhoneNo,
                            response.data!.data!.phoneNo ?? "");
                        preferences.setString(
                            Keys.userName, response.data?.data?.userName ?? '');
                        if (response.data?.data?.profile.toString() ==
                            "false") {
                          final getDetailsModel = await UserProfileApi()
                              .isJmClientApi(
                                  phoneNo:
                                      preferences.getString(Keys.userPhoneNo) ??
                                          '');
                          if (getDetailsModel.data != null) {
                            Map<String, dynamic> data = {
                              'firstName':
                                  getDetailsModel.data!.data!.firstName,
                              'phoneNo':
                                  preferences.getString(Keys.userPhoneNo) ?? "",
                            };
                            bool status = await BlinkxUserApi()
                                .updateUserProfileApi(data);
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
                              if (!mounted) return;
                              hideLoder(context);
                              Navigator.pushAndRemoveUntil(
                                  context,
                                  MaterialPageRoute(
                                    builder: (context) => BottomBarScreen(),
                                  ),
                                  (Route<dynamic> route) =>
                                      route is BottomBarScreen);
                            } else {
                              if (!mounted) return;
                              hideLoder(context);
                              Navigator.pushAndRemoveUntil(
                                  context,
                                  MaterialPageRoute(
                                    builder: (context) => EnterProfileScreen(),
                                  ),
                                  (Route<dynamic> route) =>
                                      route is SplashScreen);
                            }
                          } else {
                            if (!mounted) return;
                            hideLoder(context);
                            Navigator.pushAndRemoveUntil(
                                context,
                                MaterialPageRoute(
                                  builder: (context) => EnterProfileScreen(),
                                ),
                                (Route<dynamic> route) =>
                                    route is SplashScreen);
                          }
                        } else {
                          hideLoder(context);
                          if (!mounted) return;
                          Navigator.pushAndRemoveUntil(
                              context,
                              MaterialPageRoute(
                                builder: (context) => const BottomBarScreen(),
                              ),
                              (Route<dynamic> route) => route is SplashScreen);
                        }
                      } else {
                        Fluttertoast.showToast(
                          msg: 'Invalid OTP',
                          toastLength: Toast.LENGTH_SHORT,
                          gravity: ToastGravity.TOP,
                          timeInSecForIosWeb: 1,
                          backgroundColor: Colors.red,
                          textColor: Colors.white,
                          fontSize: 16.0,
                        );
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
    ).then((value) {
      otpController.text = "";
    });
  }

  Widget _buildResendOtp(Size size) {
    return StatefulBuilder(
        builder: (BuildContext context, StateSetter setStates) {
      sheetSetState = setStates;
      // int start = 60;
      // const oneSec = Duration(seconds: 1);
      // _timer = Timer.periodic(
      //   oneSec,
      //   (Timer timer) {
      //     if (start == 0) {
      //       setStates(() {
      //         timer.cancel();
      //       });
      //     } else {
      //       setStates(() {
      //         start = start - 1;
      //       });
      //     }
      //   },
      // );
      return Container(
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            seconds != 0
                ? Text("Time Remaining: ${seconds}s")
                : Text("Didn't recieve code?"),
            GestureDetector(
              onTap: () async {
                if (seconds == 0) {
                  if (formKey.currentState!.validate()) {
                    if (phoneNoController.text != '') {
                      showLoader(context);
                      final response = await authController.sendOtpController(
                          phoneNo: "91${phoneNoController.text.trim()}");
                      if (response.status == 200) {
                        if (!mounted) return;
                        hideLoder(context);
                        // Navigator.of(context).pop();
                        startTimer();
                        // _buildOTPSheet(context, size);
                        Fluttertoast.showToast(
                          msg: 'OTP Sent Successfully',
                          toastLength: Toast.LENGTH_SHORT,
                          gravity: ToastGravity.TOP,
                          timeInSecForIosWeb: 1,
                          backgroundColor: Colors.green,
                          textColor: Colors.white,
                          fontSize: 16.0,
                        );
                      } else {
                        Fluttertoast.showToast(
                          msg: 'Too Many Atempts, Please Wait for Some time',
                          toastLength: Toast.LENGTH_SHORT,
                          gravity: ToastGravity.TOP,
                          timeInSecForIosWeb: 1,
                          backgroundColor: Colors.red,
                          textColor: Colors.white,
                          fontSize: 16.0,
                        );
                        if (!mounted) return;
                        hideLoder(context);
                      }
                    }
                  }
                }
              },
              child: Text(
                "Resend OTP",
                style: TextStyle(
                  color: seconds == 0
                      ? ConstColor.violetColor
                      : ConstColor.greyColor,
                  decoration: TextDecoration.underline,
                ),
              ),
            ),
          ],
        ),
      );
    });
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

  Widget _buildPage() {
    return CarouselSlider(
      options: CarouselOptions(
        autoPlay: true,
        // scrollPhysics: const NeverScrollableScrollPhysics(),
        viewportFraction: 1,
        height: hh() * 0.65,
      ),
      items: [
        Column(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Container(
              height: hh() / 2.4,
              width: ww() / 1.2,
              child: ClipRRect(
                borderRadius: BorderRadius.circular(20),
                child: Image.asset(
                  ConstImage.hotcalls,
                  fit: BoxFit.fill,
                ),
              ),
            ),
            Text(
              "Research with high level accuracy",
              textAlign: TextAlign.center,
              style: sTitleLarge.copyWith(fontSize: 32),
            ),
            Text("Hot Calls put together by our excellent Research Analysts.",
                textAlign: TextAlign.center,
                style: sBodySmall.copyWith(
                  color: Colors.white.withOpacity(0.7),
                )),
          ],
        ),
        Column(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Container(
              height: hh() / 2.4,
              width: ww() / 1.2,
              child: ClipRRect(
                borderRadius: BorderRadius.circular(20),
                child: Image.asset(
                  ConstImage.blinxScreenshot,
                  fit: BoxFit.fill,
                ),
              ),
            ),
            Text(
              "Hand-picked from \nJM Superstars",
              textAlign: TextAlign.center,
              style: sTitleLarge.copyWith(fontSize: 32),
            ),
            Text("Choose from the calls made for you by our BlinkX Superstars",
                textAlign: TextAlign.center,
                style: sBodySmall.copyWith(
                  color: Colors.white.withOpacity(0.7),
                )),
          ],
        ),
      ],
    );
  }

  buildAwesomeBoard() {
    return Column(
      children: [
        Container(
          height: hh() / 20,
        ),
        Text(
          "Awesome! \nYou are on board!",
          textAlign: TextAlign.center,
          style: sTitleLarge.copyWith(fontSize: hh() / 24),
        ),
        sh(height: 25),
        SizedBox(
          height: hh() / 3.3,
          width: ww() / 2,
          child: Image.asset(
            ConstImage.awesome,
            fit: BoxFit.fill,
          ),
        ),
        sh(height: 25),
        CommonTextField().outlinedTextField(hintText: "Enter Your Name"),
        sh(height: 25),
        SizedBox(
            width: ww(),
            child: CommonButton.solidButton(context, "Get Started", () {}))
      ],
    );
  }
}
