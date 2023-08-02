import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_mobile_bx/const/color.dart';
import 'package:flutter_mobile_bx/const/styles.dart';
import 'package:flutter_mobile_bx/helpers/sizes.dart';
import 'package:flutter_mobile_bx/view/basket/controller/basket_controller.dart';
import 'package:flutter_mobile_bx/view/basket/pages/basket_dashboard.dart';
import 'package:flutter_mobile_bx/view/basket/pages/basket_info_screen.dart';
import 'package:provider/provider.dart';

class BasketStatusDummy extends StatefulWidget {
  const BasketStatusDummy({
    super.key,
    required this.orderID,
    required this.eleverTxnID,
  });
  final String orderID;
  final String eleverTxnID;

  @override
  State<BasketStatusDummy> createState() => _BasketStatusDummyState();
}

class _BasketStatusDummyState extends State<BasketStatusDummy> {
  BasketController basketController = BasketController();

  @override
  void initState() {
    basketController = Provider.of<BasketController>(context, listen: false);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Scaffold(
      backgroundColor: Colors.transparent,
      body: Container(
        decoration: BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.bottomCenter,
            end: Alignment.topCenter,
            colors: [
              const Color(0xff542961),
              const Color(0xff542961).withOpacity(0.9),
              const Color.fromARGB(255, 76, 19, 88),
              const Color.fromARGB(255, 122, 15, 144).withOpacity(0.7),
            ],
          ),
        ),
        padding: const EdgeInsets.symmetric(
          horizontal: 20,
          vertical: 20,
        ),
        height: hh(),
        width: ww(),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            GestureDetector(
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => const BasketInfoScreen(),
                  ),
                );
              },
              child: Container(
                padding: const EdgeInsets.only(top: 20),
                child: Icon(
                  Icons.arrow_back,
                  size: size.height * 0.038,
                  color: ConstColor.whiteColor,
                ),
              ),
            ),
            sh(height: 35),
            Text(
              "Post Trade Dummy",
              style: sTitleMedium.copyWith(
                fontSize: 22,
              ),
            ),
            sh(height: 35),
            _buildPlaceOrderView(
              context,
              size,
              "Active",
              Colors.blue,
              () {},
            ),
            _buildPlaceOrderView(
              context,
              size,
              "Approved",
              Colors.green,
              () {},
            ),
            _buildPlaceOrderView(
              context,
              size,
              "Last Order failed",
              Colors.red,
              () {},
            ),
            _buildPlaceOrderView(
              context,
              size,
              "Pending Broken Order",
              Colors.orange,
              () {},
            ),
            _buildPlaceOrderView(
              context,
              size,
              "Order Placed",
              Colors.green.shade300,
              () {},
            ),
            _buildPlaceOrderView(
              context,
              size,
              "Due - Rebalance",
              Colors.blueGrey,
              () {},
            ),
            _buildPlaceOrderView(
              context,
              size,
              "Due - SIP & Rebalance",
              Colors.lightBlue,
              () {},
            ),
            _buildPlaceOrderView(
              context,
              size,
              "Due - SIP",
              Colors.red,
              () {},
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildPlaceOrderView(
    BuildContext context,
    Size size,
    String title,
    Color color,
    void Function()? onTap,
  ) {
    return Container(
      margin: const EdgeInsets.only(bottom: 10),
      width: ww(),
      child: GestureDetector(
        onTap: () {
          basketController.eleverPostTradeBasket(object: {
            "eleverTxnID": widget.eleverTxnID,
            "orderID": widget.orderID,
            "requiredProcessingStatus": title,
          }).then((value) {
            // debugPrint(value);
            Navigator.push(
              context,
              MaterialPageRoute(
                builder: (context) => BasketDashboardScreen(status: title),
              ),
            );
          });
        },
        child: Container(
          // width: size.width / 2.7,
          decoration: BoxDecoration(
            color: color,
            borderRadius: BorderRadius.circular(5),
          ),
          padding: EdgeInsets.symmetric(
            horizontal: size.width * 0.09,
            vertical: size.height * 0.015,
          ),
          child: Center(
            child: Text(
              title,
              style: TextStyle(
                color: ConstColor.whiteColor,
                fontSize: size.height * 0.018,
                fontWeight: FontWeight.bold,
              ),
            ),
          ),
        ),
      ),
    );
  }
}
