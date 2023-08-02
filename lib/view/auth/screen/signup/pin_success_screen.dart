import 'package:flutter/material.dart';
import 'package:flutter_mobile_bx/const/color.dart';
import 'package:flutter_mobile_bx/view/bottom_bar.dart';

class PinSucsessScreen extends StatefulWidget {
  const PinSucsessScreen({super.key});

  @override
  State<PinSucsessScreen> createState() => _PinSucsessScreenState();
}

class _PinSucsessScreenState extends State<PinSucsessScreen> {
  @override
  void initState() {
    Future.delayed(
      const Duration(seconds: 3),
      () => Navigator.pushReplacement(
        context,
        MaterialPageRoute(
          builder: (context) => const BottomBarScreen(),
        ),
      ),
    );
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Scaffold(
      backgroundColor: ConstColor.violet4BColor,
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(
              'MPIN Set Successfully',
              style: TextStyle(
                color: ConstColor.whiteColor,
                fontSize: size.height * 0.035,
                fontWeight: FontWeight.w600,
              ),
            ),
            SizedBox(height: size.height * 0.035),
            Text(
              'You will now be automatically \nredirect to app',
              textAlign: TextAlign.center,
              style: TextStyle(
                color: ConstColor.whiteColor,
                fontSize: size.height * 0.015,
                fontWeight: FontWeight.w400,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
