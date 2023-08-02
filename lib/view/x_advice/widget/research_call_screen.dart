import 'package:flutter/material.dart';
import 'package:flutter_mobile_bx/const/color.dart';
import 'package:flutter_mobile_bx/const/image.dart';
import 'package:flutter_mobile_bx/helpers/sizes.dart';
import 'package:flutter_mobile_bx/view/buy_stock/buy_stock_screen.dart';
import 'package:flutter_mobile_bx/view/x_advice/controller/advisor_controller.dart';
import 'package:flutter_mobile_bx/view/x_advice/model/get_advisor_call_model.dart';
import 'package:flutter_mobile_bx/view/stock_card/stock_card_view.dart';
import 'package:flutter_mobile_bx/view/stock_detail/view/stock_call_sceen.dart';
import 'package:flutter_mobile_bx/websocket/web_socket.dart';
import 'package:flutter_mobile_bx/widgets/pill.dart';
import 'package:flutter_svg/svg.dart';
import 'package:provider/provider.dart';

class ResearchCallScreen extends StatefulWidget {
  const ResearchCallScreen({super.key});

  @override
  State<ResearchCallScreen> createState() => _ResearchCallScreenState();
}

class _ResearchCallScreenState extends State<ResearchCallScreen>
    with SingleTickerProviderStateMixin {
  late TabController _tabController;
  AdvisorController advisorController = AdvisorController();

  List<AdvisoryResults>? advisorList;

  String activeTab = "open";
  String activeDuration = "all";

  List<Map<String, dynamic>> duartionList = [
    {
      "type": "all",
      "name": "All",
    },
    {
      "type": "intraday",
      "name": "Intraday",
    },
    {
      "type": "short term",
      "name": "Short Term",
    },
    {
      "type": "mid term",
      "name": "Mid Term",
    },
    {
      "type": "long term",
      "name": "Long Term",
    },
  ];
  List<Map<String, dynamic>> statusList = [
    {
      "status": "open",
      "name": "Active",
    },
    {
      "status": "closed",
      "name": "Past Performance",
    },
  ];
  late ScrollController scrollController;
  bool isEnd = false;

  @override
  void initState() {
    scrollController = ScrollController();
    scrollController.addListener(() {
      // reached bottom
      if (scrollController.offset >=
              scrollController.position.maxScrollExtent &&
          !scrollController.position.outOfRange) {
        setState(() => isEnd = true);
      } else {
        setState(() => isEnd = false);
      }
    });
    advisorController = Provider.of<AdvisorController>(context, listen: false);
    getAdvisorData();
    super.initState();

    _tabController = TabController(vsync: this, length: 5);
  }

  getAdvisorData() {
    List filters = [];
    filters.add({
      "operator": "eq",
      "values": [activeTab],
      "field": "status",
    });
    filters.add({
      "operator": "eq",
      "values": activeDuration == 'all' ? [] : [activeDuration],
      "field": "callduration"
    });
    // advisorController.advisorCallListModel.data = null;
    CommonSocket().unsubscribeTokens(advisorList ?? []);
    advisorList = null;
    advisorController
        .advisorCallsListController(filters: filters, page: 0, count: 8)
        .then((value) {
      setState(() {
        isEnd = false;
        advisorList = value.data!.advisoryResults;
      });
      CommonSocket().subscribeTokens(advisorList ?? []);
    });
  }

  @override
  void dispose() {
    _tabController.dispose();
    debugPrint("unsubscribing research xadvice...");
    CommonSocket().unsubscribeTokens(advisorList ?? []);
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Container(
      decoration: const BoxDecoration(
        color: ConstColor.blackColor,
        borderRadius: BorderRadius.only(
            topLeft: Radius.circular(30), topRight: Radius.circular(30)),
      ),
      child: Column(
        children: [
          _buildResearchView(size),
          // SizedBox(height: size.height * 0.985),
          _buildTabbar(size),
        ],
      ),
      // child: Stack(
      //   alignment: Alignment.bottomCenter,
      //   children: [
      //     Column(
      //       children: [
      //         _buildResearchView(size),
      //         SizedBox(height: size.height * 0.985),
      //       ],
      //     ),
      //     _buildTabbar(size),
      //   ],
      // ),
    );
  }

  Widget _buildTabbar(Size size) {
    return Container(
      width: size.width,
      padding: EdgeInsets.symmetric(
        // vertical: size.height * 0.03,
        horizontal: size.width * 0.03,
      ),
      child: Column(
        children: [
          Row(
            children: statusList.map((e) {
              return GestureDetector(
                onTap: () {
                  setState(() {
                    activeTab = e['status'];
                  });
                  getAdvisorData();
                },
                child: Container(
                  margin: EdgeInsets.only(right: 10),
                  padding:
                      const EdgeInsets.symmetric(vertical: 10, horizontal: 20),
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(50),
                    color:
                        activeTab == e['status'] ? ConstColor.whiteColor : null,
                    border: activeTab == e['status']
                        ? null
                        : Border.all(color: Colors.white, width: 1),
                  ),
                  child: Align(
                    alignment: Alignment.center,
                    child: Text(
                      e['name'],
                      style: TextStyle(
                        fontSize: 13,
                        color: activeTab == e['status']
                            ? ConstColor.blackColor
                            : ConstColor.whiteColor,
                      ),
                    ),
                  ),
                ),
              );
            }).toList(),
          ),
          SizedBox(height: size.height * 0.03),
          _buildActiveTabs(size),
        ],
      ),
    );
  }

  Widget _buildActiveTabs(Size size) {
    // advisorList = value.getAdvisorCallModel.data!.advisoryResults;
    return Column(
      children: [
        TabBar(
          controller: _tabController,
          indicatorColor: ConstColor.whiteColor,
          indicatorSize: TabBarIndicatorSize.label,
          unselectedLabelColor: ConstColor.whiteColor.withOpacity(0.5),
          tabs: duartionList.map((e) {
            return Text(e['name']);
          }).toList(),
          isScrollable: true,
          onTap: (val) {
            setState(() {
              activeDuration = duartionList[val]['type'];
            });
            getAdvisorData();
          },
        ),
        SizedBox(height: size.height * 0.025),
        SizedBox(
          height: size.height * 0.5,
          child: TabBarView(
            physics: const NeverScrollableScrollPhysics(),
            controller: _tabController,
            children: duartionList.map((e) {
              return _buildListView(size);
            }).toList(),
          ),
        ),
        SizedBox(height: size.height * 0.03),
        Padding(
          padding: EdgeInsets.symmetric(horizontal: size.width * 0.05),
          child: Column(
            children: [
              const Divider(
                color: ConstColor.whiteColor,
                thickness: 1,
              ),
              SizedBox(height: size.height * 0.02),
              GestureDetector(
                onTap: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) =>
                          StockCallScreen(advisorId: "", callStatus: activeTab),
                    ),
                  );
                },
                child: Container(
                  decoration: const BoxDecoration(color: null),
                  width: ww(),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        'View all',
                        style: TextStyle(
                          color: ConstColor.whiteColor,
                          fontSize: size.height * 0.018,
                          fontWeight: FontWeight.w500,
                        ),
                      ),
                      Icon(
                        Icons.arrow_forward_ios_rounded,
                        size: size.height * 0.018,
                        color: ConstColor.whiteColor,
                      ),
                    ],
                  ),
                ),
              ),
              SizedBox(height: size.height * 0.02),
            ],
          ),
        ),
      ],
    );
  }

  Widget _buildResearchView(Size size) {
    return Container(
      width: size.width,
      decoration: BoxDecoration(
        color: ConstColor.blackColor,
        borderRadius: BorderRadius.only(
          topLeft: Radius.circular(size.width * 0.08),
          topRight: Radius.circular(size.width * 0.08),
        ),
      ),
      child: Stack(
        children: [
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // SizedBox(height: size.height * 0.03),
              Padding(
                padding: EdgeInsets.only(
                  top: size.height * 0.06,
                  bottom: size.height * 0.03,
                  left: size.width * 0.03,
                  right: size.width * 0.03,
                ),
                child: Stack(
                  clipBehavior: Clip.none,
                  children: [
                    Text(
                      'RESEARCH CALLS',
                      style: TextStyle(
                        letterSpacing: 2,
                        color: ConstColor.whiteColor,
                        fontSize: size.height * 0.028,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    Positioned(
                      right: -30,
                      top: -10,
                      child: SvgPicture.asset(ConstImage.magnifyGlassIcon),
                    ),
                  ],
                ),
              ),
              // SizedBox(height: size.height * 0.02),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildListView(Size size) {
    // final filterdAdvisorList = advisorList!
    //     .where((e) =>
    //         e.status.toString().toLowerCase() == activeTab &&
    //         e.callduration == activeDuration)
    //     .toList();
    return advisorList == null
        ? SizedBox(
            height: size.height * 0.5,
            child: const Center(child: CircularProgressIndicator()),
          )
        : SizedBox(
            height: size.height * 0.5,
            child: advisorList!.isEmpty
                ? const Center(
                    child: Text(
                      "No Data",
                      style: TextStyle(
                        color: ConstColor.whiteColor,
                      ),
                    ),
                  )
                : Stack(
                    children: [
                      GridView.builder(
                        itemCount: advisorList!.length,
                        // shrinkWrap: true,
                        padding: EdgeInsets.only(right: 150),
                        controller: scrollController,
                        gridDelegate:
                            const SliverGridDelegateWithFixedCrossAxisCount(
                          crossAxisCount: 1,
                          childAspectRatio: 2 / 1.7,
                        ),
                        scrollDirection: Axis.horizontal,
                        itemBuilder: (context, index) {
                          return advisorList == null
                              ? Container()
                              : StockCardView(
                                  advisoryResults: advisorList![index]);
                        },
                      ),
                      isEnd == true
                          ? Positioned(
                              right: 20,
                              child: GestureDetector(
                                onTap: () {
                                  Navigator.of(context).push(MaterialPageRoute(
                                    builder: (context) => StockCallScreen(
                                        advisorId: "", callStatus: activeTab),
                                  ));
                                },
                                child: Container(
                                  height: size.height * 0.475,
                                  width: size.width * 0.25,
                                  margin: const EdgeInsets.only(top: 20),
                                  decoration: BoxDecoration(
                                    color: Colors.white.withOpacity(0.4),
                                    borderRadius: BorderRadius.circular(10),
                                  ),
                                  child: const Align(
                                    alignment: Alignment.center,
                                    child: Text(
                                      'View All',
                                      style: TextStyle(
                                        color: ConstColor.whiteColor,
                                      ),
                                    ),
                                  ),
                                ),
                              ),
                            )
                          : Container(),
                    ],
                  ),
          );
  }

  Widget _buildCardView(Size size, int index) {
    return Padding(
      padding:
          EdgeInsets.only(left: size.width * 0.02, top: size.height * 0.02),
      child: Container(
        width: size.width * 0.75,
        margin: EdgeInsets.only(right: 20),
        decoration: BoxDecoration(
          color: ConstColor.whiteColor,
          borderRadius: BorderRadius.circular(25),
        ),
        // elevation: 8,
        // shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(15)),
        child: Padding(
          padding: EdgeInsets.symmetric(horizontal: size.width * 0.06),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              SizedBox(height: size.height * 0.02),
              Row(
                children: [
                  Text(
                    advisorList![index].symbolFormatted.toString(),
                    style: TextStyle(
                      color: ConstColor.violet42Color,
                      fontSize: size.height * 0.02,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                  SizedBox(width: size.width * 0.02),
                  Row(
                    children: [
                      Icon(
                        advisorList![index].potentialData! > 0
                            ? Icons.keyboard_arrow_up_rounded
                            : Icons.keyboard_arrow_down_rounded,
                        color: advisorList![index].potentialData! > 0
                            ? ConstColor.greenColor75
                            : Colors.red,
                        size: size.height * 0.02,
                      ),
                      Text(
                        "(${advisorList![index].potentialData!.toStringAsFixed(2)}%)",
                        style: TextStyle(
                          color: advisorList![index].potentialData! > 0
                              ? ConstColor.greenColor75
                              : Colors.red,
                          fontSize: size.height * 0.015,
                          fontWeight: FontWeight.w500,
                        ),
                      ),
                    ],
                  ),
                ],
              ),
              Text(
                "by ${advisorList![index].advisor ?? ''}",
                style: TextStyle(
                  color: ConstColor.violet42Color,
                  fontSize: size.height * 0.014,
                  fontWeight: FontWeight.w400,
                ),
              ),
              // Text(
              //   "${advisorList![index].callduration.toString()} - ${advisorList![index].status.toString()}", // ""advisorList![index].callduration,
              //   style: TextStyle(
              //     color: ConstColor.violet42Color,
              //     fontSize: size.height * 0.014,
              //     fontWeight: FontWeight.w400,
              //   ),
              // ),
              SizedBox(height: size.height * 0.02),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  callDetailPill(
                    size,
                    "Category",
                    advisorList![index].callcategory.toString(),
                  ),
                  callDetailPill(
                    size,
                    "Suitable For",
                    advisorList![index].callCategoryText.toString(),
                  ),
                  callDetailPill(
                    size,
                    "Duration",
                    duartionList.firstWhere((element) =>
                        element['type'] ==
                        advisorList![index].callduration)['name'],
                  ),
                ],
              ),
              SizedBox(height: size.height * 0.015),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  callDetailPill(
                    size,
                    "Expiry Date",
                    advisorList![index].contractexpiry.toString().split(" ")[0],
                  ),
                  callDetailPill(
                    size,
                    "Days left",
                    "${advisorList![index].daysLeft} days",
                  ),
                  advisorList![index].callPutText == ""
                      ? SizedBox(
                          width: ww() / 10,
                        )
                      : callDetailPill(
                          size,
                          "Call/Put",
                          advisorList![index].callPutText.toString(),
                        ),
                ],
              ),
              SizedBox(height: size.height * 0.03),
              GestureDetector(
                onTap: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => const BuyStockScreen(),
                    ),
                  );
                },
                child: Container(
                  decoration: BoxDecoration(
                    color: Color(0xFFEB4954).withOpacity(0.6),
                    borderRadius: BorderRadius.circular(20),
                  ),
                  padding:
                      const EdgeInsets.symmetric(vertical: 10, horizontal: 20),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        "Buy Now",
                        style: TextStyle(
                          color: ConstColor.whiteColor,
                        ),
                      ),
                      Icon(
                        Icons.chevron_right,
                        size: 28,
                        color: ConstColor.whiteColor,
                      )
                    ],
                  ),
                ),
              ),
              // SliderButton(
              //   height: 60,
              //   buttonColor: ConstColor.whiteColor,
              //   action: () {},
              //   label: Text(
              //     "Slide to cancel Event",
              //     style: TextStyle(
              //       color: Color(0xff4a4a4a),
              //       fontWeight: FontWeight.w500,
              //       fontSize: size.height * 0.018,
              //     ),
              //   ),
              //   buttonSize: size.height * 0.06,
              //   shimmer: false,
              //   icon: Icon(
              //     Icons.arrow_forward_ios_rounded,
              //     color: ConstColor.black29Color,
              //   ),
              // )
            ],
          ),
        ),
      ),
    );
  }

  Widget callDetailPill(Size size, String head, String value) {
    return Container(
      child: Pill.textPill(
        head: head,
        value: value,
        headStyle: const TextStyle(
          color: Color(0xFF888888),
          fontSize: 10,
        ),
        valueStyle: const TextStyle(
          color: Color(0xFF000000),
          fontSize: 12,
          fontWeight: FontWeight.w500,
        ),
      ),
    );
  }
}
