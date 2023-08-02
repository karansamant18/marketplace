// ignore_for_file: prefer_const_constructors

import 'package:flutter/material.dart';
import 'package:flutter_mobile_bx/const/color.dart';
import 'package:flutter_mobile_bx/helpers/common_functions.dart';
import 'package:flutter_mobile_bx/helpers/sizes.dart';
import 'package:flutter_mobile_bx/helpers/user_auth.dart';
import 'package:flutter_mobile_bx/view/auth/screen/widget/auth_card.dart';
import 'package:flutter_mobile_bx/view/bottom_bar.dart';
import 'package:flutter_mobile_bx/view/helper/controller/helper_controller.dart';
import 'package:flutter_mobile_bx/view/home/controller/home_cotroller.dart';
import 'package:flutter_mobile_bx/view/portfolio/controller/portfolio_controller.dart';
import 'package:flutter_mobile_bx/view/portfolio/model/portfolio_holdings_model.dart';
import 'package:flutter_mobile_bx/view/portfolio/model/positions_model.dart';
import 'package:provider/provider.dart';

class PortfolioScreen extends StatefulWidget {
  const PortfolioScreen({super.key});

  @override
  State<PortfolioScreen> createState() => _PortfolioScreenState();
}

class _PortfolioScreenState extends State<PortfolioScreen>
    with SingleTickerProviderStateMixin {
  String selectedCategory = 'holdings';
  TextEditingController searchController = TextEditingController();
  Map<String, String> portfolioMap = {
    'holdings': 'holdings',
    'positions': 'positions',
  };
  TabController? _tabController;
  PortfolioController portfolioController = PortfolioController();
  HomeController homeController = HomeController();
  HelperController helperController = HelperController();
  @override
  void initState() {
    _tabController = TabController(
      length: 2,
      vsync: this,
    );
    portfolioController =
        Provider.of<PortfolioController>(context, listen: false);
    helperController = Provider.of<HelperController>(context, listen: false);
    if (UserAuth().isJmClient() && UserAuth().isLoggedInBlinkX()) {
      getHoldings();
      getDayPositions();
      getNetPositions();
    }
    super.initState();
  }

  getNetPositions() {
    portfolioController.netPositionsController().then((value) {
      if (value.data!.data!.isNotEmpty) {
        List inst = [];
        value.data!.data!.forEach((element) {
          inst.add({
            "exchangeSegment": element.exchange == 'NSE'
                ? 1
                : (element.exchange == 'NFO' ? 2 : 11),
            "exchangeInstrumentID": int.parse(element.symboltoken!)
          });
        });
        helperController.instrumentQuotesApi(
          quotes: {
            "instruments": inst,
            "xtsMessageCode": 1502,
            "publishFormat": "JSON"
          },
        ).then((value) {
          portfolioController.netPositionsModel.data!.data!.forEach((element) {
            final ind = value.data!.result!.listQuotes!.indexWhere((ele) =>
                ele.exchangeInstrumentID ==
                int.parse(element.symboltoken.toString()));
            element.ltp =
                value.data!.result!.listQuotes![ind].touchline!.lastTradedPrice;
            // if(element.symboltoken == )
          });
          setState(() {});
        });
        // homeController.tokenSet();
      }
    });
  }

  getDayPositions() {
    portfolioController.dayPositionsController().then((value) {
      if (value.data!.data!.isNotEmpty) {
        List inst = [];
        value.data!.data!.forEach((element) {
          inst.add({
            "exchangeSegment": element.exchange == 'NSE'
                ? 1
                : (element.exchange == 'NFO' ? 2 : 11),
            "exchangeInstrumentID": int.parse(element.symboltoken!)
          });
        });
        helperController.instrumentQuotesApi(
          quotes: {
            "instruments": inst,
            "xtsMessageCode": 1502,
            "publishFormat": "JSON"
          },
        ).then((val) {
          portfolioController.dayPositionsModel.data!.data!.forEach((element) {
            final ind = val.data!.result!.listQuotes!.indexWhere((ele) =>
                ele.exchangeInstrumentID ==
                int.parse(element.symboltoken.toString()));
            element.ltp =
                val.data!.result!.listQuotes![ind].touchline!.lastTradedPrice;
            // if(element.symboltoken == )
          });
          setState(() {});
        });
      }
    });
  }

  getHoldings() {
    portfolioController.portfolioHoldingsController();

    // .then((value) {
    //   List inst = [];
    //   value.data!.data!.forEach((element) {
    //     inst.add({
    //       "exchangeSegment": element.exchange == 'NSE' ? 1 : 11,
    //       "exchangeInstrumentID": int.parse(element.symboltoken!)
    //     });
    //   });
    //   helperController.instrumentQuotesApi(
    //     quotes: {
    //       "instruments": inst,
    //       "xtsMessageCode": 1502,
    //       "publishFormat": "JSON"
    //     },
    //   ).then((value) {
    //     portfolioController.holdingsModel.data!.data!.forEach((element) {
    //       final ind = value.data!.result!.listQuotes!.indexWhere((ele) =>
    //           ele.exchangeInstrumentID ==
    //           int.parse(element.symboltoken.toString()));
    //       element.ltp =
    //           value.data!.result!.listQuotes![ind].touchline!.lastTradedPrice;
    //       // if(element.symboltoken == )
    //     });
    //     setState(() {});
    //   });
    // });
  }

  double calculatePnl(
      {required String qty, required double ltp, required double avg}) {
    return double.parse(
        ((ltp * int.parse(qty)) - (avg * int.parse(qty))).toStringAsFixed(2));
  }

  @override
  void dispose() {
    // TODO: implement dispose
    _tabController!.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Scaffold(
      backgroundColor: Colors.transparent,
      body: Container(
        decoration: BoxDecoration(
          gradient: LinearGradient(colors: ConstColor.mainThemeGradient),
        ),
        height: hh(),
        width: ww(),
        child: Container(
          // padding: const EdgeInsets.fromLTRB(30, 30, 30, 0),
          child: Column(
            // mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              GestureDetector(
                onTap: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => BottomBarScreen(),
                    ),
                  );
                },
                child: Container(
                  padding: const EdgeInsets.fromLTRB(30, 50, 30, 10),
                  child: Icon(
                    Icons.arrow_back,
                    size: size.height * 0.035,
                    color: ConstColor.whiteColor,
                  ),
                ),
              ),
              Container(
                child: Expanded(
                  child: Container(
                    padding: const EdgeInsets.fromLTRB(30, 30, 30, 0),
                    decoration: const BoxDecoration(
                      color: Color(0xFF000000),
                      borderRadius: BorderRadius.only(
                        topLeft: Radius.circular(25),
                        topRight: Radius.circular(25),
                      ),
                    ),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          "Portfolio",
                          style: TextStyle(
                            color: ConstColor.whiteColor,
                            fontSize: hh() * 0.035,
                            // fontWeight: FontWeight.bold,
                          ),
                        ),
                        sh(height: 30),
                        buildFilters(size),
                        sh(height: 30),
                        buildSearch(size),
                        sh(height: 50),
                        UserAuth().isJmClient()
                            ? UserAuth().isLoggedInBlinkX()
                                ? buildContent(size)
                                : Padding(
                                    padding: EdgeInsets.only(top: hh() / 20),
                                    child: AuthCard.loginCard(context,
                                        nextPage: PortfolioScreen()),
                                  )
                            : Padding(
                                padding: EdgeInsets.only(top: hh() / 20),
                                child: AuthCard.createAccountCard(context),
                              )
                      ],
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget buildContent(Size size) {
    return selectedCategory == 'holdings'
        ? buildHoldings(size)
        : buildPositions(size);
  }

  Widget buildPositions(Size size) {
    return Column(
      children: [
        TabBar(
          controller: _tabController,
          indicatorColor: ConstColor.whiteColor,
          indicatorSize: TabBarIndicatorSize.label,
          unselectedLabelColor: ConstColor.whiteColor.withOpacity(0.5),
          tabs: ["Day Positions", "Net Positions"].map((e) {
            return Text(e);
          }).toList(),
          isScrollable: true,
          // onTap: (val) {
          //   setState(() {
          //     activeDuration = duartionList[val]['type'];
          //   });
          //   getAdvisorData();
          // },
        ),
        SizedBox(height: size.height * 0.025),
        SizedBox(
          height: size.height * 0.58,
          child: TabBarView(
            physics: const NeverScrollableScrollPhysics(),
            controller: _tabController,
            children: [
              buildDayPositions(size),
              buildNetPositions(size),
            ],
          ),
        ),
      ],
    );
  }

  Widget buildDayPositions(Size size) {
    return Consumer<PortfolioController>(builder: (context, value, child) {
      if (value.dayPositionsModel.data == null ||
          (value.dayPositionsModel.data != null &&
              value.dayPositionsModel.data!.data!.isNotEmpty &&
              value.dayPositionsModel.data!.data![0].ltp! == 0)) {
        return const SizedBox(
          child: Center(child: CircularProgressIndicator()),
        );
      } else {
        List<Position> positionsList = value.dayPositionsModel.data!.data ?? [];
        if (searchController.text != "" && searchController.text.isNotEmpty) {
          positionsList = positionsList
              .where((element) => element.tradingsymbol!
                  .toLowerCase()
                  .contains(searchController.text.toLowerCase()))
              .toList();
        }
        if (positionsList.isNotEmpty) {
          return SingleChildScrollView(
            child: ListView.builder(
              padding: const EdgeInsets.all(0),
              shrinkWrap: true,
              itemCount: positionsList.length,
              physics: const NeverScrollableScrollPhysics(),
              itemBuilder: (context, index) {
                return positionsCardView(size, positionsList, index);
              },
            ),
          );
        } else {
          return SizedBox(
            child: Center(
                child: Text(
              'No ${selectedCategory.toString().capitalize()}',
              style: const TextStyle(color: ConstColor.whiteColor),
            )),
          );
        }
      }
    });
  }

  Widget buildNetPositions(Size size) {
    return Consumer<PortfolioController>(builder: (context, value, child) {
      if (value.netPositionsModel.data == null ||
          (value.netPositionsModel.data != null &&
              value.netPositionsModel.data!.data!.isNotEmpty &&
              value.netPositionsModel.data!.data![0].ltp! == 0)) {
        return const SizedBox(
          child: Center(child: CircularProgressIndicator()),
        );
      } else {
        List<Position> positionsList = value.netPositionsModel.data!.data ?? [];
        if (searchController.text != "" && searchController.text.isNotEmpty) {
          positionsList = positionsList
              .where((element) => element.tradingsymbol!
                  .toLowerCase()
                  .contains(searchController.text.toLowerCase()))
              .toList();
        }
        if (positionsList.isNotEmpty) {
          return SingleChildScrollView(
            child: ListView.builder(
              padding: const EdgeInsets.all(0),
              shrinkWrap: true,
              itemCount: positionsList.length,
              physics: const NeverScrollableScrollPhysics(),
              itemBuilder: (context, index) {
                return positionsCardView(size, positionsList, index);
              },
            ),
          );
        } else {
          return SizedBox(
            child: Center(
                child: Text(
              'No ${selectedCategory.toString().capitalize()}',
              style: const TextStyle(color: ConstColor.whiteColor),
            )),
          );
        }
      }
    });
  }

  Widget buildHoldings(Size size) {
    return Consumer<PortfolioController>(builder: (context, value, child) {
      if (value.portfolioHoldingsModel.data == null ||
          (value.portfolioHoldingsModel.data != null &&
              value.portfolioHoldingsModel.data!.data!.portfolio != null &&
              value.portfolioHoldingsModel.data!.data!.portfolio!
                  .equityHoldings!.isNotEmpty &&
              value.portfolioHoldingsModel.data!.data!.portfolio!
                      .equityHoldings![0].symbol!.ltp! ==
                  0)) {
        return const Expanded(
          child: SizedBox(child: Center(child: CircularProgressIndicator())),
        );
      } else {
        List<EquityHolding> holdingsList = value
                .portfolioHoldingsModel.data!.data?.portfolio?.equityHoldings ??
            [];
        if (searchController.text != "" && searchController.text.isNotEmpty) {
          holdingsList = holdingsList
              .where((element) => element.symbol!.tradingSym!
                  .toLowerCase()
                  .contains(searchController.text.toLowerCase()))
              .toList();
        }
        if (holdingsList.isNotEmpty) {
          return Expanded(
            child: SingleChildScrollView(
              child: ListView.builder(
                padding: const EdgeInsets.all(0),
                shrinkWrap: true,
                itemCount: holdingsList.length,
                physics: const NeverScrollableScrollPhysics(),
                itemBuilder: (context, index) {
                  return holdingsCardView(size, holdingsList, index);
                },
              ),
            ),
          );
        } else {
          return const Expanded(
            child: SizedBox(
              child: Center(
                child: Text('No Data Found',
                    style: TextStyle(color: ConstColor.whiteColor)),
              ),
            ),
          );
        }
      }
    });
  }

  Widget positionsCardView(Size size, List<Position> positions, int index) {
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
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                positions[index].symbolname.toString(),
                style: const TextStyle(
                  fontSize: 16,
                  color: Color(0xFF3B1F42),
                ),
              ),
              Text(
                "${positions[index].netqty.toString()} @${positions[index].avgPrice.toString()}",
                style: const TextStyle(
                  color: Color(0xFF3B1F42),
                  fontSize: 12,
                ),
              ),
            ],
          ),
          sh(),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                "LTP ${positions[index].ltp.toString()}",
                style: const TextStyle(
                  color: Color(0xFF3B1F42),
                  fontSize: 12,
                ),
              ),
              Text(
                "P/L ${calculatePnl(
                  avg: positions[index].avgPrice!,
                  ltp: positions[index].ltp!,
                  qty: positions[index].netqty!,
                ).toString()}",
                style: TextStyle(
                  fontSize: 12,
                  color: calculatePnl(
                            avg: positions[index].avgPrice!,
                            ltp: positions[index].ltp!,
                            qty: positions[index].netqty!,
                          ) >
                          0
                      ? const Color(0xFF2D8937).withOpacity(0.7)
                      : Colors.red,
                ),
              ),
            ],
          ),
          sh(),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                "Invested ${positions[index].invested!.toStringAsFixed(2)}",
                style: TextStyle(
                  fontSize: 12,
                  color: const Color(0xFF261C29).withOpacity(0.7),
                ),
              ),
              Row(
                children: [
                  Text(
                    "(${((calculatePnl(
                          avg: positions[index].avgPrice!,
                          ltp: positions[index].ltp!,
                          qty: positions[index].netqty!,
                        ) / positions[index].invested!) * 100).toStringAsFixed(2)}%)",
                    style: TextStyle(
                      fontSize: 12,
                      color: calculatePnl(
                                avg: positions[index].avgPrice!,
                                ltp: positions[index].ltp!,
                                qty: positions[index].netqty!,
                              ) >
                              0
                          ? const Color(0xFF2D8937).withOpacity(0.7)
                          : Colors.red,
                    ),
                  ),
                  // sw(),
                  // RotatedBox(
                  //   quarterTurns: 3,
                  //   child: Icon(
                  //     double.parse(positions[index].profitandloss.toString()) >
                  //             0
                  //         ? Icons.arrow_forward_ios
                  //         : Icons.arrow_back_ios,
                  //     size: 14,
                  //     color: double.parse(
                  //                 positions[index].profitandloss.toString()) >
                  //             0
                  //         ? Colors.green
                  //         : Colors.red,
                  //   ),
                  // ),
                ],
              ),
            ],
          ),
        ],
      ),
    );
  }

  // Widget holdingsCardView(Size size, List<Holding> holding, int index) {
  //   return Container(
  //     decoration: const BoxDecoration(
  //       color: Colors.white,
  //       borderRadius: BorderRadius.all(
  //         Radius.circular(15),
  //       ),
  //     ),
  //     padding: const EdgeInsets.all(20.0),
  //     margin: const EdgeInsets.only(bottom: 15.0),
  //     child: Column(
  //       children: [
  //         Row(
  //           mainAxisAlignment: MainAxisAlignment.spaceBetween,
  //           children: [
  //             Text(
  //               holding[index].tradingSymbol.toString(),
  //               style: const TextStyle(
  //                 fontSize: 16,
  //                 color: Color(0xFF3B1F42),
  //               ),
  //             ),
  //             Text(
  //               "${holding[index].quantity.toString()} @${holding[index].price.toString()}",
  //               style: const TextStyle(
  //                 color: Color(0xFF3B1F42),
  //                 fontSize: 12,
  //               ),
  //             ),
  //           ],
  //         ),
  //         sh(),
  //         Row(
  //           mainAxisAlignment: MainAxisAlignment.spaceBetween,
  //           children: [
  //             Text(
  //               "LTP ${holding[index].ltp.toString()}",
  //               style: const TextStyle(
  //                 color: Color(0xFF3B1F42),
  //                 fontSize: 12,
  //               ),
  //             ),
  //             Text(
  //               "P/L ${holding[index].profitandloss}",
  //               style: TextStyle(
  //                 fontSize: 12,
  //                 color:
  //                     double.parse(holding[index].profitandloss.toString()) > 0
  //                         ? const Color(0xFF2D8937).withOpacity(0.7)
  //                         : Colors.red,
  //               ),
  //             ),
  //           ],
  //         ),
  //         sh(),
  //         Row(
  //           mainAxisAlignment: MainAxisAlignment.spaceBetween,
  //           children: [
  //             Text(
  //               "Invested ${holding[index].invested!}",
  //               style: TextStyle(
  //                 fontSize: 12,
  //                 color: const Color(0xFF261C29).withOpacity(0.7),
  //               ),
  //             ),
  //             Row(
  //               children: [
  //                 Text(
  //                   "(${holding[index].pnlPct!}%)",
  //                   style: TextStyle(
  //                     fontSize: 12,
  //                     color: double.parse(
  //                                 holding[index].profitandloss.toString()) >
  //                             0
  //                         ? const Color(0xFF2D8937).withOpacity(0.7)
  //                         : Colors.red,
  //                   ),
  //                 ),
  //                 sw(),
  //                 RotatedBox(
  //                   quarterTurns: 3,
  //                   child: Icon(
  //                     double.parse(holding[index].profitandloss.toString()) > 0
  //                         ? Icons.arrow_forward_ios
  //                         : Icons.arrow_back_ios,
  //                     size: 14,
  //                     color: double.parse(
  //                                 holding[index].profitandloss.toString()) >
  //                             0
  //                         ? Colors.green
  //                         : Colors.red,
  //                   ),
  //                 ),
  //               ],
  //             ),
  //           ],
  //         ),
  //       ],
  //     ),
  //   );
  // }

  Widget holdingsCardView(Size size, List<EquityHolding> holding, int index) {
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
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                holding[index].symbol?.tradingSym ?? "",
                style: const TextStyle(
                  fontSize: 16,
                  color: Color(0xFF3B1F42),
                ),
              ),
              Text(
                "${holding[index].netQty} @${holding[index].netRate!.toStringAsFixed(2)}",
                style: const TextStyle(
                  color: Color(0xFF3B1F42),
                  fontSize: 12,
                ),
              ),
            ],
          ),
          sh(),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                "LTP ${holding[index].symbol!.ltp}",
                style: const TextStyle(
                  color: Color(0xFF3B1F42),
                  fontSize: 12,
                ),
              ),
              Text(
                "P/L ${holding[index].symbol!.pnl!.toStringAsFixed(2)}",
                style: TextStyle(
                  fontSize: 12,
                  color: holding[index].symbol!.pnl! >= 0
                      ? const Color(0xFF2D8937).withOpacity(0.7)
                      : Colors.red,
                ),
              ),
            ],
          ),
          sh(),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                "Invested ${holding[index].invested!.toStringAsFixed(2)}",
                style: TextStyle(
                  fontSize: 12,
                  color: const Color(0xFF261C29).withOpacity(0.7),
                ),
              ),
              Row(
                children: [
                  Text(
                    "(${holding[index].symbol!.pnlPct!.toStringAsFixed(2)}%)",
                    style: TextStyle(
                      fontSize: 12,
                      color: holding[index].symbol!.pnl! >= 0
                          ? const Color(0xFF2D8937).withOpacity(0.7)
                          : Colors.red,
                    ),
                  ),
                  sw(),
                  RotatedBox(
                    quarterTurns: 3,
                    child: Icon(
                      holding[index].symbol!.pnl! >= 0
                          ? Icons.arrow_forward_ios
                          : Icons.arrow_back_ios,
                      size: 14,
                      color: holding[index].symbol!.pnl! >= 0
                          ? Colors.green
                          : Colors.red,
                    ),
                  ),
                ],
              ),
            ],
          ),
        ],
      ),
    );
  }

  Widget buildSearch(Size size) {
    return Container(
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(30),
      ),
      child: Row(
        children: [
          SizedBox(
            width: size.width * 0.85,
            height: size.height * 0.045,
            child: TextFormField(
              autofocus: false,
              controller: searchController,
              cursorColor: const Color(0xFF6D6D6D),
              style: const TextStyle(
                color: Color(0xFF6D6D6D),
              ),
              onChanged: (value) {
                setState(() {});
              },
              cursorHeight: 20,
              keyboardType: TextInputType.text,
              decoration: InputDecoration(
                border: InputBorder.none,
                prefixIconColor: const Color(0xFF6D6D6D),
                prefixIcon: const Padding(
                  padding: EdgeInsets.all(0),
                  child: Icon(Icons.search),
                ),
                contentPadding: EdgeInsets.symmetric(
                  horizontal: size.width * 0.05,
                  vertical: size.height * 0.003,
                ),
                hintText: 'Search for a symbol/name',
                hintStyle: const TextStyle(
                  color: Color(0xFF6D6D6D),
                  fontSize: 14,
                ),
              ),
            ),
          )
        ],
      ),
    );
  }

  Widget buildFilters(Size size) {
    return Container(
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Row(
            children: [
              categoryPill(
                size: size,
                name: 'Holdings',
                index: 0,
              ),
              sw(width: 50),
              categoryPill(
                size: size,
                name: 'Positions',
                index: 1,
              ),
            ],
          ),
          Icon(
            Icons.filter_list_outlined,
            color: ConstColor.whiteColor,
            size: size.height * 0.03,
          )
        ],
      ),
    );
  }

  Widget categoryPill({
    required String name,
    required int index,
    required Size size,
  }) {
    return GestureDetector(
      onTap: () {
        setState(() {
          searchController.text = "";
          selectedCategory = portfolioMap[name.toLowerCase()].toString();
        });
      },
      child: Container(
        decoration: BoxDecoration(
            color: selectedCategory == portfolioMap[name.toLowerCase()]
                ? Colors.white
                : null,
            border: Border.all(color: Colors.white.withOpacity(0.5)),
            borderRadius: const BorderRadius.all(Radius.circular(20.0))),
        padding: EdgeInsets.symmetric(
          horizontal: size.width * 0.035,
          vertical: size.width * 0.015,
        ),
        child: Text(
          name,
          style: TextStyle(
            fontSize: 13,
            color: selectedCategory == portfolioMap[name.toLowerCase()]
                ? const Color.fromARGB(255, 122, 15, 144)
                : Colors.white.withOpacity(0.5),
          ),
        ),
      ),
    );
  }
}
