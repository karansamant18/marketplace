import 'package:flutter/material.dart';
import 'package:flutter_mobile_bx/const/color.dart';
import 'package:flutter_mobile_bx/const/const_list.dart';
import 'package:flutter_mobile_bx/view/stock_detail/controller/get_advisor_filter_controller.dart';
import 'package:flutter_mobile_bx/view/stock_detail/view/past_perfomance_tab.dart';
import 'package:flutter_mobile_bx/view/x_advice/controller/advisor_controller.dart';
import 'package:flutter_mobile_bx/view/x_advice/model/get_advisor_call_model.dart';
import 'package:flutter_mobile_bx/helpers/user_model.dart';
import 'package:flutter_mobile_bx/view/stock_card/stock_card_view.dart';
import 'package:flutter_mobile_bx/view/stock_detail/view/filter_screen.dart';
import 'package:provider/provider.dart';

class StockCallScreen extends StatefulWidget {
  StockCallScreen(
      {super.key, required this.advisorId, this.callStatus = 'open'});

  final String advisorId;
  final String callStatus;

  @override
  State<StockCallScreen> createState() => _StockCallScreenState();
}

class _StockCallScreenState extends State<StockCallScreen>
    with TickerProviderStateMixin {
  GetAdvisorFilterController getAdvisorFilterController =
      GetAdvisorFilterController();
  late TabController _tabController;
  late TabController _pastTabController;
  ResponseModel<GetAdvisorCallsModel> getAdvisorCallsModel =
      ResponseModel<GetAdvisorCallsModel>();
  List<AdvisoryResults>? advisoryResultsList = [];
  int selectedTab = 0;
  int subIndexSelected = 0;
  String activeTab = "open";
  String activeDuration = "all";
  String? selectedAdvisorId;
  List predefFilters = [];
  List? filtersAppliedFromFilterScreen;
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

  List<double> minMaxPnl = [-100, 100];

  @override
  void initState() {
    selectedAdvisorId = widget.advisorId;
    activeTab = widget.callStatus;
    super.initState();
    setFilters();
    _tabController = TabController(vsync: this, length: 5, initialIndex: 0);
    _pastTabController = TabController(vsync: this, length: 4, initialIndex: 0);
    getAdvisorFilterController =
        Provider.of<GetAdvisorFilterController>(context, listen: false);
    getAdvirosorData();
  }

  setFilters() {
    predefFilters = [
      {
        "operator": "eq",
        "values": [activeTab],
        "field": "status"
      },
      {
        "operator": "eq",
        "values": activeDuration == 'all' ? [] : [activeDuration],
        "field": "callduration",
      },
      {
        "operator": "eq",
        "values": selectedAdvisorId != null &&
                selectedAdvisorId!.isNotEmpty &&
                selectedAdvisorId != ""
            ? [selectedAdvisorId]
            : [],
        "field": "advisorid"
      },
      {
        "operator": "eq",
        "values": [],
        "field": "subsegment",
      },
      {
        "operator": "eq",
        "values": [],
        "field": "calltype",
      },
      {
        "operator": "eq",
        "values": [],
        "field": "callcategory",
      },
      {
        "operator": "le",
        "values": [minMaxPnl[1].toString()],
        "field": "callpl",
      },
      {
        "operator": "ge",
        "values": [minMaxPnl[0].toString()],
        "field": "callpl",
      },
    ];
  }

  getAdvirosorData() {
    advisoryResultsList = [];
    final filters = (activeTab == 'open')
        ? predefFilters
            .where((element) => (element['field'] != "callpl"))
            .toList()
        : predefFilters;
    getAdvisorFilterController
        .getAdvisorCallController(
      filters: filters,
      sortBy: (activeTab == 'closed' ? "callpl" : ""),
      order: (activeTab == 'closed' ? "desc" : ""),
    )
        .then((value) {
      setState(() {
        advisoryResultsList = value.data?.advisoryResults;
        // if ((minMaxPnl[0] == -100 && minMaxPnl[1] == 100) ||
        //     activeTab == 'open') {
        //   advisoryResultsList = value.data?.advisoryResults;
        // } else {
        //   advisoryResultsList = value.data?.advisoryResults!
        //       .toList()
        //       .where((element) => (element.callpl! > minMaxPnl[0] &&
        //           element.callpl! < minMaxPnl[1]))
        //       .toList();
        // }
      });
    });
  }

  applyFilterSync(List filters) {
    setState(() {
      filters.forEach((e) {
        List lis = e["values"];
        if (e['field'] == 'advisorid') {
          selectedAdvisorId = lis.isNotEmpty ? lis[0] : null;
        }
        if (e['field'] == 'callduration') {
          activeDuration = lis.isNotEmpty ? lis[0] : 'all';
          _tabController.index = activeDuration == 'all'
              ? 0
              : (ConstList()
                      .durationList
                      .indexWhere((ele) => ele["type"] == activeDuration) +
                  1);
        }
        if (e['field'] == 'status') {
          activeTab = lis.isNotEmpty ? lis[0] : 'all';
        }
        if (e['field'] == 'callpl' && e['operator'] == 'le') {
          minMaxPnl[1] = lis.isNotEmpty
              ? lis.map((e) => double.parse(e.toString())).toList()[0]
              : 100;
        }
        if (e['field'] == 'callpl' && e['operator'] == 'ge') {
          minMaxPnl[0] = lis.isNotEmpty
              ? lis.map((e) => double.parse(e.toString())).toList()[0]
              : -100;
        }
      });
      predefFilters = filters;
    });
    getAdvirosorData();
  }

  @override
  void dispose() {
    _tabController.dispose();
    _pastTabController.dispose();
    getAdvisorFilterController.getAdvisorCallModel.data = null;
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return DefaultTabController(
      length: 2,
      child: Scaffold(
        body: SingleChildScrollView(
          child: Container(
            height: size.height,
            width: size.width,
            decoration: const BoxDecoration(
              gradient: LinearGradient(
                begin: Alignment.topLeft,
                end: Alignment.bottomRight,
                colors: [
                  Color(0xffEB4954),
                  ConstColor.blackColor,
                  ConstColor.blackColor,
                  ConstColor.blackColor,
                ],
              ),
            ),
            child: Padding(
              padding: EdgeInsets.symmetric(horizontal: size.width * 0.02),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  SizedBox(height: size.height * 0.04),
                  IconButton(
                    onPressed: () {
                      Navigator.of(context).pop();
                      // Navigator.pushReplacement(
                      //   context,
                      //   MaterialPageRoute(
                      //     builder: (context) => const BottomBarScreen(),
                      //   ),
                      // );
                    },
                    icon: const Icon(
                      Icons.arrow_back,
                      color: ConstColor.whiteColor,
                    ),
                  ),
                  SizedBox(height: size.height * 0.01),
                  Padding(
                    padding:
                        EdgeInsets.symmetric(horizontal: size.width * 0.03),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          "Finally, stock \ncalls that work.",
                          style: TextStyle(
                            fontFamily: 'ReadexPro',
                            color: ConstColor.whiteColor,
                            fontSize: size.height * 0.03,
                            fontWeight: FontWeight.w600,
                          ),
                        ),
                        SizedBox(height: size.height * 0.03),
                        _buildTabbar(size),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildTabbar(Size size) {
    return Column(
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Row(
              children: statusList.map((e) {
                return GestureDetector(
                  onTap: () {
                    setState(() {
                      activeTab = e['status'];
                      predefFilters.forEach((element) {
                        if (element['field'] == 'status') {
                          element["values"] = [activeTab];
                        }
                        if (element['field'] == 'callduration') {
                          element["values"] =
                              (activeTab == 'open' && activeDuration != 'all')
                                  ? [activeDuration]
                                  : [];
                        }
                      });
                    });
                    getAdvirosorData();
                  },
                  child: Container(
                    margin: EdgeInsets.only(right: 10),
                    padding: const EdgeInsets.symmetric(
                        vertical: 10, horizontal: 20),
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(50),
                      color: activeTab == e['status']
                          ? ConstColor.whiteColor
                          : null,
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
                              ? Color(0xFF542961)
                              : ConstColor.whiteColor,
                        ),
                      ),
                    ),
                  ),
                );
              }).toList(),
            ),
            IconButton(
              icon: const Icon(
                Icons.filter_list,
                color: ConstColor.whiteColor,
              ),
              onPressed: () {
                Navigator.of(context)
                    .push(
                  MaterialPageRoute(
                    builder: (context) => FilterScreen(filters: predefFilters),
                  ),
                )
                    .then((value) {
                  if (value != null) {
                    applyFilterSync(value);
                  }

                  // setState(() {
                  //   activeDurationClicked = false;
                  //   selectedAdvisorId = null;
                  //   if (value != null) {
                  //     filtersAppliedFromFilterScreen = value;
                  //     // (value as List).map((e) {
                  //     //   if (e["field"] == "callduration") {
                  //     //     activeDuration = e["field"];
                  //     //   }
                  //     // });
                  //   }
                  // });
                  // if (value != null) {
                  //   getAdvirosorData();
                  // }
                });
              },
            )
          ],
        ),
        SizedBox(height: size.height * 0.03),
        SizedBox(
          height: size.height / 1.45,
          child: activeTab == 'open'
              ? _buildAppsTab(size)
              : _buildPastPerformnceTab(size),
        ),
      ],
    );
  }

  Widget _buildAppsTab(Size size) {
    return Column(
      children: [
        TabBar(
          controller: _tabController,
          indicatorColor: ConstColor.whiteColor,
          indicatorSize: TabBarIndicatorSize.label,
          unselectedLabelColor: ConstColor.whiteColor.withOpacity(0.5),
          tabs: [
            Text("All"),
            ...ConstList().durationList.map((e) {
              return Text(e['name']);
            }).toList()
          ],
          isScrollable: true,
          onTap: (val) {
            setState(() {
              activeDuration =
                  val > 0 ? ConstList().durationList[val - 1]['type'] : "all";
              predefFilters.forEach((element) {
                if (element['field'] == 'callduration') {
                  element["values"] = val == 0 ? [] : [activeDuration];
                }
              });
            });
            getAdvirosorData();
          },
        ),
        SizedBox(height: size.height * 0.03),
        SizedBox(
          height: size.height / 1.6,
          child: TabBarView(
            physics: const NeverScrollableScrollPhysics(),
            controller: _tabController,
            children: [
              _buildAppsListView(size),
              ...ConstList().durationList.map((e) {
                return _buildAppsListView(size);
              })
            ].toList(),
          ),
        ),
      ],
    );
  }

  Widget _buildPastPerformnceTab(Size size) {
    return Consumer<AdvisorController>(builder: (context, value, child) {
      if (value.advisorCallListModel.data == null) {
        return SizedBox(
          height: size.height * 0.618,
          child: const Center(child: CircularProgressIndicator()),
        );
      } else {
        return PastPerfomanceTab(
          advisoryResultsList: advisoryResultsList,
          advisorId: selectedAdvisorId,
        );
      }
    });
  }

  Widget _buildAppsListView(Size size) {
    return Consumer<GetAdvisorFilterController>(
        builder: (context, value, child) {
      if (value.getAdvisorCallModel.data == null) {
        return SizedBox(
          height: size.height * 0.618,
          child: const Center(child: CircularProgressIndicator()),
        );
      } else {
        if (value.getAdvisorCallModel.data!.advisoryResults!.isEmpty) {
          return const SizedBox(
            child: Center(
              child: Text(
                'No Data Found',
                style: TextStyle(color: ConstColor.whiteColor),
              ),
            ),
          );
        } else {
          return ListView.builder(
            itemCount: advisoryResultsList?.length,
            shrinkWrap: true,
            padding: EdgeInsets.zero,
            itemBuilder: (context, index) {
              var advisoryResultsData = advisoryResultsList![index];
              return StockCardView(
                advisoryResults: advisoryResultsData,
              );
            },
          );
        }
      }
    });
  }
}
