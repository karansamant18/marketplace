// ignore_for_file: prefer_const_constructors, prefer_const_literals_to_create_immutables

import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_mobile_bx/const/color.dart';
import 'package:flutter_mobile_bx/const/image.dart';
import 'package:flutter_mobile_bx/const/styles.dart';
import 'package:flutter_mobile_bx/helpers/sizes.dart';
import 'package:flutter_mobile_bx/view/basket/controller/basket_controller.dart';
import 'package:flutter_mobile_bx/view/basket/model/basket_intro_model.dart';
import 'package:flutter_mobile_bx/view/basket/model/basket_perf_model.dart';
import 'package:flutter_mobile_bx/view/basket/pages/basket_proposal_screen.dart';
import 'package:flutter_mobile_bx/view/basket/widgets/line_chart.dart';
import 'package:flutter_mobile_bx/widgets/bottom_modal.dart';
import 'package:flutter_mobile_bx/widgets/pill.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:provider/provider.dart';
import 'package:syncfusion_flutter_charts/charts.dart';

class BasketInfoScreen extends StatefulWidget {
  const BasketInfoScreen({super.key});

  @override
  State<BasketInfoScreen> createState() => _BasketInfoScreenState();
}

class _BasketInfoScreenState extends State<BasketInfoScreen> {
  bool isMoreDetail = false;

  Map<String, String> timeFrameMap = {
    '3M': '3M',
    '6M': '6M',
    '1Y': '1Y',
    '3Y': '3Y',
    '5Y': '5Y',
    '10Y': '10Y',
    'MAX': 'MAX',
    'Live': 'Live',
  };

  List<String> investmentFreqList = ['Monthly', 'One Time'];
  final GlobalKey<FormState> formKey = GlobalKey<FormState>();
  TextEditingController investAmountController = TextEditingController();
  String selectedTimeFrame = '3M';
  BasketController basketController = BasketController();
  BasketIntroModel? basketIntroData;
  BasketPerfModel? basketPerfData;

  @override
  void initState() {
    basketController = Provider.of<BasketController>(context, listen: false);
    basketController.basketIntroController(
      productId: basketController.selectedBasket!.productId.toString(),
    );
    basketController.basketPerfController();
    super.initState();
  }

  String formatAmount(double amount) {
    if (amount >= 10000000) {
      double croreAmount = amount / 10000000;
      return croreAmount.toStringAsFixed(1) + " Crs";
    } else if (amount >= 100000) {
      double lakhAmount = amount / 100000;
      return lakhAmount.toStringAsFixed(1) + " Lk";
    } else if (amount >= 1000) {
      double thousandAmount = amount / 1000;
      return thousandAmount.toStringAsFixed(1) + " K";
    } else {
      return amount.toString();
    }
  }

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Scaffold(
      backgroundColor: Colors.transparent,
      body: Builder(builder: (context) {
        return Container(
          decoration: BoxDecoration(
            color: Color(0xFF3B1F42),
            // image: DecorationImage(
            //   image: SvgPicture.asset('asset_name.svg'),
            //   fit: BoxFit.cover,
            // ),
            // gradient: LinearGradient(
            //   begin: Alignment.bottomCenter,
            //   end: Alignment.topCenter,
            //   colors: [
            //     const Color(0xff542961),
            //     const Color(0xff542961).withOpacity(0.9),
            //     const Color.fromARGB(255, 76, 19, 88),
            //     const Color.fromARGB(255, 122, 15, 144).withOpacity(0.7),
            //   ],
            // ),
          ),
          height: hh(),
          width: ww(),
          child: Container(
            // foregroundDecoration: ,
            decoration: BoxDecoration(),
            // padding: const EdgeInsets.fromLTRB(30, 30, 30, 0),
            child: buildMainView(size),
          ),
        );
      }),
    );
  }

  Widget buildMainView(Size size) {
    return Consumer<BasketController>(builder: (context, value, child) {
      if (value.basketIntroModel.data == null) {
        return const Expanded(
          child: SizedBox(
            // height: size.height * 0.618,
            child: Center(child: CircularProgressIndicator()),
          ),
        );
      } else {
        // debugPrint(value.basketIntroModel.data);
        basketIntroData = value.basketIntroModel.data;
        return Stack(
          children: [
            SingleChildScrollView(
              child: Stack(
                alignment: Alignment.bottomCenter,
                children: [
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Container(
                        width: ww(),
                        foregroundDecoration: BoxDecoration(
                          // color: Color.fromARGB(255, 84, 9, 107),
                          gradient: LinearGradient(
                              begin: Alignment.topCenter,
                              end: Alignment.bottomCenter,
                              colors: [
                                Color.fromARGB(15, 0, 0, 0),
                                Color(0xFF3B1F42),
                              ]),
                        ),
                        height: hh() / 4,
                        child: CachedNetworkImage(
                          fit: BoxFit.fitWidth,
                          progressIndicatorBuilder: (context, url, progress) =>
                              Center(
                            child: CircularProgressIndicator(
                              value: progress.progress,
                            ),
                          ),
                          imageUrl:
                              'https://images.unsplash.com/photo-1503435980610-a51f3ddfee50?ixlib=rb-4.0.3&ixid=MnwxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8&auto=format&fit=crop&w=1287&q=80',
                        ),
                      ),

                      Padding(
                        padding: const EdgeInsets.only(left: 20.0, right: 20),
                        child: Column(
                          children: [
                            sh(height: 35),
                            _buildMoreDetailView(size),
                            sh(height: 35),
                            _buildSubscribeDownloadView(size),
                            sh(height: 35),
                            _buildBasketPerfView(size),
                            sh(height: 15),
                            _buildHistPerfView(size),
                            sh(height: 20),
                            _buildPortfolioStats(size),
                            sh(height: 30),
                            buildChartView(size),
                            sh(height: 20),
                            _buildRebalanceView(size),
                            sh(height: 30),
                            _buildAllocationView(size),
                            sh(height: 30),
                          ],
                        ),
                      )

                      //
                    ],
                  ),
                  Positioned(
                    top: hh() / 20,
                    left: ww() / 40,
                    child: IconButton(
                        icon: Icon(
                          Icons.arrow_back_ios_new_rounded,
                          color: Colors.white,
                        ),
                        onPressed: () {
                          Navigator.pop(context);
                        }),
                  ),
                  Positioned(
                    top: hh() / 5.2,
                    left: ww() / 20,
                    child: Text(
                      basketIntroData!.data!.basketInfo!.productName.toString(),
                      style: sTitleLarge.copyWith(
                          color: Colors.white.withOpacity(0.9)),
                    ),
                  ),
                  Positioned(
                    top: hh() / 4,
                    left: ww() / 20,
                    child: SizedBox(
                      width: ww() / 1.25,
                      child: Text(
                        basketIntroData!.data!.basketInfo!.fullDescription
                            .toString(),
                        maxLines: 2,
                        overflow: TextOverflow.ellipsis,
                        style: sBodySmall.copyWith(
                            color: Colors.white.withOpacity(0.6)),
                      ),
                    ),
                  ),
                ],
              ),
            ),
            Positioned(
              bottom: 20,
              left: 20,
              right: 20,
              child: _buildButton(
                size: size,
                title: "Buy Now",
                image: ConstImage.flashIcon,
                onTap: () {
                  CommonDialogs.bottomDialog(
                    basketProposal(),
                    height: hh() / 2.8,
                  );
                },
              ),
            )
          ],
        );
      }
    });
  }

  Widget basketProposal() {
    Size size = MediaQuery.of(context).size;
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          "Investing in",
          style: sTitleSmall.copyWith(
            color: const Color(0xFFFF707A),
            fontSize: 12,
            fontWeight: FontWeight.w600,
          ),
        ),
        sh(),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Text(
              "Green Energy",
              style: sTitleLarge.copyWith(
                color: const Color(0xFF542961),
                fontSize: 22,
              ),
            ),
            Container(
              height: size.height * 0.04,
              width: size.width * 0.2,
              child: DropdownButtonHideUnderline(
                child: Padding(
                  padding: EdgeInsets.symmetric(horizontal: size.width * 0.00),
                  child: DropdownButton(
                    // dropdownMaxHeight: size.height * 0.85,
                    icon: const Icon(
                      Icons.keyboard_arrow_down,
                      color: Color(0xFFB66ACA),
                    ),
                    isExpanded: true,
                    style: const TextStyle(
                      fontSize: 13,
                      color: Color(0xFFB66ACA),
                      fontWeight: FontWeight.w500,
                    ),
                    value: "Monthly",
                    onChanged: (String? newValue) {
                      // setState(() {
                      //   selectedSymbol = newValue!;
                      //   getMaxPainData();
                      // });
                    },
                    items: investmentFreqList.map((String item) {
                      return DropdownMenuItem(
                        value: item,
                        child: Text(item),
                      );
                    }).toList(),
                  ),
                ),
              ),
            ),
          ],
        ),
        sh(height: 30),
        investmentAmountField(size),
        sh(height: 50),
        _buildInvestButtonView(context, size, "Invest Now", () {
          // debugPrint("dfndf");
          bool valid = formKey.currentState!.validate();
          // debugPrint(valid);
          if (valid) {
            Navigator.push(
              context,
              MaterialPageRoute(
                builder: (context) => BasketProposalScreen(
                  investAmt: !(investAmountController.text == '')
                      ? double.parse(investAmountController.text)
                      : 250000,
                  productID: basketIntroData!.data!.basketInfo!.productId!,
                ),
              ),
            );
          }
        }),
      ],
    );
  }

  Widget _buildInvestButtonView(
    BuildContext context,
    Size size,
    String title,
    void Function()? onTap,
  ) {
    return GestureDetector(
      behavior: HitTestBehavior.translucent,
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

  Widget investmentAmountField(Size size) {
    return Container(
      // width: size.width * 0.5,
      child: Form(
        key: formKey,
        child: TextFormField(
          autofocus: false,
          controller: investAmountController,
          keyboardType: TextInputType.number,
          decoration: InputDecoration(
            contentPadding: EdgeInsets.symmetric(horizontal: size.width * 0.05),
            focusedBorder: OutlineInputBorder(
                borderSide: const BorderSide(color: ConstColor.greyColor),
                borderRadius: BorderRadius.circular(30)),
            border: OutlineInputBorder(
                borderSide: const BorderSide(color: ConstColor.greyColor),
                borderRadius: BorderRadius.circular(30)),
            hintText: 'Enter Investment Amount',
            // suffixText: "Min. Amt ₹ 1L",
            // suffixStyle: const TextStyle(
            //   color: Color(0xFF269AD1),
            // ),
            suffix: const Text(
              "Min. Amt ₹ 1L",
              style: TextStyle(
                color: Color(0xFF269AD1),
                fontSize: 9,
              ),
            ),
            // prefixIcon: const Padding(
            //   padding: EdgeInsets.all(15),
            //   child: Text('+91 '),
            // ),
          ),
          validator: _validator,
        ),
      ),
    );
  }

  String? _validator(String? value) {
    int val = int.tryParse(value ?? "0") ?? 0;

    int min = basketIntroData!.data!.basketInfo!.minInvestAmt!;
    int max = basketIntroData!.data!.basketInfo!.maxInvestAmt!;
    int steps = basketIntroData!.data!.basketInfo!.adhocMinInvestAmt!;

    bool notMultiple = val % steps != 0;
    bool isEmpty = value!.isEmpty || value.length < 1;
    bool inRange = val > min && val < max;

    if (isEmpty || val == 0) {
      return "Please Enter Valid Amount";
    } else if (!inRange) {
      return "Please Enter Amount between $min and $max";
    } else if (notMultiple) {
      return "Please Enter a multiple of $steps";
    } else
      return "";
  }

  Widget buildChartView(Size size) {
    return SizedBox(
      height: size.height * 0.25,
      child: Consumer<BasketController>(builder: (context, value, child) {
        if (value.basketPerfModel.data == null) {
          return const Expanded(
            child: SizedBox(
              // height: size.height * 0.618,
              child: Center(child: CircularProgressIndicator()),
            ),
          );
        } else {
          basketPerfData = value.basketPerfModel.data;
          return LineChartScreen(
            chartData: basketPerfData!.data!.productSeries!.monthlyReturnList!
                .sublist(0, 20),
            chart2Data: basketPerfData!
                .data!.benchmarkSeries![0].monthlyReturnList!
                .sublist(0, 20),
          );
        }
      }),
    );
  }

  Widget _buildAllocationView(Size size) {
    List<ChartData> data = [];
    basketIntroData!.data!.basketInfo!.grpAllocations!.keys
        .toList()
        .forEach((e) {
      data.add(
          ChartData(e, basketIntroData!.data!.basketInfo!.grpAllocations![e]));
    });
    return Container(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Text(
            'Allocation',
            style: TextStyle(
              color: ConstColor.whiteColor,
              fontSize: 18,
            ),
          ),
          sh(),
          SizedBox(
            height: size.height * 0.3,
            // width: size.width / 2,
            child: SfCircularChart(
              legend: Legend(
                isVisible: true,
                position: LegendPosition.right,
                legendItemBuilder: (legendText, series, point, seriesIndex) {
                  // debugPrint(point);
                  return Container(
                    height: 30,
                    width: 120,
                    child: Row(children: <Widget>[
                      // Container(
                      //   padding: EdgeInsets.all(5),
                      //   color: point['fill'],
                      // ),
                      Text(
                        "${legendText.toString()} (${data[seriesIndex].y}%)",
                        style: const TextStyle(
                          color: ConstColor.whiteColor,
                          fontSize: 12,
                        ),
                      ),
                    ]),
                  );
                },
              ),
              // tooltipBehavior: _tooltip,
              series: [
                DoughnutSeries<ChartData, String>(
                  dataSource: data,
                  xValueMapper: (ChartData data, _) => data.x,
                  yValueMapper: (ChartData data, _) => data.y,
                  name: 'Allocation',
                  // pointColorMapper: (ChartData data, _) => data.color,
                )
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildRebalanceView(Size size) {
    return Container(
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Pill.textPill(
            head: 'Last Rebalanced On',
            value: basketIntroData!.data!.basketInfo!.lastRebalancedOn!,
            headStyle: TextStyle(
              color: ConstColor.whiteColor.withOpacity(0.7),
              fontSize: 11,
            ),
            valueStyle: const TextStyle(
              color: Color(0xFF72BEE2),
              fontSize: 15,
            ),
            crossAxisAlignment: CrossAxisAlignment.start,
          ),
          Pill.textPill(
            head: 'Rebalance Frequency',
            value: basketIntroData!.data!.basketInfo!.rebalanceFrequency!,
            headStyle: TextStyle(
              color: ConstColor.whiteColor.withOpacity(0.7),
              fontSize: 11,
            ),
            valueStyle: const TextStyle(
              color: Color(0xFFDC9DEC),
              fontSize: 16,
            ),
            crossAxisAlignment: CrossAxisAlignment.start,
          ),
          Pill.textPill(
            head: 'No Of Assets',
            value: basketIntroData!.data!.basketInfo!.assetCount!.toString(),
            headStyle: TextStyle(
              color: ConstColor.whiteColor.withOpacity(0.7),
              fontSize: 11,
            ),
            valueStyle: const TextStyle(
              color: Color(0xFFFF707A),
              fontSize: 16,
            ),
            crossAxisAlignment: CrossAxisAlignment.start,
          ),
        ],
      ),
    );
  }

  //Build Button View
  Widget _buildButton(
      {required Size size,
      required String title,
      required String image,
      required void Function() onTap}) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(50),
          gradient: const LinearGradient(
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
            colors: [
              Color(0xffE13662),
              Color(0xffEB4954),
              Color(0xffD346F0),
              Color(0xffD346F0),
            ],
          ),
        ),
        padding: EdgeInsets.symmetric(
          vertical: size.height * 0.015,
          horizontal: size.width * 0.04,
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Padding(
              padding: EdgeInsets.symmetric(
                horizontal: size.width * 0.01,
              ),
              child: Text(
                title,
                style: TextStyle(
                  color: ConstColor.whiteColor,
                  fontSize: size.height * 0.02,
                  // fontWeight: FontWeight.bold,
                ),
              ),
            ),
            SvgPicture.asset(image)
          ],
        ),
      ),
    );
  }

  Widget _buildPortfolioStats(Size size) {
    return Container(
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          SizedBox(
            width: size.width * 0.425,
            child: portfolioPill(
              size,
              head: 'Your Portfolio',
              value: '₹ 5485.50',
              valueSuffix: 18.56,
              prefixColor: const Color(0xFFDC9DEC),
            ),
          ),
          SizedBox(
            width: size.width * 0.425,
            child: portfolioPill(
              size,
              head: 'Benchmark',
              value: '₹ 3677.42',
              valueSuffix: -3.4,
              prefixColor: const Color(0xFFF5CD6E),
            ),
          ),
        ],
      ),
    );
  }

  Widget portfolioPill(
    Size size, {
    required Color prefixColor,
    required String head,
    required String value,
    double valueSuffix = 18.56,
    TextStyle headStyle = const TextStyle(
      color: ConstColor.whiteColor,
      fontSize: 12,
    ),
    TextStyle valueStyle = const TextStyle(
      color: ConstColor.whiteColor,
      fontSize: 15,
    ),
    TextStyle valueSuffixStyle = const TextStyle(
      color: ConstColor.greenColor75,
      fontSize: 15,
    ),
  }) {
    return Container(
      child: Column(
        children: [
          Row(
            children: [
              Container(
                padding: const EdgeInsets.all(4),
                decoration: BoxDecoration(
                  color: prefixColor,
                  borderRadius: const BorderRadius.all(
                    Radius.circular(50),
                  ),
                ),
              ),
              sw(width: 70),
              Text(
                head,
                style: headStyle,
              ),
            ],
          ),
          sh(),
          Row(
            children: [
              Text(
                value,
                style: valueStyle,
              ),
              sw(width: 30),
              Row(
                children: [
                  Text(
                    '${valueSuffix.toString()}%',
                    style: valueSuffixStyle.copyWith(
                      color: valueSuffix > 0
                          ? ConstColor.greenColor75
                          : Colors.red,
                    ),
                  ),
                  sw(),
                  RotatedBox(
                    quarterTurns: 3,
                    child: Icon(
                      valueSuffix > 0
                          ? Icons.arrow_forward_ios
                          : Icons.arrow_back_ios,
                      size: 14,
                      color: valueSuffix > 0
                          ? ConstColor.greenColor75
                          : Colors.red,
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

  Widget _buildHistPerfView(Size size) {
    return Container(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Text(
            'Historical Performance',
            style: TextStyle(
              color: ConstColor.whiteColor,
              fontSize: 18,
            ),
          ),
          sh(height: 50),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: timeFrameMap.keys.toList().map((e) {
              return GestureDetector(
                onTap: () {
                  setState(() {
                    selectedTimeFrame = e;
                  });
                },
                child: Text(
                  e,
                  style: TextStyle(
                    color: selectedTimeFrame == e
                        ? ConstColor.whiteColor
                        : ConstColor.whiteColor.withOpacity(0.3),
                  ),
                ),
              );
            }).toList(),
          )
        ],
      ),
    );
  }

  Widget _buildBasketPerfView(Size size) {
    return Container(
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Pill.widgetTextPill(
            head: const Icon(
              Icons.ac_unit_rounded,
              size: 22,
              color: Color(0xFFFF707A),
            ),
            value: "${basketIntroData!.data!.basketInfo!.volatility}",
            valueStyle: const TextStyle(
              fontSize: 10,
              color: Color(0xFFFF707A),
            ),
          ),
          Pill.widgetTextPill(
            head: const Icon(
              Icons.person,
              size: 22,
              color: Color(0xFFFBEB7C),
            ),
            value: "2.2K Interested",
            valueStyle: const TextStyle(
              fontSize: 10,
              color: Color(0xFFFBEB7C),
            ),
          ),
          Pill.textPill(
            head:
                "₹ ${formatAmount(double.parse(basketIntroData!.data!.basketInfo!.minInvestAmt.toString()))}",
            value: "Min. Amount",
            headStyle: const TextStyle(
              fontSize: 17,
              color: Color(0xFFDC9DEC),
            ),
            valueStyle: const TextStyle(
              fontSize: 10,
              color: Color(0xFFDC9DEC),
            ),
          ),
          Pill.textPill(
            head: basketIntroData!.data!.basketInfo!.cagr!
                .split('-')[1]
                .toString(),
            value: "2Y CAGR",
            headStyle: const TextStyle(
              fontSize: 17,
              color: Color(0xFF72BEE2),
            ),
            valueStyle: const TextStyle(
              fontSize: 10,
              color: Color(0xFF72BEE2),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildSubscribeDownloadView(Size size) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        SizedBox(
          width: size.width * 0.55,
          child: Container(
            decoration: BoxDecoration(
              color: const Color(0xFFB5DAD2),
              borderRadius: BorderRadius.circular(35),
            ),
            padding: const EdgeInsets.symmetric(vertical: 10, horizontal: 20),
            child: const Text(
              "Subscribe To Green Energy For 1.50% (+18% GST) Annual Charges Payable Monthly",
              style: TextStyle(
                fontSize: 8,
                color: Color(0xFF542961),
              ),
            ),
          ),
        ),
        SizedBox(
          width: size.width * 0.27,
          child: Container(
            padding: const EdgeInsets.symmetric(vertical: 10, horizontal: 20),
            decoration: BoxDecoration(
              color: null,
              borderRadius: BorderRadius.circular(35),
              border: Border.all(
                color: ConstColor.whiteColor.withOpacity(0.5),
              ),
            ),
            alignment: Alignment.center,
            child: const Text(
              "Download Factsheet",
              textAlign: TextAlign.center,
              style: TextStyle(
                fontSize: 8,
                color: ConstColor.whiteColor,
              ),
            ),
          ),
        )
      ],
    );
  }

  Widget _buildMoreDetailView(Size size) {
    return Column(
      children: [
        // isMoreDetail
        //     ? const Divider(color: ConstColor.whiteColor)
        //     : const SizedBox(),
        isMoreDetail
            ? Container(
                // duration: const Duration(seconds: 1),
                padding: EdgeInsets.only(top: 20),
                width: size.width,
                height: size.height / 4.9,
                child: GridView.builder(
                  gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                    crossAxisCount: 3,
                    childAspectRatio: 2 / 1.2,
                  ),
                  padding: EdgeInsets.symmetric(vertical: size.height * 0.02),
                  itemCount: 5,
                  shrinkWrap: true,
                  physics: const NeverScrollableScrollPhysics(),
                  itemBuilder: (context, index) {
                    return Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          'Segment',
                          style: TextStyle(
                            color: ConstColor.greyColor.withOpacity(0.7),
                            fontSize: size.height * 0.016,
                            fontWeight: FontWeight.w400,
                          ),
                        ),
                        SizedBox(height: size.height * 0.01),
                        Text(
                          'FNO',
                          style: TextStyle(
                            color: ConstColor.whiteColor,
                            fontSize: size.height * 0.016,
                            fontWeight: FontWeight.w500,
                          ),
                        )
                      ],
                    );
                  },
                ),
              )
            : const SizedBox(),
        SizedBox(height: size.height * 0.015),
        GestureDetector(
          onTap: () {
            setState(() {
              isMoreDetail = !isMoreDetail;
            });
          },
          child: Container(
            padding: EdgeInsets.symmetric(vertical: size.width * 0.03),
            child: Row(
              children: [
                Text(
                  isMoreDetail ? 'Read Less' : 'Read More',
                  style: TextStyle(
                    color: ConstColor.whiteColor.withOpacity(0.7),
                    fontSize: size.height * 0.016,
                    fontWeight: FontWeight.w400,
                  ),
                ),
                Icon(
                  isMoreDetail
                      ? Icons.keyboard_arrow_up_rounded
                      : Icons.keyboard_arrow_down_rounded,
                  color: ConstColor.whiteColor,
                )
              ],
            ),
          ),
        ),
      ],
    );
  }
}
