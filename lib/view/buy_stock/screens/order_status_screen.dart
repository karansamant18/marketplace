import 'package:flutter/material.dart';
import 'package:flutter_mobile_bx/const/color.dart';
import 'package:flutter_mobile_bx/const/image.dart';
import 'package:flutter_mobile_bx/const/styles.dart';
import 'package:flutter_mobile_bx/helpers/sizes.dart';
import 'package:flutter_mobile_bx/view/bottom_bar.dart';
import 'package:flutter_svg/svg.dart';

class OrderStatusScreen extends StatefulWidget {
  const OrderStatusScreen({
    super.key,
    required this.image,
    required this.mainText,
    required this.subText,
    required this.btnText,
    required this.onTap,
  });
  final String? image;
  final String? mainText;
  final String? subText;
  final String? btnText;
  final Function()? onTap;
  @override
  State<OrderStatusScreen> createState() => _OrderStatusScreenState();
}

class _OrderStatusScreenState extends State<OrderStatusScreen> {
  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Scaffold(
      backgroundColor: Colors.transparent,
      body: Container(
        height: hh(),
        width: ww(),
        decoration: const BoxDecoration(
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
              // Spacer(),
              // CommonButton.outlinedButton(context, "Login", () {
              //   _buildPhoneSheet(size);
              // })
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildPage() {
    return Column(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Container(
          height: hh() / 2.5,
          width: ww() / 1.2,
          child: ClipRRect(
            borderRadius: BorderRadius.circular(20),
            child: Image.asset(
              widget.image!,
              fit: BoxFit.fill,
            ),
          ),
        ),
        sh(height: 10),
        Text(
          widget.mainText!,
          textAlign: TextAlign.center,
          style: sTitleLarge.copyWith(fontSize: hh() / 24),
        ),
        Text(
          widget.subText!,
          textAlign: TextAlign.center,
          style: sBodySmall.copyWith(
            color: Colors.white,
          ),
        ),
        GestureDetector(
          onTap: () {
            Navigator.pushReplacement(
              context,
              MaterialPageRoute(
                builder: (context) => BottomBarScreen(),
              ),
            );
          },
          child: Container(
            width: ww(),
            padding: EdgeInsets.symmetric(vertical: 10, horizontal: 10),
            decoration: BoxDecoration(
              color: ConstColor.whiteColor,
              borderRadius: BorderRadius.circular(30),
            ),
            child: Center(
              child: Text(
                "Go to Home",
                style: TextStyle(
                  color: Color(0xFFEB4954),
                ),
              ),
            ),
          ),
        ),
        sh(),
        GestureDetector(
          onTap: widget.onTap!,
          child: Container(
            width: ww(),
            padding: EdgeInsets.symmetric(vertical: 10, horizontal: 10),
            decoration: BoxDecoration(
              color: null,
              borderRadius: BorderRadius.circular(30),
              border: Border.all(color: ConstColor.whiteColor),
            ),
            child: Center(
              child: Text(
                widget.btnText!,
                style: TextStyle(
                  color: Colors.white,
                ),
              ),
            ),
          ),
        ),
      ],
    );
  }
}
