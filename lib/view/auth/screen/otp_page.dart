import 'package:flutter/material.dart';
import 'package:flutter_otp_text_field/flutter_otp_text_field.dart';

class OtpPage extends StatelessWidget {
  const OtpPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: OtpTextField(
          numberOfFields: 6,
          showFieldAsBox: true,
          onCodeChanged: (String code) {},
          onSubmit: (String verificationCode) {
            debugPrint(verificationCode);
          },
        ),
      ),
    );
  }
}
