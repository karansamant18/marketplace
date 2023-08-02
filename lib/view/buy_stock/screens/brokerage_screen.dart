import 'package:flutter/material.dart';
import 'package:flutter_mobile_bx/const/styles.dart';
import 'package:flutter_svg/svg.dart';

import '../../../helpers/sizes.dart';

class BrokerageTaxesScreen extends StatelessWidget {
  BrokerageTaxesScreen({super.key});
  String orderValue = "100.00";
  String brokerage = "100.00";
  String gst = "100.00";
  String sttCtt = "100.00";
  String transactionCharge = "100.00";
  String sebiFees = "100.00";
  String stampDuty = "100.00";

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        _buildOrderValue(),
        sh(),
        const Divider(thickness: 1.5),
        sh(),
        _buildTaxes(),
      ],
    );
  }

  _buildOrderValue() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Text(
          "Order Value:",
          style: sTitleLarge.copyWith(
            color: Colors.black,
            fontSize: hh() * 0.025,
          ),
        ),
        Text(
          orderValue,
          style: sTitleLarge.copyWith(
            color: Colors.black,
            fontSize: hh() * 0.025,
          ),
        )
      ],
    );
  }

  _buildTaxes() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Text(
          "Brokerage & Taxes",
          style: sTitleLarge.copyWith(
            color: Colors.black,
          ),
        ),
        sh(height: 35),
        _buildPrice(title: "Brokerage", amount: brokerage),
        sh(height: 35),
        _buildPrice(title: "Gst", amount: gst),
        sh(height: 35),
        _buildPrice(title: "STT CTT", amount: sttCtt),
        sh(height: 35),
        _buildPrice(title: "Transcation Charge", amount: transactionCharge),
        sh(height: 35),
        _buildPrice(title: "SEBI Fees", amount: sebiFees),
        sh(height: 35),
        _buildPrice(title: "Stamp Duty", amount: stampDuty),
        sh(height: 35),
      ],
    );
  }

  _buildPrice({
    required String amount,
    required String title,
  }) {
    return Row(
      children: [
        SvgPicture.asset(
          "assets/image/svg/right_tick.svg",
          height: hh() * 0.023,
        ),
        sw(width: 30),
        Text(
          title,
          style: sBodySmall.copyWith(
            color: Colors.black,
            fontSize: hh() * 0.022,
          ),
        ),
        Spacer(),
        Text(
          amount,
          style: sTitleLarge.copyWith(
            color: Colors.black,
            fontSize: hh() * 0.022,
          ),
        )
      ],
    );
  }
}
