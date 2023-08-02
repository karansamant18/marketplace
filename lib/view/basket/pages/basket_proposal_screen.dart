import 'package:flutter/material.dart';
import 'package:flutter_mobile_bx/const/color.dart';
import 'package:flutter_mobile_bx/const/styles.dart';
import 'package:flutter_mobile_bx/helpers/sizes.dart';
import 'package:flutter_mobile_bx/view/basket/controller/basket_controller.dart';
import 'package:flutter_mobile_bx/view/basket/model/basket_proposal.dart';
import 'package:flutter_mobile_bx/view/basket/pages/basket_info_screen.dart';
import 'package:flutter_mobile_bx/view/basket/pages/basket_status_dummy.dart';
import 'package:flutter_mobile_bx/widgets/pill.dart';
import 'package:provider/provider.dart';

class BasketProposalScreen extends StatefulWidget {
  const BasketProposalScreen({
    super.key,
    required this.productID,
    required this.investAmt,
  });
  final String productID;
  final double investAmt;
  @override
  State<BasketProposalScreen> createState() => _BasketProposalScreenState();
}

class _BasketProposalScreenState extends State<BasketProposalScreen> {
  BasketController basketController = BasketController();

  BasketProposalModel? basketProposalData;

  @override
  void initState() {
    basketController = Provider.of<BasketController>(context, listen: false);
    basketController.basketProposalController(
      productID: widget.productID,
      investAmt: widget.investAmt,
    );
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
        height: hh(),
        width: ww(),
        child: Stack(
          children: [
            Container(
              padding: const EdgeInsets.fromLTRB(30, 30, 30, 0),
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
                    "Proposal",
                    style: sTitleMedium.copyWith(
                      fontSize: 22,
                    ),
                  ),
                  sh(height: 35),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        widget.productID,
                        style: TextStyle(color: ConstColor.whiteColor),
                      ),
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          Text(
                            widget.investAmt.toString(),
                            style: TextStyle(color: ConstColor.whiteColor),
                          ),
                          sh(),
                          const Text(
                            "Invested Amount",
                            style: TextStyle(color: ConstColor.whiteColor),
                          ),
                        ],
                      ),
                    ],
                  ),
                  sh(),
                  buildProposalView(size),
                  // buildProposalView(size),
                ],
              ),
            ),
            Positioned(
              bottom: 20,
              right: 20,
              left: 20,
              child: _buildPlaceOrderView(context, size, "Place Order", () {
                basketController.investBasketController(object: {
                  "productID": widget.productID,
                  "investAmt": widget.investAmt,
                  "investFreq": "Monthly",
                }).then((value) {
                  basketController
                      .placeTradeController(orderID: value.data!.data!.orderId!)
                      .then((val) {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => BasketStatusDummy(
                          orderID: val.data!.data!.orderId!,
                          eleverTxnID: val.data!.data!.transactionId!,
                        ),
                      ),
                    );
                  });
                });
              }),
            ),
          ],
        ),
      ),
    );
  }

  Widget buildProposalView(Size size) {
    return Consumer<BasketController>(
      builder: (context, value, child) {
        if (value.basketProposalModel.data == null) {
          return const Expanded(
            child: SizedBox(
              // height: size.height * 0.618,
              child: Center(child: CircularProgressIndicator()),
            ),
          );
        } else {
          basketProposalData = value.basketProposalModel.data;
          return Expanded(
            child: SizedBox(
              // height: size.height * 0.618,
              child: SingleChildScrollView(
                child: ListView.builder(
                  padding: const EdgeInsets.all(0),
                  shrinkWrap: true,
                  itemCount: basketProposalData!.data!.portfolioUnits!.length,
                  physics: const NeverScrollableScrollPhysics(),
                  itemBuilder: (context, index) {
                    return unitView(
                        size, basketProposalData!.data!.portfolioUnits!, index);
                  },
                ),
              ),
            ),
          );
        }
      },
    );
  }

  Widget unitView(Size size, List<PortfolioUnit> orders, int index) {
    return Container(
      decoration: const BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.all(
          Radius.circular(15),
        ),
      ),
      padding: const EdgeInsets.all(20.0),
      margin: const EdgeInsets.only(bottom: 15.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            orders[index].secName.toString(),
            style: sBodySmall.copyWith(
              fontSize: 14,
              color: ConstColor.blackColor,
            ),
          ),
          sh(),
          Text(
            "${orders[index].secSymbol.toString()} | ${orders[index].grpTag}",
            style: sBodySmall.copyWith(
              fontSize: 11,
              color: ConstColor.blackColor,
            ),
          ),
          sh(height: 50),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Pill.textPill(
                head: orders[index].investAvgPrice.toString(),
                value: "investAvgPrice",
                headStyle: sBodySmall.copyWith(
                  color: ConstColor.blackColor,
                ),
                valueStyle: sBodySmall.copyWith(
                  color: ConstColor.blackColor,
                  fontSize: 12,
                ),
              ),
              Pill.textPill(
                head: orders[index].investAmt.toString(),
                value: "investAmt",
                headStyle: sBodySmall.copyWith(
                  color: ConstColor.blackColor,
                ),
                valueStyle: sBodySmall.copyWith(
                  color: ConstColor.blackColor,
                  fontSize: 12,
                ),
              ),
              Pill.textPill(
                head: orders[index].units.toString(),
                value: "Units",
                headStyle: sBodySmall.copyWith(
                  //
                  color: Color(0xFFFF707A),
                ),
                valueStyle: sBodySmall.copyWith(
                  fontSize: 12,
                  color: ConstColor.blackColor,
                ),
              ),
            ],
          ),
          // sh(),
          // Row(
          //   mainAxisAlignment: MainAxisAlignment.spaceBetween,
          //   children: [
          //     Text(orders[index].tradingsymbol.toString()),
          //     Text(
          //         "${orders[index].quantity.toString()}/${orders[index].quantity.toString()} @${orders[index].price.toString()}"),
          //   ],
          // ),
          // sh(),
          // Row(
          //   mainAxisAlignment: MainAxisAlignment.spaceBetween,
          //   children: [
          //     Text("${orders[index].exchange.toString()} | CNC"),
          //     Row(
          //       children: [
          //         Text("LTP ${orders[index].averageprice.toString()}"),
          //         sw(),
          //         const RotatedBox(
          //           quarterTurns: 2 <= 5 ? 3 : 1,
          //           child: Icon(
          //             2 <= 5 ? Icons.arrow_forward_ios : Icons.arrow_back_ios,
          //             size: 14,
          //             color: 2 <= 5 ? Colors.green : Colors.red,
          //           ),
          //         ),
          //       ],
          //     ),
          //   ],
          // )
        ],
      ),
    );
  }

  Widget _buildPlaceOrderView(
    BuildContext context,
    Size size,
    String title,
    void Function()? onTap,
  ) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        // width: size.width / 2.7,
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
          horizontal: size.width * 0.05,
          vertical: size.height * 0.012,
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(
              title,
              style: TextStyle(
                color: ConstColor.whiteColor,
                fontSize: size.height * 0.018,
                fontWeight: FontWeight.bold,
              ),
            ),
            const Icon(
              Icons.chevron_right,
              color: ConstColor.whiteColor,
              size: 16,
            )
          ],
        ),
      ),
    );
  }
}
