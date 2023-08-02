import 'package:flutter/material.dart';
import 'package:flutter_mobile_bx/const/color.dart';
import 'package:flutter_mobile_bx/helpers/info_sliders.dart';
import 'package:flutter_mobile_bx/helpers/sizes.dart';
import 'package:flutter_mobile_bx/view/buy_stock/buy_stock_screen.dart';
import 'package:flutter_mobile_bx/view/buy_stock/controller/order_place_controller.dart';
import 'package:flutter_mobile_bx/view/home/widgtes/header_card/header_card_gridview.dart';
import 'package:flutter_mobile_bx/view/x_advice/model/get_advisor_call_model.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:provider/provider.dart';

import '../../websocket/web_socket.dart';

// import '../../helpers/info_sliders.dart';

class StockCardView extends StatefulWidget {
  final AdvisoryResults? advisoryResults;
  const StockCardView({super.key, required this.advisoryResults});

  @override
  State<StockCardView> createState() => _StockCardViewState();
}

class _StockCardViewState extends State<StockCardView> {
  late OrderPlaceController orderPlaceController;
  @override
  void initState() {
    orderPlaceController =
        Provider.of<OrderPlaceController>(context, listen: false);
    super.initState();
  }

  calculatePotentialData({required AdvisoryResults result}) {
    return double.parse((result.calltype == 'buy'
            ? (result.ltp! < result.targetprice1!)
                ? (100 * (result.targetprice1! - result.ltp!) / result.ltp!)
                : 0.00
            : (result.ltp! > result.targetprice1!)
                ? 100 * (result.ltp! - result.targetprice1!) / result.ltp!
                : 0.00)
        .toStringAsFixed(2));
  }

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Padding(
      padding:
          EdgeInsets.only(left: size.width * 0.02, top: size.height * 0.02),
      child: Card(
        elevation: 4,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(15)),
        child: Padding(
          padding: EdgeInsets.symmetric(horizontal: size.width * 0.04),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              SizedBox(height: size.height * 0.02),
              Row(
                children: [
                  Expanded(
                    child: Text(
                      (widget.advisoryResults?.symbolFormatted) ?? '',
                      style: TextStyle(
                        color: ConstColor.violet42Color,
                        fontSize: size.height * 0.018,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                  ),
                  SizedBox(width: size.width * 0.02),
                  Text(
                    widget.advisoryResults!.calltype.toString().toUpperCase(),
                    style: TextStyle(
                      color: widget.advisoryResults!.calltype
                                  .toString()
                                  .toLowerCase() ==
                              'buy'
                          ? Colors.green
                          : Colors.red,
                      fontSize: 13,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                  // widget.advisoryResults?.status == 'open'
                  //     ? Row(
                  //         children: [
                  //           Icon(
                  //             ((widget.advisoryResults?.potentialData ?? 0.0) >
                  //                     0.0)
                  //                 ? Icons.keyboard_arrow_up_rounded
                  //                 : Icons.keyboard_arrow_down_rounded,
                  //             color: ((widget.advisoryResults?.potentialData ??
                  //                         0.0) >
                  //                     0.0)
                  //                 ? ConstColor.greenColor75
                  //                 : ConstColor.pink7AColor,
                  //             size: size.height * 0.018,
                  //           ),
                  //           Text(
                  //             '(${widget.advisoryResults?.potentialData?.toStringAsFixed(2)}%)',
                  //             style: TextStyle(
                  //               color:
                  //                   ((widget.advisoryResults?.potentialData ??
                  //                               0.0) >
                  //                           0.0)
                  //                       ? ConstColor.greenColor75
                  //                       : ConstColor.pink7AColor,
                  //               fontSize: size.height * 0.015,
                  //               fontWeight: FontWeight.w500,
                  //             ),
                  //           ),
                  //         ],
                  //       )
                  //     : Container(),
                ],
              ),
              Text(
                "by ${widget.advisoryResults?.advisor ?? ''}",
                style: TextStyle(
                  color: ConstColor.violet42Color,
                  fontSize: size.height * 0.014,
                  fontWeight: FontWeight.w400,
                ),
              ),
              SizedBox(height: size.height * 0.015),
              SizedBox(
                child: HeaderCardGridView(
                  advisoryResults: widget.advisoryResults,
                ),
              ),
              // _buildSlider(size),
              sh(height: 30),
              StreamBuilder(
                  stream: socketStream,
                  builder: (context, snap) {
                    // debugPrint('snapping...');
                    if (snap.hasData && snap.data != null) {
                      if (snap.data!.exchangeInstrumentID ==
                          widget.advisoryResults!.secToken) {
                        debugPrint(
                            "${widget.advisoryResults!.symbolFormatted} - ${snap.data!.lastTradedPrice}");
                        widget.advisoryResults!.ltp =
                            snap.data!.lastTradedPrice;
                        widget.advisoryResults?.potentialData =
                            calculatePotentialData(
                                result: widget.advisoryResults!);
                        debugPrint("${widget.advisoryResults!.ltp}");
                      }
                    }
                    return Column(
                      children: [
                        Padding(
                          padding: const EdgeInsets.symmetric(
                              horizontal: 0 * 0.05, vertical: 20),
                          child: InfoSliderCopy(
                            width: size.width * 0.68,
                            info: [
                              InfoSliderModel(
                                name: "SL",
                                val: widget.advisoryResults!.callcategory !=
                                        'FUNDAMENTAL'
                                    ? widget.advisoryResults?.stopLossprice1
                                    : widget.advisoryResults?.entryprice1,
                                status: widget.advisoryResults!.callcategory ==
                                        'FUNDAMENTAL'
                                    ? false
                                    : true,
                              ),
                              InfoSliderModel(
                                name: "ENTER",
                                val: widget.advisoryResults?.entryprice1,
                              ),
                              InfoSliderModel(
                                name: "LTP",
                                val: widget.advisoryResults?.status == 'closed'
                                    ? widget.advisoryResults?.targetprice1
                                    : widget.advisoryResults?.ltp,
                                status:
                                    widget.advisoryResults?.status == 'closed'
                                        ? false
                                        : true,
                              ),
                              InfoSliderModel(
                                name: "TGT",
                                val: widget.advisoryResults?.targetprice1,
                                status: true,
                              ),
                            ],
                          ),
                        ),
                        widget.advisoryResults?.status == 'open'
                            ? Row(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  const Text(
                                    "Potential Left:",
                                    style: TextStyle(
                                      fontSize: 13,
                                      color: Color.fromARGB(255, 150, 149, 149),
                                    ),
                                  ),
                                  sw(),
                                  Text(
                                    '(${widget.advisoryResults?.potentialData?.toStringAsFixed(2)}%)',
                                    style: TextStyle(
                                      color: ((widget.advisoryResults
                                                      ?.potentialData ??
                                                  0.0) >
                                              0.0)
                                          ? ConstColor.greenColor75
                                          : ConstColor.pink7AColor,
                                      fontSize: 14,
                                      fontWeight: FontWeight.w500,
                                    ),
                                  ),
                                ],
                              )
                            : Container(),
                      ],
                    );
                  }),

              SizedBox(height: size.height * 0.02),
              widget.advisoryResults!.status == 'closed'
                  ? SizedBox(
                      height: size.height * 0.05,
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          const Text(
                            "Returns: ",
                            style: TextStyle(
                              // color: widget.advisoryResults!.callpl! >= 0
                              //     ? ConstColor.greenColor37
                              //     : Colors.red,
                              fontSize: 14,
                            ),
                          ),
                          // Text(
                          //   "Target ${widget.advisoryResults!.callpl! >= 0 ? "Hit" : "Miss"}",
                          //   style: TextStyle(
                          //     color: widget.advisoryResults!.callpl! >= 0
                          //         ? ConstColor.greenColor37
                          //         : Colors.red,
                          //     fontSize: 14,
                          //   ),
                          // ),
                          sw(),
                          Text(
                            "${widget.advisoryResults!.callpl.toString()}%",
                            style: TextStyle(
                              color: widget.advisoryResults!.callpl! >= 0
                                  ? ConstColor.greenColor37
                                  : Colors.red,
                              fontSize: 14,
                            ),
                          ),
                          // sw(width: 60),
                          // widget.advisoryResults!.callpl! >= 0
                          //     ? const Icon(
                          //         Icons.check_circle,
                          //         color: ConstColor.greenColor37,
                          //         size: 20,
                          //       )
                          //     : Container(),
                        ],
                      ),
                    )
                  : MaterialButton(
                      onPressed: () {
                        if (widget.advisoryResults!.status == 'closed') {
                          Fluttertoast.showToast(
                            msg: 'Oops , This call is already closed',
                            toastLength: Toast.LENGTH_SHORT,
                            gravity: ToastGravity.BOTTOM,
                            timeInSecForIosWeb: 1,
                            backgroundColor: Colors.red,
                            textColor: Colors.white,
                            fontSize: 16.0,
                          );
                        } else {
                          orderPlaceController.advisoryResults =
                              widget.advisoryResults;
                          Navigator.of(context).push(MaterialPageRoute(
                            builder: (context) => BuyStockScreen(),
                          ));
                        }
                      },
                      color: ConstColor.pink7AColor,
                      elevation: 0,
                      height: size.height * 0.05,
                      shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(10)),
                      minWidth: size.width / 1.8,
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text(
                            'Buy Now',
                            style: TextStyle(
                              color: ConstColor.whiteColor,
                              fontSize: size.height * 0.02,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                          Icon(
                            Icons.arrow_forward_ios_rounded,
                            color: ConstColor.whiteColor,
                            size: size.height * 0.025,
                          )
                        ],
                      ),
                    ),
              SizedBox(height: size.height * 0.015),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildSlider(Size size) {
    return SizedBox(
      height: size.height / 7.5,
      width: size.width,
      child: Stack(
        children: [
          Align(
            alignment: Alignment.center,
            child: Container(
              height: 10,
              width: size.width,
              decoration: BoxDecoration(
                  gradient: const LinearGradient(
                    begin: Alignment.topLeft,
                    end: Alignment.bottomRight,
                    colors: [
                      Color(0xFFE13662),
                      Color(0xffFBEB7C),
                      Color(0xff64DAC2),
                      Color(0xff92C255),
                    ],
                  ),
                  borderRadius: BorderRadius.circular(10)),
            ),
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Column(
                mainAxisAlignment: MainAxisAlignment.end,
                children: [
                  Text(
                    '|',
                    style: TextStyle(
                      color: ConstColor.blackColor,
                      fontSize: size.height * 0.02,
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                  SizedBox(height: size.height * 0.02),
                  Text(
                    'SL',
                    style: TextStyle(
                      color: ConstColor.greyColor,
                      fontSize: size.height * 0.014,
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                  const SizedBox(height: 1),
                  Text(
                    "\u{20B9} ${widget.advisoryResults?.stopLossprice1}",
                    style: TextStyle(
                      color: ConstColor.blackColor,
                      fontSize: size.height * 0.015,
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                ],
              ),
              Column(
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  Row(
                    children: [
                      const CircleAvatar(
                        radius: 3,
                        backgroundColor: ConstColor.yellowColor6E,
                      ),
                      const SizedBox(width: 5),
                      Text(
                        'Enter',
                        style: TextStyle(
                          color: ConstColor.greyColor,
                          fontSize: size.height * 0.013,
                          fontWeight: FontWeight.w500,
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 1),
                  Text(
                    "\u{20B9} ${widget.advisoryResults?.entryprice1}",
                    style: TextStyle(
                      color: ConstColor.yellowColor6E,
                      fontSize: size.height * 0.018,
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                  SizedBox(height: size.height * 0.01),
                  Text(
                    '|',
                    style: TextStyle(
                      color: ConstColor.blackColor,
                      fontSize: size.height * 0.02,
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                ],
              ),
              Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  SizedBox(height: size.height * 0.05),
                  Icon(
                    Icons.arrow_outward_rounded,
                    color: ConstColor.greenColor37,
                  ),
                  SizedBox(height: size.height * 0.01),
                  Text(
                    'LTP',
                    style: TextStyle(
                      color: ConstColor.greyColor,
                      fontSize: size.height * 0.014,
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                  SizedBox(height: 1),
                  Text(
                    "\u{20B9} ${widget.advisoryResults?.tokenData!.ltpCmots ?? ((widget.advisoryResults!.entryprice1! + widget.advisoryResults!.targetprice1!) / 2)}",
                    // resultData?.tokenData!.ltpCmots ??
                    //   ((resultData!.entryprice1! + resultData.targetprice1!) /
                    //       2)),
                    style: TextStyle(
                      color: ConstColor.greenColor37,
                      fontSize: size.height * 0.017,
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                ],
              ),
              SizedBox(),
              Column(
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  Text(
                    'TGT',
                    style: TextStyle(
                      color: ConstColor.violetF0Color,
                      fontSize: size.height * 0.014,
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                  const SizedBox(height: 1),
                  Text(
                    "\u{20B9} ${widget.advisoryResults?.targetprice1}",
                    style: TextStyle(
                      color: ConstColor.violetF0Color,
                      fontSize: size.height * 0.018,
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                  SizedBox(height: size.height * 0.01),
                  Text(
                    '|',
                    style: TextStyle(
                      color: ConstColor.blackColor,
                      fontSize: size.height * 0.02,
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                ],
              )
            ],
          )
        ],
      ),
    );
  }
}
