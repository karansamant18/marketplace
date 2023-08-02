import 'dart:ui';
import 'package:flutter/material.dart';
import 'package:flutter_mobile_bx/const/color.dart';
import 'package:flutter_mobile_bx/const/image.dart';
import 'package:flutter_mobile_bx/helpers/info_sliders.dart';
import 'package:flutter_mobile_bx/helpers/sizes.dart';

import 'package:flutter_mobile_bx/view/buy_stock/buy_stock_screen.dart';
import 'package:flutter_mobile_bx/view/buy_stock/controller/order_place_controller.dart';
import 'package:flutter_mobile_bx/view/x_advice/model/get_advisor_call_model.dart';
import 'package:flutter_mobile_bx/view/home/widgtes/header_card/header_card_gridview.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:provider/provider.dart';
import 'package:swipable_stack/swipable_stack.dart';

import '../../../websocket/web_socket.dart';

// import '../../../helpers/info_sliders.dart';

class HeaderCardView extends StatefulWidget {
  final GetAdvisorCallsModel? getAdvisorCallsModel;
  const HeaderCardView({super.key, required this.getAdvisorCallsModel});

  @override
  State<HeaderCardView> createState() => _HeaderCardViewState();
}

class _HeaderCardViewState extends State<HeaderCardView>
    with SingleTickerProviderStateMixin {
  late TabController tabController;
  late final SwipableStackController _controller;
  void _listenController() => setState(() {});
  int selectedIndex = 0;
  bool isNavigator = false;

  late OrderPlaceController orderPlaceController;
  late bool gotoOrderPage;
  @override
  void initState() {
    gotoOrderPage = true;
    orderPlaceController =
        Provider.of<OrderPlaceController>(context, listen: false);
    super.initState();
    subscribeAdvisorySocket(widget.getAdvisorCallsModel!.advisoryResults![0]);
    socketConnectSub.stream.listen((event) {
      if (event == true) {
        subscribeAdvisorySocket(
            widget.getAdvisorCallsModel!.advisoryResults![0]);
      }
    });
    tabController = TabController(length: 3, vsync: this);
    _controller = SwipableStackController()..addListener(_listenController);
  }

  subscribeAdvisorySocket(AdvisoryResults advisoryResult) {
    CommonSocket().subscribeTokens([advisoryResult]);
  }

  unSubscribeAdvisorySocket(AdvisoryResults advisoryResult, int index) {
    if (index > 12) {
      CommonSocket().unsubscribeTokens([advisoryResult]);
    }
  }

  @override
  void dispose() {
    super.dispose();
    CommonSocket().unsubscribeTokens([
      widget.getAdvisorCallsModel!.advisoryResults![_controller.currentIndex]
    ]);
    _controller
      ..removeListener(_listenController)
      ..dispose();
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
    return Container(
      width: size.width,
      decoration: const BoxDecoration(
        gradient: LinearGradient(
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
          colors: [
            Color(0xFFE13662),
            Color(0xffEB4954),
            ConstColor.violetF0Color,
          ],
        ),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          SizedBox(height: size.height * 0.03),
          Padding(
            padding: EdgeInsets.symmetric(horizontal: size.width * 0.07),
            child: Row(
              children: [
                SvgPicture.asset(
                  ConstImage.appLogoSvg,
                  color: ConstColor.whiteColor,
                  width: size.width * 0.2,
                ),
              ],
            ),
          ),
          SizedBox(height: size.height * 0.018),
          SizedBox(
            height: size.height / 1.4,
            // width: size.width / 1.2,
            child: SwipableStack(
              allowVerticalSwipe: false,
              detectableSwipeDirections: const {
                SwipeDirection.right,
                SwipeDirection.left,
              },
              swipeAnchor: SwipeAnchor.bottom,
              itemCount: widget.getAdvisorCallsModel?.advisoryResults?.length,
              controller: _controller,
              stackClipBehaviour: Clip.none,
              horizontalSwipeThreshold: 0.8,
              verticalSwipeThreshold: 0.8,
              onSwipeCompleted: (index, direction) {
                if (direction.name == 'left') {
                  // _controller.next(swipeDirection: SwipeDirection.right);
                  // widget.getAdvisorCallsModel?.advisoryResults?[index + 1]
                  //     .isSelected = true;
                  unSubscribeAdvisorySocket(
                      widget.getAdvisorCallsModel!
                          .advisoryResults![_controller.currentIndex],
                      _controller.currentIndex);
                  subscribeAdvisorySocket(widget.getAdvisorCallsModel!
                      .advisoryResults![_controller.currentIndex + 1]);
                } else {
                  orderPlaceController.advisoryResults =
                      widget.getAdvisorCallsModel?.advisoryResults?[index];
                  if (gotoOrderPage) {
                    Navigator.of(context).push(MaterialPageRoute(
                      builder: (context) => BuyStockScreen(),
                    ));
                  }
                }
                gotoOrderPage = true;
              },
              builder: (context, properties) {
                var advisoryResultData = widget
                    .getAdvisorCallsModel?.advisoryResults?[properties.index];
                return Stack(
                  alignment: Alignment.bottomCenter,
                  children: [
                    _buildHeaderCard(size),
                    Container(
                      height: size.height / 1.6,
                      width: size.width / 1.17,
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(15),
                      ),
                      child: Column(
                        children: [
                          ClipRRect(
                            borderRadius: BorderRadius.all(Radius.circular(15)),
                            child: BackdropFilter(
                              filter: ImageFilter.blur(sigmaX: 10, sigmaY: 10),
                              child: Container(
                                color: Colors.grey.withOpacity(0.1),
                                alignment: Alignment.center,
                                child: Column(
                                  children: [
                                    SizedBox(height: size.height * 0.02),
                                    _buildTabBar(size, advisoryResultData),
                                    SizedBox(height: size.height * 0.02),
                                    SizedBox(
                                      height: size.height / 2.07,
                                      width: size.width / 1.17,
                                      child: Container(
                                        decoration: BoxDecoration(
                                          color: ConstColor.whiteColor,
                                          borderRadius:
                                              BorderRadius.circular(15),
                                        ),
                                        child: _buildCardView(
                                          size,
                                          advisoryResultData,
                                          properties.index,
                                        ),
                                      ),
                                    )
                                  ],
                                ),
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                    Container(
                      height: size.height * 0.1,
                      width: size.width / 1.8,
                      alignment: Alignment.center,
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                        children: [
                          _buildButton(
                            icon: ConstImage.leftArrowIcon,
                            onTap: () {
                              if (_controller.currentIndex != 0) {
                                unSubscribeAdvisorySocket(
                                    widget.getAdvisorCallsModel!
                                            .advisoryResults![
                                        _controller.currentIndex],
                                    _controller.currentIndex);
                                _controller.currentIndex =
                                    _controller.currentIndex - 1;
                                subscribeAdvisorySocket(widget
                                        .getAdvisorCallsModel!.advisoryResults![
                                    _controller.currentIndex]);
                              }
                              // _controller.rewind();
                            },
                            size: size,
                            title: 'Previous',
                          ),
                          _buildButton(
                            icon: ConstImage.rightArrowIcon,
                            onTap: () {
                              setState(() {
                                gotoOrderPage = false;
                              });
                              _controller.next(
                                swipeDirection: SwipeDirection.right,
                              );
                              unSubscribeAdvisorySocket(
                                  widget.getAdvisorCallsModel!.advisoryResults![
                                      _controller.currentIndex],
                                  _controller.currentIndex);
                              subscribeAdvisorySocket(
                                  widget.getAdvisorCallsModel!.advisoryResults![
                                      _controller.currentIndex + 1]);
                            },
                            size: size,
                            title: 'Skip',
                          ),
                        ],
                      ),
                    )
                  ],
                );
              },
            ),
          ),
          SizedBox(height: size.height * 0.05),
        ],
      ),
    );
  }

  Padding _buildTabBar(Size size, AdvisoryResults? advisoryResultData) {
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: size.width * 0.03),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          advisoryResultData?.subsegment == "NSECASH"
              ? _buildContainerView(
                  size: size,
                  backgroundColor: advisoryResultData?.subsegment == "NSECASH"
                      ? ConstColor.whiteColor
                      : Colors.transparent,
                  textColor: advisoryResultData?.subsegment == "NSECASH"
                      ? ConstColor.pink62Color
                      : ConstColor.whiteColor,
                  title: 'Equity',
                )
              : SizedBox.shrink(),
          advisoryResultData?.subsegment == "NSEFUT"
              ? _buildContainerView(
                  size: size,
                  backgroundColor: advisoryResultData?.subsegment == "NSEFUT"
                      ? ConstColor.whiteColor
                      : Colors.transparent,
                  textColor: advisoryResultData?.subsegment == "NSEFUT"
                      ? ConstColor.pink62Color
                      : ConstColor.whiteColor,
                  title: 'Futures',
                )
              : SizedBox.shrink(),
          (advisoryResultData?.subsegment == "NSECALL" ||
                  advisoryResultData?.subsegment == "NSEPUT")
              ? _buildContainerView(
                  size: size,
                  backgroundColor:
                      advisoryResultData?.subsegment == "NSECALL" ||
                              advisoryResultData?.subsegment == "NSEPUT"
                          ? ConstColor.whiteColor
                          : Colors.transparent,
                  textColor: advisoryResultData?.subsegment == "NSECALL" ||
                          advisoryResultData?.subsegment == "NSEPUT"
                      ? ConstColor.pink62Color
                      : ConstColor.whiteColor,
                  title: 'Options',
                )
              : SizedBox.shrink(),
        ],
      ),
    );
  }

  Widget _buildContainerView({
    required Size size,
    required String title,
    required Color textColor,
    required Color backgroundColor,
  }) {
    return Container(
      padding: EdgeInsets.symmetric(
          horizontal: size.width * 0.045, vertical: size.height * 0.015),
      decoration: BoxDecoration(
        color: backgroundColor,
        borderRadius: BorderRadius.circular(50),
        border: Border.all(
          color: ConstColor.whiteColor,
          width: 1,
        ),
      ),
      child: Align(
        alignment: Alignment.center,
        child: Text(
          title,
          style: TextStyle(
            color: textColor,
            fontWeight: FontWeight.w600,
          ),
        ),
      ),
    );
  }

  Widget _buildHeaderCard(Size size) {
    return Align(
      alignment: Alignment.topCenter,
      child: Container(
        height: size.height / 1.7,
        width: size.width / 1.17,
        decoration: BoxDecoration(
          color: ConstColor.whiteColor,
          borderRadius: BorderRadius.circular(15),
        ),
        child: Container(
          decoration: BoxDecoration(
            color: ConstColor.black29Color,
            borderRadius: BorderRadius.circular(15),
          ),
          width: size.width,
          child: Stack(
            children: [
              Padding(
                padding: EdgeInsets.only(top: size.height * 0.02),
                child: SvgPicture.asset(ConstImage.cardBackgroundImg),
              ),
              Center(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    SizedBox(height: size.height * 0.02),
                    Text(
                      'Hot',
                      style: TextStyle(
                        color: ConstColor.whiteColor,
                        fontSize: size.height * 0.02,
                        fontWeight: FontWeight.w400,
                      ),
                    ),
                    Text(
                      'Calls',
                      style: TextStyle(
                        color: ConstColor.whiteColor,
                        fontSize: size.height * 0.035,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildCardView(Size size, AdvisoryResults? resultData, int index) {
    var resutlValue = resultData;
    // debugPrint(" ${resultData?.advisor} : ${resultData?.stopLossprice1}");
    return Column(
      children: [
        Column(
          children: [
            SizedBox(height: size.height * 0.02),
            GestureDetector(
              onTap: () {
                orderPlaceController.advisoryResults = resutlValue;
                Navigator.of(context).push(MaterialPageRoute(
                  builder: (context) => BuyStockScreen(),
                ));
              },
              child: Text(
                (resutlValue?.subsegment == 'NSECASH'
                        ? resutlValue?.symbol
                        : resutlValue?.subsegment == 'NSEFUT'
                            ? '${resutlValue?.symbol} Futures'
                            : resutlValue?.subsegment == "NSECALL"
                                ? '${resutlValue?.symbol} ${resutlValue?.strikeprice} CE'
                                : '${resutlValue?.symbol} ${resutlValue?.strikeprice} PE') ??
                    '',
                style: TextStyle(
                  fontSize: size.height * 0.03,
                  fontWeight: FontWeight.bold,
                  color: ConstColor.violet42Color,
                ),
              ),
            ),
            SizedBox(height: size.height * 0.01),
            Text(
              "by ${resultData?.advisor ?? ''}",
              style: TextStyle(
                fontSize: size.height * 0.014,
                fontWeight: FontWeight.w500,
                color: ConstColor.violet42Color,
              ),
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                CircleAvatar(
                  radius: 5,
                  backgroundColor: resultData?.calltype == "buy"
                      ? ConstColor.greenColor37
                      : Colors.red,
                ),
                SizedBox(width: size.width * 0.01),
                Text(
                  resultData?.calltype ?? '',
                  style: TextStyle(
                    fontSize: size.height * 0.021,
                    fontWeight: FontWeight.w600,
                    color: resultData?.calltype == "buy"
                        ? ConstColor.greenColor37
                        : Colors.red,
                  ),
                ),
              ],
            ),
          ],
        ),
        SizedBox(height: size.height * 0.03),
        StreamBuilder(
            stream: socketStream,
            builder: (context, snap) {
              // debugPrint('snapping...');
              if (snap.hasData && snap.data != null) {
                if (snap.data!.exchangeInstrumentID == resultData!.secToken) {
                  resultData.ltp = snap.data!.lastTradedPrice;
                  resultData.potentialData =
                      calculatePotentialData(result: resultData);
                }
              }
              return Column(
                children: [
                  Padding(
                    padding: EdgeInsets.only(
                        left: ww() * 0.05, right: ww() * 0.05, top: 25),
                    child: InfoSliderCopy(
                      width: size.width * 0.7,
                      info: [
                        InfoSliderModel(
                          name: "SL",
                          val: resultData!.callcategory != 'FUNDAMENTAL'
                              ? resultData.stopLossprice1
                              : resultData.entryprice1,
                          status: resultData.callcategory == 'FUNDAMENTAL'
                              ? false
                              : true,
                        ),
                        InfoSliderModel(
                            name: "ENTER", val: resultData.entryprice1),
                        InfoSliderModel(
                          name: "LTP",
                          val: resultData.status == 'closed'
                              ? resultData.targetprice1
                              : resultData.ltp,
                          status: resultData.status == 'closed' ? false : true,
                        ),
                        InfoSliderModel(
                          name: "TGT",
                          val: resultData.targetprice1,
                        ),
                      ],
                    ),
                  ),
                  SizedBox(height: size.height * 0.015),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text(
                        'Potential Left ',
                        style: TextStyle(
                          fontSize: size.height * 0.02,
                          fontWeight: FontWeight.bold,
                          color: ConstColor.greenColor75,
                        ),
                      ),
                      Text(
                        '(${resultData.potentialData?.toStringAsFixed(2)}%)',
                        style: TextStyle(
                          fontSize: size.height * 0.02,
                          fontWeight: FontWeight.bold,
                          color: ((resultData.potentialData ?? 0.0) > 0.0)
                              ? ConstColor.greenColor75
                              : ConstColor.pink7AColor,
                        ),
                      )
                    ],
                  ),
                ],
              );
            }),
        SizedBox(height: size.height * 0.025),
        HeaderCardGridView(
          advisoryResults: resultData,
        ),
      ],
    );
  }

  Widget _buildSlider(Size size, AdvisoryResults? advisoryResults) {
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
                    "\u{20B9} ${advisoryResults?.stopLossprice1}",
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
                    "\u{20B9} ${advisoryResults?.entryprice1}",
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
                    "\u{20B9} ${advisoryResults?.strikeprice}",
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
                    "\u{20B9} ${advisoryResults?.stopLossprice1}",
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

  Widget _buildButton(
      {required Size size,
      required String icon,
      required void Function() onTap,
      required String title}) {
    return Column(
      children: [
        GestureDetector(
          onTap: onTap,
          child: Card(
            elevation: 6,
            color: ConstColor.whiteColor,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(50),
            ),
            child: Padding(
              padding: EdgeInsets.all(size.height * 0.023),
              child: SvgPicture.asset(
                icon,
                height: size.height * 0.02,
                color: ConstColor.violet61Color,
              ),
            ),
          ),
        ),
        SizedBox(height: 1.5),
        Text(
          title,
          style: TextStyle(
            fontSize: size.height * 0.009,
            fontWeight: FontWeight.w600,
            color: ConstColor.whiteColor.withOpacity(0.7),
          ),
        )
      ],
    );
  }
}
