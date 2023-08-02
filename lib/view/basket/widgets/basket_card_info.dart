import 'package:flutter/material.dart';
import 'package:flutter_mobile_bx/const/color.dart';
import 'package:flutter_mobile_bx/const/image.dart';
import 'package:flutter_mobile_bx/helpers/common_functions.dart';
import 'package:flutter_svg/flutter_svg.dart';

// ignore: must_be_immutable
class BasketCardInfo extends StatefulWidget {
  String cagr;
  double minAmount;
  String volatility;
  String intrestedCount;
  BasketCardInfo({
    super.key,
    required this.cagr,
    required this.minAmount,
    required this.volatility,
    required this.intrestedCount,
  });

  @override
  State<BasketCardInfo> createState() => _BasketCardInfoState();
}

class _BasketCardInfoState extends State<BasketCardInfo> {
  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Padding(
      padding: EdgeInsets.symmetric(
          horizontal: size.width * 0.02, vertical: size.height * 0.01),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.end,
        children: [
          _buildValueView(size),
        ],
      ),
    );
  }

  Widget _buildValueView(Size size) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      crossAxisAlignment: CrossAxisAlignment.end,
      children: [
        Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              '2Y CAGR',
              style: TextStyle(
                fontSize: size.height * 0.014,
                fontWeight: FontWeight.w500,
              ),
            ),
            SizedBox(height: size.height * 0.008),
            Text(
              widget.cagr.split('-')[1].toString().replaceAll(' ', ''),
              style: TextStyle(
                fontSize: size.height * 0.018,
                fontWeight: FontWeight.bold,
                color: ConstColor.litePinkECColor,
              ),
            ),
          ],
        ),
        Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'Min Amount',
              style: TextStyle(
                fontSize: size.height * 0.014,
                fontWeight: FontWeight.w500,
              ),
            ),
            SizedBox(height: size.height * 0.008),
            Text(
              CommonFunctions.formatAmount(widget.minAmount),
              style: TextStyle(
                fontSize: size.height * 0.018,
                fontWeight: FontWeight.bold,
                color: ConstColor.black42Color,
              ),
            ),
          ],
        ),
        Row(
          crossAxisAlignment: CrossAxisAlignment.end,
          children: [
            SvgPicture.asset(
              ConstImage.volatilityIcon,
              height: size.height * 0.017,
              color: ConstColor.orange7AColor,
            ),
            SizedBox(width: size.width * 0.01),
            Text(
              widget.volatility,
              style: TextStyle(
                fontSize: size.height * 0.013,
                fontWeight: FontWeight.w500,
                color: ConstColor.orange7AColor,
              ),
            ),
          ],
        ),
        Row(
          crossAxisAlignment: CrossAxisAlignment.end,
          children: [
            Icon(
              Icons.person,
              color: ConstColor.blueFEColor,
              size: size.height * 0.018,
            ),
            SizedBox(width: size.width * 0.01),
            Text(
              widget.intrestedCount,
              style: TextStyle(
                fontSize: size.height * 0.014,
                fontWeight: FontWeight.w500,
                color: ConstColor.blueFEColor,
              ),
            ),
          ],
        ),
      ],
    );
  }
}
