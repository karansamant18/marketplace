import 'package:flutter/material.dart';
import 'package:flutter_mobile_bx/const/color.dart';
import 'package:flutter_mobile_bx/const/styles.dart';
import 'package:flutter_mobile_bx/helpers/sizes.dart';
import 'package:flutter_mobile_bx/view/basket/controller/basket_summary_controller.dart';
import 'package:flutter_mobile_bx/view/basket/model/invest_summary_model.dart';
import 'package:flutter_mobile_bx/view/basket/model/post_trade_model.dart';
import 'package:flutter_mobile_bx/view/basket/pages/basket_status_dummy.dart';
import 'package:flutter_mobile_bx/widgets/pill.dart';
import 'package:provider/provider.dart';

class BasketDashboardScreen extends StatefulWidget {
  BasketDashboardScreen({super.key, this.status = "Active"});

  String status;

  @override
  State<BasketDashboardScreen> createState() => _BasketDashboardScreenState();
}

class _BasketDashboardScreenState extends State<BasketDashboardScreen> {
  BasketSummaryController basketSummaryController = BasketSummaryController();

  Map<String, Color> colorMap = {
    "GREEN": Colors.green,
    "RED": Colors.red,
    "GREY": Colors.grey,
  };

  Ggl02? investSummary;
  List<InvestedBasket>? allInvestedBasket;
  InvestedBasket? investedBasket;
  @override
  void initState() {
    basketSummaryController =
        Provider.of<BasketSummaryController>(context, listen: false);
    basketSummaryController.investSummary();
    basketSummaryController.getBasketDashboard(widget.status);
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
                Navigator.pushReplacement(
                  context,
                  MaterialPageRoute(
                    builder: (context) =>
                        const BasketStatusDummy(eleverTxnID: "", orderID: ""),
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
              "Dashboard",
              style: sTitleMedium.copyWith(
                fontSize: 22,
              ),
            ),
            sh(height: 35),
            buildInvestSummaryView(size),
            sh(height: 35),
            buildAllBasketsView(size),
          ],
        ),
      ),
    );
  }

  Widget buildAllBasketsView(Size size) {
    return Consumer<BasketSummaryController>(
      builder: (context, value, child) {
        if (value.basketDashboardModel.data == null) {
          return const Expanded(
            child: SizedBox(
              // height: size.height * 0.618,
              child: Center(child: CircularProgressIndicator()),
            ),
          );
        } else {
          allInvestedBasket = value.basketDashboardModel.data!.data;
          return Expanded(
            child: SizedBox(
              // height: size.height * 0.618,
              child: SingleChildScrollView(
                child: ListView.builder(
                  padding: const EdgeInsets.all(0),
                  shrinkWrap: true,
                  itemCount: allInvestedBasket!.length,
                  physics: const NeverScrollableScrollPhysics(),
                  itemBuilder: (context, index) {
                    return basketView(size, index);
                  },
                ),
              ),
            ),
          );
        }
      },
    );
  }

  Widget basketView(Size size, int index) {
    return Container(
      padding: const EdgeInsets.all(20),
      decoration: const BoxDecoration(
        color: ConstColor.whiteColor,
        borderRadius: BorderRadius.all(Radius.circular(7)),
      ),
      child: Column(
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Row(
                children: [
                  const Icon(
                    Icons.card_giftcard_rounded,
                    size: 22,
                  ),
                  sw(width: 70),
                  Text(
                    allInvestedBasket![index].productInstanceName.toString(),
                    style: const TextStyle(
                      fontSize: 16,
                    ),
                  ),
                ],
              ),
              // sw(width: 70),
              DropdownButton(
                  value: null,
                  underline: SizedBox.shrink(),
                  icon: Icon(Icons.more_vert),
                  items:
                      allInvestedBasket![index].otherAllowedActions!.map((e) {
                    return DropdownMenuItem(
                      value: e,
                      child: Text(e),
                    );
                  }).toList(),
                  onChanged: (val) {}),
            ],
          ),
          sh(height: 40),
          orderStatusPill(
            size,
            status: allInvestedBasket![index].dashboardStatus.toString(),
            statusColor: colorMap[allInvestedBasket![index].statusColor]!,
            tooltipMsg: allInvestedBasket![index].statusMessage,
          ),
          sh(height: 40),
          allInvestedBasket![index].investedAmt != 0
              ? investSincePill(size, index)
              : Container(),
          sh(height: 40),
          allInvestedBasket![index].investedAmt == 0
              ? Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Pill.textPill(
                      head: "Investment",
                      value: allInvestedBasket![index].contributeAmt.toString(),
                      headStyle: const TextStyle(
                        color: ConstColor.blackColor,
                        fontSize: 12,
                      ),
                      valueStyle: const TextStyle(
                        color: ConstColor.blackColor,
                        fontSize: 15,
                      ),
                      crossAxisAlignment: CrossAxisAlignment.start,
                    ),
                    Pill.textPill(
                      head: "Mode",
                      value: allInvestedBasket![index].investFreq.toString(),
                      headStyle: const TextStyle(
                        color: ConstColor.blackColor,
                        fontSize: 12,
                      ),
                      valueStyle: const TextStyle(
                        color: ConstColor.blackColor,
                        fontSize: 15,
                      ),
                      crossAxisAlignment: CrossAxisAlignment.start,
                    ),
                  ],
                )
              : Row(
                  // mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    allInvestedBasket![index].stepUpSip! > 0
                        ? Pill.textPill(
                            head: "Target",
                            value: allInvestedBasket![index].target.toString(),
                            headStyle: const TextStyle(
                              color: ConstColor.blackColor,
                              fontSize: 12,
                            ),
                            valueStyle: const TextStyle(
                              color: ConstColor.blackColor,
                              fontSize: 15,
                            ),
                            crossAxisAlignment: CrossAxisAlignment.start,
                          )
                        : const SizedBox.shrink(),
                    allInvestedBasket![index].stepUpSip! > 0
                        ? Spacer()
                        : Container(),
                    Pill.textPill(
                      head: "Invested",
                      value: allInvestedBasket![index].investedAmt.toString(),
                      headStyle: const TextStyle(
                        color: ConstColor.blackColor,
                        fontSize: 12,
                      ),
                      valueStyle: const TextStyle(
                        color: ConstColor.blackColor,
                        fontSize: 15,
                      ),
                      crossAxisAlignment: CrossAxisAlignment.start,
                    ),
                    Spacer(),
                    Pill.textPill(
                      head: "Current",
                      value:
                          allInvestedBasket![index].lastUpdatedValue.toString(),
                      headStyle: const TextStyle(
                        color: ConstColor.blackColor,
                        fontSize: 12,
                      ),
                      valueStyle: const TextStyle(
                        color: ConstColor.blackColor,
                        fontSize: 15,
                      ),
                      crossAxisAlignment: CrossAxisAlignment.start,
                    ),
                  ],
                ),
          allInvestedBasket![index].contextualActionText != ""
              ? basketActionButtom(size, index)
              : Container(),
        ],
      ),
    );
  }

  Widget basketActionButtom(Size size, int index) {
    return Container(
      width: ww(),
      decoration: BoxDecoration(
        color: const Color(0xff542961),
        borderRadius: BorderRadius.circular(5),
      ),
      padding: const EdgeInsets.symmetric(vertical: 10),
      margin: const EdgeInsets.only(top: 20),
      child: Center(
        child: Text(
          allInvestedBasket![index].contextualActionText.toString(),
          // allInvestedBasket![index].contextualActionText.toString(),
          style: TextStyle(color: ConstColor.whiteColor),
        ),
      ),
    );
  }

  Widget investSincePill(Size size, int index) {
    return Row(
      children: [
        Text(
          allInvestedBasket![index].stepUpSip! > 0
              ? "Target by"
              : "Invested Since",
          style: const TextStyle(
            fontSize: 12,
            color: Colors.grey,
          ),
        ),
        sw(width: 50),
        Text(
          allInvestedBasket![index].stepUpSip! > 0
              ? allInvestedBasket![index].targetAt.toString()
              : allInvestedBasket![index].activatedAt.toString(),
          style: const TextStyle(
            fontSize: 14,
          ),
        )
      ],
    );
  }

  Widget orderStatusPill(
    Size size, {
    required Color statusColor,
    required String status,
    String? tooltipMsg,
  }) {
    return Row(
      children: [
        Container(
          padding: EdgeInsets.all(5),
          decoration: BoxDecoration(
            color: statusColor,
            borderRadius: BorderRadius.all(Radius.circular(50)),
          ),
        ),
        sw(width: 50),
        Text(status),
        sw(width: 40),
        tooltipMsg != ""
            ? Tooltip(
                message: tooltipMsg,
                showDuration: const Duration(seconds: 3),
                triggerMode: TooltipTriggerMode.tap,
                child: const Icon(
                  Icons.info,
                  size: 18,
                  color: Colors.orange,
                ),
              )
            : Container(),
      ],
    );
  }

  Widget buildInvestSummaryView(Size size) {
    return Consumer<BasketSummaryController>(builder: (context, value, child) {
      if (value.investSummaryModel.data == null) {
        return const Expanded(
          child: SizedBox(
            // height: size.height * 0.618,
            child: Center(child: CircularProgressIndicator()),
          ),
        );
      } else {
        investSummary = value.investSummaryModel.data!.data.ggl02;
        return Container(
          padding: const EdgeInsets.all(20),
          width: ww(),
          decoration: const BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.all(Radius.circular(5)),
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const Text("Your Investment Summary"),
              sh(height: 30),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Pill.textPill(
                    head: "Active",
                    value: investSummary!.activeInstances.toString(),
                    headStyle: const TextStyle(
                      color: ConstColor.blackColor,
                      fontSize: 12,
                    ),
                    valueStyle: const TextStyle(
                      color: ConstColor.blackColor,
                      fontSize: 15,
                    ),
                    crossAxisAlignment: CrossAxisAlignment.start,
                  ),
                  Pill.textPill(
                    head: "Invested",
                    value: investSummary!.totalInvested.toString(),
                    headStyle: const TextStyle(
                      color: ConstColor.blackColor,
                      fontSize: 12,
                    ),
                    valueStyle: const TextStyle(
                      color: ConstColor.blackColor,
                      fontSize: 15,
                    ),
                    crossAxisAlignment: CrossAxisAlignment.start,
                  ),
                  Pill.textPill(
                    head: "Current",
                    value: investSummary!.currentValue.toString(),
                    headStyle: const TextStyle(
                      color: ConstColor.blackColor,
                      fontSize: 12,
                    ),
                    valueStyle: const TextStyle(
                      color: ConstColor.blackColor,
                      fontSize: 15,
                    ),
                    crossAxisAlignment: CrossAxisAlignment.start,
                  ),
                  Pill.textPill(
                    head: "Returns",
                    value:
                        "${investSummary!.currentReturns.toString()} (${investSummary!.returnPercent.toString()}%)",
                    headStyle: const TextStyle(
                      color: ConstColor.blackColor,
                      fontSize: 12,
                    ),
                    valueStyle: TextStyle(
                      color: investSummary!.currentReturns > 0
                          ? Colors.green
                          : Colors.red,
                      fontSize: 15,
                    ),
                    crossAxisAlignment: CrossAxisAlignment.start,
                  ),
                ],
              ),
            ],
          ),
        );
      }
    });
  }
}
