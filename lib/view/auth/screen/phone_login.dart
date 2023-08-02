import 'package:flutter/material.dart';

import 'otp_page.dart';

class PhoneLoginPage extends StatelessWidget {
  const PhoneLoginPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      // backgroundColor: Colors.transparent,
      body: Center(
          child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: TextField(
          keyboardType: TextInputType.phone,
          decoration: const InputDecoration(border: OutlineInputBorder()),
          onEditingComplete: () {
            Navigator.push(
              context,
              MaterialPageRoute(
                builder: (context) => const OtpPage(),
              ),
            );
          },
        ),
      )),
    );
  }
}
