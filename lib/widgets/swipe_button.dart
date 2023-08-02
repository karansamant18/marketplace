import 'package:flutter/material.dart';
import 'package:flutter_mobile_bx/const/color.dart';
import 'package:slider_button/slider_button.dart';

class SwipeButton extends StatelessWidget {
  final Function swipeAction;
  final String buttonName;
  const SwipeButton({
    super.key,
    required this.swipeAction,
    required this.buttonName,
  });

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Container(
      decoration: const BoxDecoration(
        gradient: LinearGradient(
          colors: [
            Color(0xFFE13662),
            Color(0xFFEB4954),
            Color(0xFFD346F0),
          ],
        ),
        borderRadius: BorderRadius.all(Radius.circular(25)),
      ),
      child: SliderButton(
        backgroundColor: Colors.transparent,
        height: 45,
        width: size.width,
        buttonColor: ConstColor.whiteColor,
        action: swipeAction,
        label: Text(
          buttonName,
          style: TextStyle(
            color: const Color(0xffFFFFFF).withOpacity(0.75),
            fontWeight: FontWeight.w500,
            fontSize: size.height * 0.018,
          ),
        ),
        buttonSize: size.height * 0.05,
        shimmer: false,
        child: Container(
          decoration: const BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.all(
              Radius.circular(30),
            ),
          ),
          padding: const EdgeInsets.symmetric(vertical: 5, horizontal: 20),
          margin: const EdgeInsets.symmetric(vertical: 0, horizontal: 5),
          child: const Icon(
            Icons.chevron_right_rounded,
            color: Color(0xFFE94657),
          ),
        ),
      ),
    );
  }
}
