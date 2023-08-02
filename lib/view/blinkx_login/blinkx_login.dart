// ignore_for_file: use_build_context_synchronously
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter_mobile_bx/const/keys.dart';
import 'package:flutter_mobile_bx/const/styles.dart';
import 'package:flutter_mobile_bx/helpers/sizes.dart';
import 'package:flutter_mobile_bx/helpers/user_auth.dart';
import 'package:flutter_mobile_bx/view/auth/screen/widget/auth_card.dart';
import 'package:flutter_mobile_bx/view/support/support_screen.dart';
import 'package:flutter_mobile_bx/websocket/web_socket.dart';
import 'package:flutter_svg/svg.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:pin_code_fields/pin_code_fields.dart';

import '../../const/color.dart';
import '../../const/image.dart';
import '../buy_stock/buy_stock_screen.dart';

class BlinkxLogin extends StatefulWidget {
  BlinkxLogin({super.key, this.nextPage = const BuyStockScreen()});
  Widget nextPage;

  @override
  State<BlinkxLogin> createState() => _BlinkxLoginState();
}

class _BlinkxLoginState extends State<BlinkxLogin> {
  late TextEditingController clientIdCtrl;
  final GlobalKey<FormState> formKey = GlobalKey<FormState>();
  final GlobalKey<FormState> otpFormKey = GlobalKey<FormState>();
  late TextEditingController passwordCtrl;
  late TextEditingController otpCtrl;
  late bool otpSent;
  bool showPass = false;
  @override
  void initState() {
    otpSent = false;

    if (kDebugMode) {
      clientIdCtrl = TextEditingController(text: "156324183");
      passwordCtrl = TextEditingController(text: "Eyta)226");
    } else {
      clientIdCtrl =
          TextEditingController(text: preferences.getString(Keys.userIdBlinkx));
      passwordCtrl = TextEditingController();
    }
    // passwordCtrl = TextEditingController();
    // clientIdCtrl = TextEditingController();
    otpCtrl = TextEditingController();
    // TODO: implement initState
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return UserAuth().isJmClient()
        ? Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                "Login to BlinkX",
                style: sTitleLarge.copyWith(color: Colors.black),
              ),
              sh(height: 20),
              loginForm(),
              // sh(height: 2),
            ],
          )
        : AuthCard.createAccountCard(context);
  }

  Widget loginForm() {
    return Form(
        key: formKey,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'Client ID',
              style: sBodySmall,
            ),
            sh(),
            TextFormField(
              enabled: (preferences.getString(Keys.userIdBlinkx) != null &&
                      preferences.getString(Keys.userIdBlinkx) != "")
                  ? false
                  : true,
              // enabled: false,
              autofocus: false,
              controller: clientIdCtrl,
              keyboardType: TextInputType.text,
              decoration: InputDecoration(
                contentPadding: EdgeInsets.symmetric(horizontal: ww() * 0.05),
                focusedBorder: OutlineInputBorder(
                    borderSide: BorderSide(color: ConstColor.greyColor),
                    borderRadius: BorderRadius.circular(30)),
                border: OutlineInputBorder(
                    borderSide: const BorderSide(color: ConstColor.greyColor),
                    borderRadius: BorderRadius.circular(30)),
                hintText: 'Enter Client Id',
                // prefixIcon: const Padding(
                //   padding: EdgeInsets.all(15),
                //   child: Text('+91 '),
                // ),
              ),
              validator: (value) {
                if (value!.isEmpty) {
                  return "Please Enter a Id";
                } else {
                  return null;
                }
              },
            ),
            sh(height: 50),
            Text(
              'Password',
              style: sBodySmall,
            ),
            sh(),
            StatefulBuilder(
                builder: (BuildContext context, StateSetter setStates) {
              return TextFormField(
                autofocus: true,
                controller: passwordCtrl,
                obscureText: (showPass == true) ? false : true,
                // keyboardType: TextInputType.number,
                decoration: InputDecoration(
                  suffixIcon: (showPass == true)
                      ? GestureDetector(
                          onTap: () {
                            setStates(() {
                              showPass = false;
                            });
                          },
                          child: const Icon(
                            Icons.visibility_off,
                            color: ConstColor.greyColor,
                          ),
                        )
                      : GestureDetector(
                          onTap: () {
                            setStates(() {
                              showPass = true;
                            });
                          },
                          child: const Icon(
                            Icons.visibility,
                            color: ConstColor.greyColor,
                          ),
                        ),
                  contentPadding: EdgeInsets.symmetric(horizontal: ww() * 0.05),
                  focusedBorder: OutlineInputBorder(
                      borderSide: BorderSide(color: ConstColor.greyColor),
                      borderRadius: BorderRadius.circular(30)),
                  border: OutlineInputBorder(
                      borderSide: const BorderSide(color: ConstColor.greyColor),
                      borderRadius: BorderRadius.circular(30)),
                  hintText: 'Enter password',
                ),
                validator: (value) {
                  if (value!.isEmpty) {
                    return "Please Enter a password";
                  } else {
                    return null;
                  }
                },
                // validator: (value) {
                //   if (value!.isEmpty) {
                //     return "Please Enter a Phone Number";
                //   } else if (!RegExp(
                //           r'^\s*(?:\+?(\d{1,3}))?[-. (]*(\d{3})[-. )]*(\d{3})[-. ]*(\d{4})(?: *x(\d+))?\s*$')
                //       .hasMatch(value)) {
                //     return "Please Enter a Valid Phone Number";
                //   } else {
                //     return null;
                //   }
                // },
              );
            }),
            sh(height: 50),
            Row(
              children: [
                GestureDetector(
                  onTap: () {
                    FocusManager.instance.primaryFocus?.unfocus();
                    Future.delayed(const Duration(milliseconds: 700), () {
                      Navigator.pushReplacement(
                        context,
                        MaterialPageRoute(
                          builder: (context) => SupportScreen(),
                        ),
                      );
                    });
                  },
                  child: RichText(
                    text: TextSpan(
                      text: "Trouble signing in?",
                      style: sBodySmall.copyWith(color: Colors.black),
                      children: [
                        TextSpan(
                            text: "\nClick here",
                            style: sTitleMedium.copyWith(color: Colors.blue))
                      ],
                    ),
                  ),
                ),
                Spacer(),
                _buildButtonView(context, "Submit", blinkXloginFun),
                // _otpView()
              ],
            ),
          ],
        ));
  }

  blinkXloginFun() async {
    bool valid = formKey.currentState!.validate();
    if (valid) {
      var data = {
        "LoginId": clientIdCtrl.text.toUpperCase(),
        "Password": passwordCtrl.text,
        "Dob": "",
        "Pan": "",
        "ApkVersion": "1.0.2",
        "Source": "MOB",
        "LoginDevice": "Android",
        "imei": "123123123",
        "DevId": "000000",
        "FactorTwo": ""
      };

      bool status = await UserAuth().loginBlinkX(body: data);
      // bool status = true;
      if (status) {
        preferences.setString(
            Keys.userIdBlinkx, clientIdCtrl.text.toUpperCase());
        // Navigator.pop(context);
        CommonSocket().advisiorySocket();
        Navigator.pop(context);
        Navigator.pushReplacement(
          context,
          MaterialPageRoute(
            builder: (context) => widget.nextPage,
          ),
        );
        // FocusScope.of(context).unfocus();
        // CommonDialogs.dialog(widget: _otpView());
      } else {
        Fluttertoast.showToast(
          msg: "Login failed, try again",
          toastLength: Toast.LENGTH_SHORT,
          gravity: ToastGravity.BOTTOM,
          timeInSecForIosWeb: 1,
          backgroundColor: const Color.fromARGB(255, 245, 78, 90),
          textColor: Colors.white,
          fontSize: 16.0,
        );
      }
    }
  }

  Widget _otpView() {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        mainAxisSize: MainAxisSize.min,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Expanded(
                child: Text(
                  'Enter the OTP sent',
                  style: TextStyle(
                    color: ConstColor.violetColor,
                    fontSize: hh() * 0.025,
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
                  Icons.close,
                  color: ConstColor.violet4BColor,
                ),
              ),
            ],
          ),
          sh(),
          SizedBox(
            // height: hh() / 4,
            child: Center(
              child: Form(
                key: otpFormKey,
                child: PinCodeTextField(
                  length: 6,
                  obscureText: false,
                  autoFocus: true,
                  autoDisposeControllers: false,
                  animationType: AnimationType.fade,
                  pinTheme: PinTheme(
                    selectedFillColor: ConstColor.greyColor.withOpacity(0.6),
                    inactiveColor: ConstColor.greyColor.withOpacity(0.7),
                    inactiveFillColor: ConstColor.greyColor.withOpacity(0.7),
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
                  controller: otpCtrl,
                  onCompleted: (v) {},
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
          _buildButtonView(context, "Submit OTP", _otpFun),
        ],
      ),
    );
  }

  _otpFun() async {
    bool valid = true;
    // bool valid = otpFormKey.currentState!.validate();
    if (valid) {
      var data = {
        "LoginId": clientIdCtrl.text.toUpperCase(),
        "Password": passwordCtrl.text,
        "Dob": "",
        "Pan": "",
        "ApkVersion": "1.0.2",
        "Source": "MOB",
        "LoginDevice": "Android",
        "imei": "123123123",
        "DevId": "000000",
        "FactorTwo": otpCtrl.text
      };
      // bool status = true;
      bool status = await UserAuth().loginBlinkX(body: data);
      preferences.setString(Keys.userIdBlinkx, clientIdCtrl.text.toUpperCase());
      if (status) {
        Navigator.pop(context);
        Navigator.pop(context);
        Navigator.pushReplacement(
          context,
          MaterialPageRoute(
            builder: (context) => widget.nextPage,
          ),
        );
      }
    }
  }

  Widget _buildButtonView(
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
