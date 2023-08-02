import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_mobile_bx/const/color.dart';
import 'package:flutter_mobile_bx/const/const_list.dart';
import 'package:flutter_mobile_bx/const/image.dart';
import 'package:flutter_mobile_bx/helpers/common_functions.dart';
import 'package:flutter_mobile_bx/helpers/sizes.dart';
import 'package:flutter_mobile_bx/helpers/user_auth.dart';
import 'package:flutter_mobile_bx/view/buy_stock/controller/order_place_controller.dart';
import 'package:flutter_mobile_bx/view/buy_stock/model/order_limit_model.dart';
import 'package:flutter_mobile_bx/view/buy_stock/model/req_margin_model.dart';
import 'package:flutter_mobile_bx/view/buy_stock/screens/order_status_screen.dart';
import 'package:flutter_mobile_bx/view/buy_stock/screens/brokerage_screen.dart';
import 'package:flutter_mobile_bx/view/helper/controller/helper_controller.dart';
import 'package:flutter_mobile_bx/view/helper/model/instrument_quote_model.dart';
import 'package:flutter_mobile_bx/view/x_advice/model/get_advisor_call_model.dart';
import 'package:flutter_mobile_bx/view/orders/orders_screen.dart';
import 'package:flutter_mobile_bx/websocket/web_socket.dart';
import 'package:flutter_mobile_bx/widgets/bottom_modal.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';
import 'package:url_launcher/url_launcher.dart';

class BuyStockScreen extends StatefulWidget {
  const BuyStockScreen({super.key});

  @override
  State<BuyStockScreen> createState() => _BuyStockScreenState();
}

class _BuyStockScreenState extends State<BuyStockScreen> {
  OrderPlaceController orderPlaceController = OrderPlaceController();
  HelperController helperController = HelperController();
  TextEditingController quantityController = TextEditingController();
  TextEditingController priceController = TextEditingController();
  TextEditingController slPriceController = TextEditingController();
  String selectedExchange = "NSE";
  String transactionType = "BUY";
  // String productType = "NRML";
  int selectedProduct = 0;
  int selectedOrderType = 0;
  OrderLimitsModel? limitsData;
  ReqMarginModel? reqMarginData;
  double? marginPercent;
  double? reqMargin = 0.0;
  AdvisoryResults? advisoryResult;
  List<Map<String, dynamic>> transactionTypeList = [
    {
      "type": "BUY",
      "name": "Buy Now",
      "color": Colors.green,
    },
    {
      "type": "SELL",
      "name": "Sell Now",
      "color": Colors.red,
    },
  ];
  List<Map<String, dynamic>> productList = [
    {
      'name': 'NRML',
      'full_name': 'Normal Delivery Order',
    },
    {
      'name': 'MIS',
      'full_name': 'Margin Intraday Squareoff Order',
    },
    {
      'name': 'CNC',
      'full_name': 'Cash and Carry order',
    },
    {
      'name': 'MTF',
      'full_name': 'Margin Trade Funding',
    },
  ];

  List<InstrumentQuote> instQuote = [];

  @override
  void initState() {
    orderPlaceController =
        Provider.of<OrderPlaceController>(context, listen: false);
    helperController = Provider.of<HelperController>(context, listen: false);
    advisoryResult = orderPlaceController.advisoryResults ??
        AdvisoryResults(
          symbol: "TATASTEEL",
          symbolFormatted: "TATASTEEL-EQ",
          secToken: 3499,
          advisor: "",
          isCash: false,
          isOpt: true,
          lotsize: 50,
        );
    CommonSocket().subscribeTokens([advisoryResult!]);
    setProductList();
    selectedProduct = (advisoryResult!.isCash == true) ? 2 : 0;
    priceController.text = '0.00';
    quantityController.text = '1';
    WidgetsBinding.instance.addPostFrameCallback((_) {
      UserAuth().showLoginBlinkX(gaurd: true); // executes after build
    });
    // List inst = [
    //   {
    //     "exchangeSegment": (advisoryResult!.isCash == true) ? 1 : 2,
    //     "exchangeInstrumentID": int.parse(advisoryResult!.secToken.toString()),
    //   },
    //   {
    //     "exchangeSegment": 11,
    //     "exchangeInstrumentID": int.parse(advisoryResult!.secToken.toString()),
    //   },
    // ];
    transactionType =
        advisoryResult!.calltype.toString() == 'buy' ? 'BUY' : 'SELL';
    // helperController.instrumentQuotesApi(quotes: {
    //   "instruments": inst,
    //   "xtsMessageCode": 1502,
    //   "publishFormat": "JSON"
    // }).then((value) {
    //   if (value.data != null) {
    //     instQuote = value.data!.result!.listQuotes ?? [];
    //     if (instQuote[0].touchline!.lastTradedPrice! == 0 &&
    //         instQuote[1].touchline!.lastTradedPrice! > 0 &&
    //         advisoryResult!.isCash == true) {
    //       selectedExchange = 'BSE';
    //     }
    //     setLtp();
    //     setState(() {});
    //   }
    //   // debugPrint(value);
    // });
    setLtp();
    getOrderLimits();
    getReqMargin();

    super.initState();
  }

  setLtp() {
    // final index = (selectedExchange == 'NSE') ? 0 : 1;
    // priceController.text =
    //     instQuote[index].touchline!.lastTradedPrice.toString();
    priceController.text = advisoryResult!.ltp.toString();
    // setReqMargin();
  }

  getReqMargin() {
    // reqMarginBody["data"]["exchangeToken"] = advisoryResult!.secToken;
    final reqMarginBody = {
      "data": {
        "exchangeToken": advisoryResult!.secToken.toString(),
        "exchange":
            ((advisoryResult!.isCash == true) ? selectedExchange : 'NFO')
      },
      "appID": ""
    };
    orderPlaceController.reqMarginController(reqMarginBody).then((value) {
      if (value.data != null &&
          (!value.data!.data!.requiredMargin!.containsKey("MIS"))) {
        productList.removeWhere((element) => element['name'] == 'MIS');
      }
      setState(() {
        reqMarginData = value.data;
      });
      setMarginPercent();
    });
  }

  setMarginPercent() {
    setState(() {
      marginPercent = ((productList[selectedProduct]['name'] == 'CNC') ||
              (advisoryResult!.isOpt == true &&
                  advisoryResult!.calltype!.toLowerCase() == 'buy'))
          ? 100.0
          : reqMarginData!.data!.requiredMargin![productList[selectedProduct]
              ['name']]!['marginPercent'];
    });
    setReqMargin();
    // marginPercent = reqMarginData.data.requiredMargin[productList[selectedProduct]['name']]
  }

  setReqMargin() {
    // debugPrint(quantityController.text);
    // debugPrint(priceController.text);
    // debugPrint(marginPercent);
    setState(() {
      reqMargin = int.parse(quantityController.text) *
          int.parse(advisoryResult!.lotsize.toString()) *
          double.parse(priceController.text) *
          (marginPercent! / 100);
    });
  }

  changeQuan({required bool isIncr}) {
    if ((int.parse(quantityController.text) >= 1 && isIncr == true) ||
        (isIncr == false && int.parse(quantityController.text) >= 2)) {
      setState(() {
        quantityController.text = ((isIncr == true)
                ? (int.parse(quantityController.text) + 1)
                : (int.parse(quantityController.text) - 1))
            .toString();
      });
      setReqMargin();
    }
  }

  getOrderLimits() {
    Map<String, String> orderLimitsBody = {
      "Segment": "ALL",
      "Exchange": "ALL",
      "ProductType": "ALL"
    };
    orderPlaceController.orderLimitsController(orderLimitsBody).then((value) {
      setState(() {
        limitsData = value.data;
      });
    });
  }

  changeSegment(String exchange) {
    setState(() {
      selectedExchange = exchange;
      // orderLimitsBody["Segment"] = orderLimitsBody["Exchange"] = exchange;
      // orderLimitsBody["ProductType"] = productList[selectedProduct]['name'];
      // reqMarginBody['data']['exchange'] =
      //     advisoryResult!.isCash == true ? "NSE" : "NFO";
    });
    setLtp();
    getOrderLimits();
    getReqMargin();
  }

  setProductList() {
    if (advisoryResult!.isFut == true) {
      productList = productList.sublist(0, 2);
    } else if (advisoryResult!.isOpt == true) {
      productList = productList.sublist(0, 1);
    } else {
      productList = productList;
    }
  }

  @override
  void dispose() {
    // TODO: implement dispose
    super.dispose();
    CommonSocket().unsubscribeTokens([advisoryResult!]);
  }

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Scaffold(
      backgroundColor: ConstColor.black42Color,
      body: SingleChildScrollView(
        child: Column(
          children: [
            _buildHeaderImage(size),
            SizedBox(height: size.height * 0.04),
            Container(
              width: size.width,
              decoration: BoxDecoration(
                color: ConstColor.whiteColor,
                borderRadius: BorderRadius.only(
                  topLeft: Radius.circular(size.height * 0.035),
                  topRight: Radius.circular(size.height * 0.035),
                ),
              ),
              child: Padding(
                padding: EdgeInsets.symmetric(
                    horizontal: size.width * 0.06,
                    vertical: size.height * 0.02),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    SizedBox(height: size.height * 0.02),
                    // advisoryResult!.isCash == true
                    //     ? _buildQuantityFiled(size)
                    //     : _buildLotFiled(size),
                    _buildLotFiled(size),
                    SizedBox(height: size.height * 0.02),
                    _buildPriceFiled(size),
                    SizedBox(height: size.height * 0.02),
                    _buildProductView(size),
                    SizedBox(height: size.height * 0.02),
                    _buildOrderType(size),
                    SizedBox(height: size.height * 0.02),
                    ConstList()
                            .orderTypeList[selectedOrderType]['name']
                            .toString()
                            .toLowerCase()
                            .contains('sl')
                        ? _buildSlPriceFiled(size)
                        : Container(),
                    Divider(
                      color: ConstColor.greyColor.withOpacity(0.8),
                    ),
                    // _buildSwitchView(size),
                    SizedBox(height: size.height * 0.02),
                    _buildAmountView(size),
                    SizedBox(height: size.height * 0.01),
                    GestureDetector(
                      onTap: () {
                        CommonDialogs.bottomDialog(BrokerageTaxesScreen(),
                            height: hh() / 1.77);
                      },
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.end,
                        children: [
                          Text(
                            'Brokerage & Taxes',
                            style: TextStyle(
                              color: ConstColor.blueD9Color,
                              fontSize: size.height * 0.016,
                              fontWeight: FontWeight.w300,
                            ),
                          ),
                        ],
                      ),
                    ),
                    SizedBox(height: size.height * 0.04),
                    limitsData != null
                        ? _buildButtonView()
                        : SizedBox(
                            height: size.height * 0.2,
                          ),
                  ],
                ),
              ),
            )
          ],
        ),
      ),
    );
  }

  Widget _buildButtonView() {
    return (reqMargin ?? 0.0) > (limitsData!.data!.availableMargin ?? 0)
        ? GestureDetector(
            onTap: () {
              Fluttertoast.showToast(
                msg: 'Open BlinkX trading app to add funds',
                toastLength: Toast.LENGTH_SHORT,
                gravity: ToastGravity.TOP,
                timeInSecForIosWeb: 1,
                backgroundColor: Colors.red,
                textColor: Colors.white,
                fontSize: 16.0,
              );
            },
            child: GestureDetector(
              onTap: () async {
                var uri = await Uri.parse(
                    "https://dev-ws.deh.blink.trade/add_money_screen");
                if (await canLaunchUrl(uri)) {
                  await launchUrl(uri, mode: LaunchMode.externalApplication);
                } else {
                  throw 'Could not launch https://dev-ws.deh.blink.trade/add_money_screen';
                }
              },
              child: Container(
                width: ww(),
                padding: EdgeInsets.symmetric(vertical: 10, horizontal: 20),
                decoration: BoxDecoration(
                  gradient:
                      LinearGradient(colors: ConstColor.mainThemeGradient),
                  borderRadius: BorderRadius.circular(30),
                ),
                child: const Center(
                  child: Text(
                    "Add Funds to Wallet",
                    style: TextStyle(
                      color: ConstColor.whiteColor,
                    ),
                  ),
                ),
              ),
            ),
          )
        : GestureDetector(
            onTap: () {
              if (int.parse(quantityController.text) <= 0) {
                Fluttertoast.showToast(
                  msg: 'Add Valid Quantity',
                  toastLength: Toast.LENGTH_SHORT,
                  gravity: ToastGravity.TOP,
                  timeInSecForIosWeb: 1,
                  backgroundColor: Colors.red,
                  textColor: Colors.white,
                  fontSize: 16.0,
                );
                return;
              }
              List arr = [];
              String month = "";
              if (advisoryResult!.isCash == false) {
                arr = advisoryResult!.contractexpiry!.split(" ")[0].split("-");
                month =
                    DateFormat('MMM').format(DateTime(0, int.parse(arr[1])));
              }
              // debugPrint(advisoryResult!.contractexpiry!);
              // debugPrint(DateFormat("yM")
              //     .parse(advisoryResult!.contractexpiry!.split(" ")[0]));
              // debugPrint(arr[0].substring(2, 4));
              // debugPrint(advisoryResult!.strikeprice!);
              // debugPrint(advisoryResult!.optiontype!);
              orderPlaceController.placeOrderController(orderData: {
                "variety": "NORMAL",
                "tradingsymbol": advisoryResult!.isCash!
                    ? "${advisoryResult!.symbol!}-EQ"
                    : (advisoryResult!.symbol! +
                        (arr[0].substring(2, 4) + month.toUpperCase()) +
                        (advisoryResult!.isOpt == true
                            ? (advisoryResult!.strikeprice!
                                    .toString()
                                    .split(".")[0] +
                                advisoryResult!.optiontype!)
                            : "FUT")),
                "symboltoken": advisoryResult!.secToken.toString(),
                "transactiontype": transactionType,
                "exchange":
                    advisoryResult!.isCash == true ? selectedExchange : 'NFO',
                "ordertype": ConstList()
                    .orderTypeList[selectedOrderType]['type']
                    .toString()
                    .toUpperCase(),
                "producttype": productList[selectedProduct]['name'],
                "duration": "DAY",
                "price": ConstList()
                        .orderTypeList[selectedOrderType]['name']
                        .toString()
                        .toLowerCase()
                        .contains("market")
                    ? "0"
                    : double.parse(priceController.text).toStringAsFixed(2),
                "squareoff": "0",
                "stoploss": ConstList()
                        .orderTypeList[selectedOrderType]['name']
                        .toString()
                        .toLowerCase()
                        .contains("sl")
                    ? double.parse(slPriceController.text).toStringAsFixed(2)
                    : "0",
                "quantity": (int.parse(quantityController.text) *
                        int.parse(advisoryResult!.lotsize.toString()))
                    .toString(),
                "disclosedquantity": "0",
                "triggerprice": "0"
              }).then((value) {
                if (value.status == 200) {
                  // Fluttertoast.showToast(
                  //   msg: value.data?.message ?? '',
                  //   toastLength: Toast.LENGTH_SHORT,
                  //   gravity: ToastGravity.BOTTOM,
                  //   timeInSecForIosWeb: 1,
                  //   backgroundColor: ConstColor.greenColor37,
                  //   textColor: Colors.white,
                  //   fontSize: 16.0,
                  // );
                  Navigator.pushReplacement(
                    context,
                    MaterialPageRoute(
                      builder: (context) => OrderStatusScreen(
                        image: ConstImage.orderSuccess,
                        mainText: "Order Has been Placed",
                        subText: "",
                        btnText: "Go to Order",
                        onTap: () {
                          Navigator.pushReplacement(
                            context,
                            MaterialPageRoute(
                              builder: (context) => OrdersScreen(),
                            ),
                          );
                        },
                      ),
                    ),
                  );
                } else {
                  // Fluttertoast.showToast(
                  //   msg: value.data?.message ?? '',
                  //   toastLength: Toast.LENGTH_SHORT,
                  //   gravity: ToastGravity.BOTTOM,
                  //   timeInSecForIosWeb: 1,
                  //   backgroundColor: ConstColor.greenColor37,
                  //   textColor: Colors.white,
                  //   fontSize: 16.0,
                  // );
                  Navigator.pushReplacement(
                    context,
                    MaterialPageRoute(
                      builder: (context) => OrderStatusScreen(
                        image: ConstImage.orderSuccess,
                        mainText: "Your order has failed",
                        subText: "",
                        btnText: "Try again",
                        onTap: () {
                          Navigator.pushReplacement(
                            context,
                            MaterialPageRoute(
                              builder: (context) => BuyStockScreen(),
                            ),
                          );
                        },
                      ),
                    ),
                  );
                }
              });
            },
            child: Container(
              width: ww(),
              padding: EdgeInsets.symmetric(vertical: 10, horizontal: 20),
              decoration: BoxDecoration(
                gradient: LinearGradient(colors: ConstColor.mainThemeGradient),
                borderRadius: BorderRadius.circular(30),
              ),
              child: const Center(
                child: Text(
                  "Place Order",
                  style: TextStyle(
                    color: ConstColor.whiteColor,
                  ),
                ),
              ),
            ),
          );
    // return SwipeButton(
    //   buttonName: 'Swipe to buy now',
    //   swipeAction: () async {

    //   },
    // );
  }

  Widget _buildAmountView(Size size) {
    return limitsData == null
        ? Container()
        : Container(
            width: size.width,
            decoration: BoxDecoration(
                color: ConstColor.violet42Color,
                borderRadius: BorderRadius.circular(12)),
            padding: EdgeInsets.symmetric(
                horizontal: size.width * 0.05, vertical: size.width * 0.05),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
                Column(
                  children: [
                    Text(
                      'Available Margin',
                      style: TextStyle(
                        color: ConstColor.whiteColor.withOpacity(0.6),
                        fontSize: size.height * 0.016,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    SizedBox(height: size.height * 0.005),
                    Text(
                      limitsData!.data!.availableMargin.toString(),
                      style: TextStyle(
                        color: ConstColor.whiteColor,
                        fontSize: size.height * 0.03,
                        fontWeight: FontWeight.bold,
                      ),
                    )
                  ],
                ),
                Column(
                  children: [
                    Text(
                      'Required Margin',
                      style: TextStyle(
                        color: ConstColor.whiteColor.withOpacity(0.6),
                        fontSize: size.height * 0.016,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    SizedBox(height: size.height * 0.005),
                    Text(
                      reqMargin!.toStringAsFixed(2),
                      style: TextStyle(
                        color: ConstColor.whiteColor,
                        fontSize: size.height * 0.03,
                        fontWeight: FontWeight.bold,
                      ),
                    )
                  ],
                ),
              ],
            ),
          );
  }

  Widget _buildSwitchView(Size size) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            Transform.scale(
              scale: 0.8,
              child: CupertinoSwitch(
                value: false,
                onChanged: (v) {},
              ),
            ),
            Text(
              'More Options',
              style: TextStyle(
                color: ConstColor.black29Color.withOpacity(0.8),
                fontSize: size.height * 0.016,
                fontWeight: FontWeight.bold,
              ),
            ),
          ],
        ),
        Row(
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            Transform.scale(
              scale: 0.8,
              child: CupertinoSwitch(
                value: false,
                onChanged: (v) {},
              ),
            ),
            Text(
              'After Market Order',
              style: TextStyle(
                color: ConstColor.black29Color.withOpacity(0.8),
                fontSize: size.height * 0.016,
                fontWeight: FontWeight.bold,
              ),
            ),
          ],
        ),
      ],
    );
  }

  Column _buildOrderType(Size size) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Text('Order Type'),
        SizedBox(height: size.height * 0.015),
        SizedBox(
          height: size.height * 0.04,
          child: ListView.builder(
            itemCount: ConstList().orderTypeList.length,
            shrinkWrap: true,
            scrollDirection: Axis.horizontal,
            padding: EdgeInsets.zero,
            itemBuilder: (context, index) {
              var orderDataList = ConstList().orderTypeList[index];
              return Padding(
                padding: EdgeInsets.only(right: size.width * 0.03),
                child: GestureDetector(
                  onTap: () {
                    setState(() {
                      selectedOrderType = index;
                    });
                    if (ConstList()
                        .orderTypeList[selectedOrderType]['name']
                        .toString()
                        .toLowerCase()
                        .contains('market')) {
                      setLtp();
                    }
                  },
                  child: Container(
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(16),
                      gradient: selectedOrderType == index
                          ? LinearGradient(
                              begin: Alignment.centerLeft,
                              end: Alignment.centerRight,
                              colors: ConstColor.mainThemeGradient,
                            )
                          : null,
                      // color: selectedOrderType == index
                      //     ? ConstColor.violet91Color
                      //     : ConstColor.whiteColor,
                      border: selectedOrderType == index
                          ? null
                          : Border.all(color: ConstColor.blackColor),
                    ),
                    padding:
                        EdgeInsets.symmetric(horizontal: size.width * 0.03),
                    child: Center(
                      child: Text(
                        orderDataList['name'],
                        style: TextStyle(
                          color: selectedOrderType == index
                              ? ConstColor.whiteColor
                              : ConstColor.blackColor,
                          fontSize: size.height * 0.016,
                          // fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                  ),
                ),
              );
            },
          ),
        ),
      ],
    );
  }

  Widget _buildProductView(Size size) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          'Product',
          style: TextStyle(
            color: ConstColor.black29Color,
            fontSize: size.height * 0.015,
            fontWeight: FontWeight.w500,
          ),
        ),
        SizedBox(height: size.height * 0.01),
        GestureDetector(
          onTap: () {
            showModalBottomSheet(
              context: context,
              backgroundColor: ConstColor.whiteColor,
              shape: const RoundedRectangleBorder(
                borderRadius: BorderRadius.only(
                  topLeft: Radius.circular(15),
                  topRight: Radius.circular(15),
                ),
              ),
              builder: (context) {
                return StatefulBuilder(
                    builder: (BuildContext context, StateSetter setStates) {
                  return Padding(
                    padding:
                        EdgeInsets.symmetric(horizontal: size.width * 0.07),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        SizedBox(height: size.height * 0.02),
                        Center(
                          child: Container(
                            width: 30,
                            height: 5,
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(50),
                              color: ConstColor.greyColor,
                            ),
                          ),
                        ),
                        SizedBox(height: size.height * 0.02),
                        Text(
                          'Select Product',
                          style: TextStyle(
                            color: ConstColor.violet61Color,
                            fontSize: size.height * 0.025,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        SizedBox(height: size.height * 0.02),
                        ListView.builder(
                          itemCount: productList.length,
                          shrinkWrap: true,
                          itemBuilder: (context, index) {
                            return GestureDetector(
                              onTap: () {
                                setStates(() {
                                  selectedProduct = index;
                                });
                                setMarginPercent();
                                Navigator.pop(context);
                                // setStates(() {
                                //   productType =
                                //       productList[selectedProduct]['name'];
                                // });
                              },
                              child: Padding(
                                padding: EdgeInsets.symmetric(
                                    vertical: size.height * 0.01),
                                child: Container(
                                  decoration: BoxDecoration(
                                      color: selectedProduct == index
                                          ? ConstColor.violet91Color
                                          : ConstColor.whiteColor,
                                      borderRadius: BorderRadius.circular(50)),
                                  child: Row(
                                    children: [
                                      Radio(
                                        value: true,
                                        groupValue: productList[selectedProduct]
                                            ['name'],
                                        onChanged: (value) {},
                                      ),
                                      Text(
                                        "${productList[index]['name']} - ${productList[index]['full_name']}",
                                        style: TextStyle(
                                          color: selectedProduct == index
                                              ? ConstColor.whiteColor
                                              : ConstColor.black29Color,
                                          fontSize: size.height * 0.015,
                                          fontWeight: FontWeight.w500,
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                              ),
                            );
                          },
                        ),
                        SizedBox(height: size.height * 0.03),
                      ],
                    ),
                  );
                });
              },
            ).then((value) {});
          },
          child: Container(
            width: size.width,
            decoration: BoxDecoration(
              border: Border.all(
                color: ConstColor.black29Color,
              ),
              borderRadius: BorderRadius.circular(50),
            ),
            padding: EdgeInsets.symmetric(
              horizontal: size.width * 0.05,
              vertical: size.height * 0.015,
            ),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(productList[selectedProduct]['name']),
                const Icon(Icons.keyboard_arrow_down_rounded),
              ],
            ),
          ),
        ),
      ],
    );
  }

  Widget _buildLotFiled(Size size) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          advisoryResult!.isCash == true
              ? 'Quantity'
              : 'Quantity (${quantityController.text} X ${advisoryResult!.lotsize})',
          style: TextStyle(
            color: ConstColor.black29Color,
            fontSize: size.height * 0.015,
            fontWeight: FontWeight.w500,
          ),
        ),
        SizedBox(height: size.height * 0.01),
        TextFormField(
          controller: quantityController,
          keyboardType: TextInputType.number,
          onChanged: (val) {
            setReqMargin();
          },
          autovalidateMode: AutovalidateMode.always,
          validator: (value) {
            if (value!.isEmpty) {
              return "Please Enter quantity";
            } else if (int.parse(value) <= 0) {
              return "Please Enter a valid quantity";
            } else {
              return null;
            }
          },
          textAlign: TextAlign.center,
          decoration: InputDecoration(
            contentPadding: EdgeInsets.symmetric(horizontal: size.width * 0.05),
            enabledBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(50),
              borderSide: const BorderSide(
                color: ConstColor.black29Color,
              ),
            ),
            focusedErrorBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(50),
              borderSide: const BorderSide(
                color: Colors.red,
              ),
            ),
            errorBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(50),
              borderSide: const BorderSide(
                color: Colors.red,
              ),
            ),
            prefix: GestureDetector(
                onTap: () {
                  changeQuan(isIncr: false);
                },
                child: Container(
                  padding: EdgeInsets.symmetric(horizontal: 15),
                  // decoration: BoxDecoration(color: Colors.red),
                  child: const Text(
                    '-',
                    style: TextStyle(fontSize: 22),
                  ),
                )),
            suffix: GestureDetector(
                onTap: () {
                  changeQuan(isIncr: true);
                },
                child: Container(
                  padding: EdgeInsets.symmetric(horizontal: 15),
                  child: const Text(
                    '+',
                    style: TextStyle(fontSize: 22),
                  ),
                )),
            focusedBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(50),
              borderSide: const BorderSide(
                color: ConstColor.black29Color,
              ),
            ),
          ),
        ),
      ],
    );
  }

  Widget _buildQuantityFiled(Size size) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          'Quantity',
          style: TextStyle(
            color: ConstColor.black29Color,
            fontSize: size.height * 0.015,
            fontWeight: FontWeight.w500,
          ),
        ),
        SizedBox(height: size.height * 0.01),
        TextFormField(
          controller: quantityController,
          keyboardType: TextInputType.number,
          onChanged: (val) {
            setReqMargin();
          },
          autovalidateMode: AutovalidateMode.always,
          validator: (value) {
            if (value!.isEmpty) {
              return "Please Enter Quantity";
            } else if (int.parse(value) <= 0) {
              return "Please Enter Valid Quantity";
            } else {
              return null;
            }
          },
          decoration: InputDecoration(
            contentPadding: EdgeInsets.symmetric(horizontal: size.width * 0.05),
            enabledBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(50),
              borderSide: const BorderSide(
                color: ConstColor.black29Color,
              ),
            ),
            errorBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(50),
              borderSide: const BorderSide(
                color: Colors.red,
              ),
            ),
            focusedBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(50),
              borderSide: const BorderSide(
                color: ConstColor.black29Color,
              ),
            ),
          ),
        ),
      ],
    );
  }

  Widget _buildPriceFiled(Size size) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          'Price',
          style: TextStyle(
            color: ConstColor.black29Color,
            fontSize: size.height * 0.015,
            fontWeight: FontWeight.w500,
          ),
        ),
        SizedBox(height: size.height * 0.01),
        TextField(
          controller: priceController,
          enabled: ConstList()
                  .orderTypeList[selectedOrderType]['name']
                  .toString()
                  .toLowerCase()
                  .contains('market')
              ? false
              : true,
          onChanged: (val) {
            setReqMargin();
          },
          keyboardType: TextInputType.number,
          decoration: InputDecoration(
            contentPadding: EdgeInsets.symmetric(horizontal: size.width * 0.05),
            enabledBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(50),
              borderSide: const BorderSide(
                color: ConstColor.black29Color,
              ),
            ),
            disabledBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(50),
              borderSide: BorderSide(
                color: ConstColor.black29Color.withOpacity(0.3),
              ),
            ),
            focusedBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(50),
              borderSide: const BorderSide(
                color: ConstColor.black29Color,
              ),
            ),
          ),
        ),
      ],
    );
  }

  Widget _buildSlPriceFiled(Size size) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          'SL Trigger Price',
          style: TextStyle(
            color: ConstColor.black29Color,
            fontSize: size.height * 0.015,
            fontWeight: FontWeight.w500,
          ),
        ),
        SizedBox(height: size.height * 0.01),
        TextField(
          controller: slPriceController,
          // enabled:
          //     ? true
          //     : false,
          keyboardType: TextInputType.number,
          decoration: InputDecoration(
            contentPadding: EdgeInsets.symmetric(horizontal: size.width * 0.05),
            enabledBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(50),
              borderSide: const BorderSide(
                color: ConstColor.black29Color,
              ),
            ),
            disabledBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(50),
              borderSide: BorderSide(
                color: ConstColor.black29Color.withOpacity(0.3),
              ),
            ),
            focusedBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(50),
              borderSide: const BorderSide(
                color: ConstColor.black29Color,
              ),
            ),
          ),
        ),
      ],
    );
  }

  Widget _buildHeaderImage(Size size) {
    return Container(
      color: ConstColor.black42Color,
      child: Stack(
        children: [
          Padding(
            padding: EdgeInsets.symmetric(horizontal: size.width * 0.02),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                SizedBox(height: size.height * 0.05),
                IconButton(
                  icon: const Icon(
                    Icons.arrow_back,
                    color: ConstColor.whiteColor,
                  ),
                  onPressed: () {
                    Navigator.of(context).pop();
                  },
                ),
                SizedBox(height: size.height * 0.015),
                Padding(
                  padding: EdgeInsets.symmetric(horizontal: size.width * 0.04),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        advisoryResult!.symbolFormatted!,
                        style: TextStyle(
                          color: ConstColor.whiteColor,
                          fontSize: size.height * 0.03,
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                      Text(
                        'by ${advisoryResult!.advisor}',
                        style: TextStyle(
                          color: ConstColor.whiteColor,
                          fontSize: size.height * 0.015,
                          fontWeight: FontWeight.w400,
                        ),
                      ),
                      SizedBox(height: size.height * 0.02),
                      Row(
                        children: [
                          Container(
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(10),
                              gradient: LinearGradient(
                                colors: ConstColor.mainThemeGradient,
                              ),
                            ),
                            padding: EdgeInsets.symmetric(
                                horizontal: size.width * 0.03, vertical: 3),
                            child: Text(
                              'Hot Calls',
                              style: TextStyle(
                                color: ConstColor.whiteColor,
                                fontSize: size.height * 0.015,
                                fontWeight: FontWeight.w600,
                              ),
                            ),
                          ),
                          SizedBox(width: size.width * 0.02),
                          Container(
                              padding: EdgeInsets.symmetric(
                                  horizontal: size.width * 0.03, vertical: 3),
                              decoration: BoxDecoration(
                                border: Border.all(
                                  color: ConstColor.whiteColor,
                                ),
                                borderRadius: BorderRadius.circular(25),
                              ),
                              height: size.height * 0.03,
                              width: size.width * 0.27,
                              child: Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                crossAxisAlignment: CrossAxisAlignment.center,
                                children: [
                                  Text(
                                    "${transactionType.capitalize()} Now",
                                    style: TextStyle(
                                      fontSize: 12,
                                      color:
                                          transactionType.toLowerCase() == 'buy'
                                              ? Colors.green
                                              : Colors.red,
                                    ),
                                  ),
                                  RotatedBox(
                                    quarterTurns: 1,
                                    child: Icon(
                                      Icons.chevron_right,
                                      color:
                                          transactionType.toLowerCase() == 'buy'
                                              ? Colors.green
                                              : Colors.red,
                                      size: 20,
                                    ),
                                  ),
                                  // Icon(

                                  //   color:
                                  //       transactionType.toLowerCase() == 'buy'
                                  //           ? Colors.green
                                  //           : Colors.red,
                                  // )
                                ],
                              )

                              // DropdownButtonHideUnderline(
                              //   child: DropdownButton(
                              //     icon: const RotatedBox(
                              //       quarterTurns: 3,
                              //       child: Icon(
                              //         Icons.chevron_left,
                              //         color: ConstColor.whiteColor,
                              //         size: 18,
                              //       ),
                              //     ),
                              //     value: transactionType,
                              //     items: transactionTypeList.map((e) {
                              //       return DropdownMenuItem(
                              //         value: e['type'],
                              //         child: Text(
                              //           e['name'].toString(),
                              //           style: TextStyle(
                              //             color: e['color'],
                              //             fontSize: 12,
                              //           ),
                              //         ),
                              //       );
                              //     }).toList(),
                              //     onChanged: (value) {
                              //       setState(() {
                              //         transactionType = value.toString();
                              //       });
                              //     },
                              //   ),
                              // ),
                              ),
                        ],
                      ),
                      SizedBox(height: size.height * 0.02),
                      segmentPill(size, name: 'NSE')
                      // Row(
                      //   mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      //   children: ['NSE', 'BSE']
                      //       .map((e) => segmentPill(size, name: e))
                      //       .toList(),
                      // ),
                    ],
                  ),
                )
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget segmentPill(Size size, {required String name}) {
    double percentChange = 0.0;
    return StreamBuilder(
        stream: socketStream,
        builder: (context, snap) {
          if (snap.hasData && snap.data != null) {
            if (snap.data!.exchangeInstrumentID == advisoryResult!.secToken) {
              debugPrint("$name - ${snap.data!.lastTradedPrice}");
              advisoryResult!.ltp = snap.data!.lastTradedPrice;
              percentChange = snap.data!.percentChange!;
              debugPrint(advisoryResult!.ltp.toString());
            }
          }
          return GestureDetector(
            onTap: () {
              changeSegment(name);
            },
            child: Container(
              width: size.width * 0.43,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(10),
                border: Border.all(
                  color: ConstColor.whiteColor.withOpacity(0.5),
                ),
              ),
              padding: EdgeInsets.symmetric(
                horizontal: size.width * 0.03,
                vertical: size.width * 0.04,
              ),
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  Theme(
                    data: ThemeData(
                      unselectedWidgetColor:
                          ConstColor.whiteColor.withOpacity(0.6),
                    ),
                    child: SizedBox(
                      height: size.height * 0.025,
                      width: 15,
                      child: Radio(
                        activeColor: ConstColor.whiteColor,
                        focusColor: ConstColor.whiteColor,
                        value: name,
                        groupValue: selectedExchange,
                        onChanged: (value) {
                          setState(() {
                            selectedExchange = value.toString();
                          });
                        },
                      ),
                    ),
                  ),
                  SizedBox(width: size.width * 0.025),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: [
                      Text(
                        name,
                        style: TextStyle(
                          color: ConstColor.whiteColor,
                          fontSize: size.height * 0.015,
                          fontWeight: FontWeight.w500,
                        ),
                      ),
                      SizedBox(height: size.height * 0.005),
                      Row(
                        children: [
                          Text(
                            advisoryResult!.ltp.toString(),
                            style: TextStyle(
                              color: ConstColor.whiteColor,
                              fontSize: size.height * 0.015,
                              fontWeight: FontWeight.w500,
                            ),
                          ),
                          SizedBox(width: size.width * 0.015),
                          (percentChange != 0.0)
                              ? Text(
                                  '(${percentChange.toStringAsFixed(2)}%)',
                                  style: TextStyle(
                                    color: percentChange > 0
                                        ? ConstColor.greenColor75
                                        : Colors.red,
                                    fontSize: size.height * 0.014,
                                    fontWeight: FontWeight.w400,
                                  ),
                                )
                              : Container(),
                        ],
                      ),
                      // instQuote.isNotEmpty
                      //     ?
                      //     : Container(),
                    ],
                  ),
                ],
              ),
            ),
          );
        });
  }

  // Widget segmentPill(Size size, {required String name}) {
  //   final index = (name == 'NSE') ? 0 : 1;
  //   return (instQuote.isNotEmpty &&
  //           instQuote[index].touchline!.lastTradedPrice! > 0)
  //       ? StreamBuilder(
  //           stream: socketStream,
  //           builder: (context, snap) {
  //             if (snap.hasData && snap.data != null) {
  //               if (snap.data!.exchangeInstrumentID ==
  //                   instQuote[index].exchangeInstrumentID) {
  //                 debugPrint("$name - ${snap.data!.lastTradedPrice}");
  //                 instQuote[index].touchline!.lastTradedPrice =
  //                     snap.data!.lastTradedPrice;
  //                 debugPrint(instQuote[index].touchline!.lastTradedPrice);
  //               }
  //             }
  //             return GestureDetector(
  //               onTap: () {
  //                 changeSegment(name);
  //               },
  //               child: Container(
  //                 width: size.width * 0.43,
  //                 decoration: BoxDecoration(
  //                   borderRadius: BorderRadius.circular(10),
  //                   border: Border.all(
  //                     color: ConstColor.whiteColor.withOpacity(0.5),
  //                   ),
  //                 ),
  //                 padding: EdgeInsets.symmetric(
  //                   horizontal: size.width * 0.03,
  //                   vertical: size.width * 0.04,
  //                 ),
  //                 child: Row(
  //                   crossAxisAlignment: CrossAxisAlignment.start,
  //                   mainAxisAlignment: MainAxisAlignment.start,
  //                   children: [
  //                     Theme(
  //                       data: ThemeData(
  //                         unselectedWidgetColor:
  //                             ConstColor.whiteColor.withOpacity(0.6),
  //                       ),
  //                       child: SizedBox(
  //                         height: size.height * 0.025,
  //                         width: 15,
  //                         child: Radio(
  //                           activeColor: ConstColor.whiteColor,
  //                           focusColor: ConstColor.whiteColor,
  //                           value: name,
  //                           groupValue: selectedExchange,
  //                           onChanged: (value) {
  //                             setState(() {
  //                               selectedExchange = value.toString();
  //                             });
  //                           },
  //                         ),
  //                       ),
  //                     ),
  //                     SizedBox(width: size.width * 0.025),
  //                     Column(
  //                       crossAxisAlignment: CrossAxisAlignment.start,
  //                       mainAxisAlignment: MainAxisAlignment.start,
  //                       children: [
  //                         Text(
  //                           name,
  //                           style: TextStyle(
  //                             color: ConstColor.whiteColor,
  //                             fontSize: size.height * 0.015,
  //                             fontWeight: FontWeight.w500,
  //                           ),
  //                         ),
  //                         SizedBox(height: size.height * 0.005),
  //                         Row(
  //                           children: [
  //                             Text(
  //                               instQuote[index]
  //                                   .touchline!
  //                                   .lastTradedPrice
  //                                   .toString(),
  //                               style: TextStyle(
  //                                 color: ConstColor.whiteColor,
  //                                 fontSize: size.height * 0.015,
  //                                 fontWeight: FontWeight.w500,
  //                               ),
  //                             ),
  //                             SizedBox(width: size.width * 0.015),
  //                             Text(
  //                               '(${instQuote[index].touchline!.percentChange!.toStringAsFixed(2)}%)',
  //                               style: TextStyle(
  //                                 color: instQuote[index]
  //                                             .touchline!
  //                                             .percentChange! >
  //                                         0
  //                                     ? ConstColor.greenColor75
  //                                     : Colors.red,
  //                                 fontSize: size.height * 0.014,
  //                                 fontWeight: FontWeight.w400,
  //                               ),
  //                             ),
  //                           ],
  //                         ),
  //                         // instQuote.isNotEmpty
  //                         //     ?
  //                         //     : Container(),
  //                       ],
  //                     ),
  //                   ],
  //                 ),
  //               ),
  //             );
  //           })
  //       : Container();
  // }
}
