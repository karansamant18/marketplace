import 'package:flutter/material.dart';
import 'package:flutter_mobile_bx/const/color.dart';
import 'package:flutter_mobile_bx/const/image.dart';
import 'package:flutter_mobile_bx/helpers/sizes.dart';
import 'package:flutter_mobile_bx/view/stock_detail/view/stock_call_sceen.dart';
import 'package:flutter_mobile_bx/view/x_advice/model/get_advisor_call_model.dart';
import 'package:flutter_mobile_bx/view/x_advice/widget/advisor_profile_view.dart';
import 'package:flutter_mobile_bx/view/stock_card/stock_card_view.dart';
import 'package:flutter_mobile_bx/view/x_advice/controller/advisor_controller.dart';
import 'package:flutter_mobile_bx/view/x_advice/model/get_advisor_model.dart';
import 'package:flutter_mobile_bx/widgets/pill.dart';
import 'package:flutter_mobile_bx/widgets/text_gradiant_color.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:provider/provider.dart';
import 'package:visibility_detector/visibility_detector.dart';

import '../../../const/keys.dart';

class BlinkSuperStarView extends StatefulWidget {
  @override
  State<BlinkSuperStarView> createState() => _BlinkSuperStarViewState();
}

class _BlinkSuperStarViewState extends State<BlinkSuperStarView> {
  String activeTab = "picks";
  List<Map<String, dynamic>> statusList = [
    {
      "status": "picks",
      "name": "Picks",
    },
    {
      "status": "profiles",
      "name": "Profiles",
    },
  ];
  List<Map<String, dynamic>> duartionList = [
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
  List<GetAdvisorListModel>? advisorList;

  List<AdvisoryResults>? advisorCallList;
  late ScrollController superStarsXadvise;
  bool isEnd = false;
  // GetAdvisorFilterController getAdvisorFilterController =
  //     GetAdvisorFilterController();
  AdvisorController advisorController = AdvisorController();
  // HomeController homeController = HomeController();
  late bool changed;
  List<ScrollController>? controllerList;
  @override
  void initState() {
    changed = false;

    advisorController = Provider.of<AdvisorController>(context, listen: false);
    advisorController.getAdvisorListController();
    superStarsXadvise = ScrollController();
    advisorController.advisorCallsListController(filters: []).then((value) {
      advisorCallList = value.data!.advisoryResults;
    });

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Container(
      color: ConstColor.whiteColor,
      child: Padding(
        padding: EdgeInsets.symmetric(horizontal: size.width * 0.05),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            SizedBox(height: size.height * 0.035),
            Stack(
              clipBehavior: Clip.none,
              children: [
                GradientText(
                  'blinkx super stars'.toUpperCase(),
                  style: TextStyle(
                    fontSize: size.height * 0.028,
                    fontWeight: FontWeight.bold,
                  ),
                  gradient: const LinearGradient(
                    colors: [
                      ConstColor.pink62Color,
                      ConstColor.lightOrange,
                      ConstColor.violetF0Color
                    ],
                  ),
                ),
                Positioned(
                  right: -30,
                  top: -15,
                  child: SvgPicture.asset(ConstImage.threeStarsIcon),
                ),
              ],
            ),
            sh(height: 40),
            _buildTabbar(size)
          ],
        ),
      ),
    );
  }

  Widget _buildPicksView(Size size) {
    return Consumer<AdvisorController>(builder: (context, value, child) {
      if (value.getAdvisorListModel.data == null) {
        return SizedBox(
          height: size.height * 0.3,
          child: const Center(child: CircularProgressIndicator()),
        );
      } else {
        advisorList = value.getAdvisorListModel.data;

        // advisorList![0].isOpen = true;
        return ListView.builder(
          itemCount: advisorList!.length,
          shrinkWrap: true,
          physics: NeverScrollableScrollPhysics(),
          itemBuilder: (context, index) {
            return Padding(
              padding: EdgeInsets.symmetric(vertical: size.height * 0.02),
              child: Column(
                children: [
                  GestureDetector(
                    onTap: () {
                      setState(() {
                        if (!changed) {
                          changed = true;
                        }
                        advisorList![index].isOpen =
                            !advisorList![index].isOpen!;
                      });
                    },
                    child: Row(
                      children: [
                        Expanded(
                          child: Row(
                            children: [
                              ClipOval(
                                child: Image.network(
                                  advisorList![index].picLoc,
                                  height: 40,
                                ),
                              ),
                              SizedBox(width: size.width * 0.02),
                              Expanded(
                                child: Text(
                                  advisorList![index].tagline,
                                  style: TextStyle(
                                    color: ConstColor.black29Color,
                                    fontSize: size.height * 0.018,
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ),
                        Row(
                          children: [
                            Text(advisorList![index].isOpen == true ||
                                    (!changed && index == 0)
                                ? 'Hide'
                                : 'Show'),
                            Icon(advisorList![index].isOpen == true ||
                                    (!changed && index == 0)
                                ? Icons.keyboard_arrow_up_rounded
                                : Icons.keyboard_arrow_down_rounded),
                          ],
                        )
                      ],
                    ),
                  ),
                  advisorList![index].isOpen == true || (!changed && index == 0)
                      ? AnimatedContainer(
                          duration: const Duration(seconds: 1),
                          child: _buildListView(
                              size,
                              int.parse(advisorList![index]
                                  .blinkxAdvisorId
                                  .toString())),
                        )
                      : const SizedBox()
                ],
              ),
            );
          },
        );
      }
    });
  }

  Widget _buildTabbar(Size size) {
    return Container(
      width: size.width,
      // padding: EdgeInsets.symmetric(
      //     vertical: size.height * 0.03, horizontal: size.width * 0.03),
      child: Column(
        children: [
          Row(
            children: statusList.map((e) {
              return GestureDetector(
                onTap: () {
                  setState(() {
                    activeTab = e['status'];
                  });
                },
                child: Container(
                  margin: const EdgeInsets.only(right: 10),
                  padding:
                      const EdgeInsets.symmetric(vertical: 10, horizontal: 20),
                  decoration: activeTab == e['status']
                      ? BoxDecoration(
                          borderRadius: BorderRadius.circular(50),
                          gradient: LinearGradient(
                            colors: ConstColor.mainThemeGradient,
                          ),
                        )
                      : BoxDecoration(
                          borderRadius: BorderRadius.circular(50),
                          // color: ConstColor.blackColor,
                          border: Border.all(
                            color: const Color(0xFF000000),
                            width: 1,
                          ),
                        ),
                  child: Align(
                    alignment: Alignment.center,
                    child: Text(
                      e['name'],
                      style: TextStyle(
                        fontSize: 13,
                        color: activeTab == e['status']
                            ? ConstColor.whiteColor
                            : ConstColor.blackColor,
                      ),
                    ),
                  ),
                ),
              );
            }).toList(),
          ),
          // SizedBox(height: size.height * 0.03),
          Container(
            child: activeTab == "picks"
                ? _buildPicksView(size)
                : _buildPastView(size),
          )
        ],
      ),
    );
  }

  Widget _buildPastView(Size size) {
    return Consumer<AdvisorController>(builder: (context, value, child) {
      if (value.getAdvisorListModel.data == null) {
        return SizedBox(
          height: size.height * 0.618,
          child: const Center(child: CircularProgressIndicator()),
        );
      } else {
        advisorList = value.getAdvisorListModel.data;
        return GridView.builder(
          gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
            crossAxisCount: 2,
            childAspectRatio: 2 / 1.6,
          ),
          // padding: const EdgeInsets.only(bottom: 10),
          itemCount: advisorList!.length,
          shrinkWrap: true,
          physics: const NeverScrollableScrollPhysics(),
          itemBuilder: (context, index) {
            return GestureDetector(
              onTap: () async {
                final userResponse =
                    await advisorController.getAdvisorByIdController(
                        id: advisorList![index].id.toString());

                if (userResponse.status == 200) {
                  buildUserBottomSheet(
                    context: context,
                    advisorInfo: userResponse.data,
                  );
                }
              },
              // onTap: () {

              // buildUserBottomSheet(context, advisorList!, index);
              // },
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  ClipOval(
                    child: Image.network(
                      advisorList![index].picLoc,
                      height: 50,
                    ),
                  ),
                  SizedBox(height: size.height * 0.01),
                  Text(
                    advisorList![index].blinkxAdvisorName,
                    style: TextStyle(
                      color: ConstColor.violet42Color,
                      fontSize: size.height * 0.017,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                  Expanded(
                    child: Text(
                      "${advisorList![index].advisorDesignation}, ${advisorList![index].advisorTeam}",
                      // overflow: TextOverflow.ellipsis,
                      softWrap: true,
                      style: TextStyle(
                        color: ConstColor.blueD9Color,
                        fontSize: size.height * 0.014,
                        fontWeight: FontWeight.w400,
                      ),
                    ),
                  ),
                ],
              ),
            );
          },
        );
      }
    });
  }

  Widget _buildListView(Size size, int id) {
    if (advisorCallList == null) {
      return const SizedBox(
        // height: size.height * 0.618,
        child: Center(child: CircularProgressIndicator()),
      );
    } else {
// advisorCallList = value.getAdvisorCallModel.data!.advisoryResults;
      final filteredList =
          advisorCallList!.where((element) => element.advisorid == id).toList();
      if (filteredList.length > 0) {
        return SizedBox(
          height: size.height * 0.5,
          child: VisibilityDetector(
            key: UniqueKey(),
            onVisibilityChanged: (VisibilityInfo info) {
              // debugPrint(info.visibleFraction);
              if (info.visibleFraction == 1.0 &&
                  (preferences.getBool(Keys.animateSuperStarsXadvise) ??
                      true)) {
                Future.delayed(Duration(minutes: 00, milliseconds: 500), () {
                  // debugPrint("scroooled");
                  superStarsXadvise
                      .animateTo(
                    100,
                    duration: const Duration(milliseconds: 800),
                    curve: Curves.easeOut,
                  )
                      .then((value) async {
                    await superStarsXadvise.animateTo(
                      0,
                      duration: const Duration(milliseconds: 800),
                      curve: Curves.easeOut,
                    );
                    preferences.setBool(Keys.animateSuperStarsXadvise, false);
                  });
                  // superStarsController.jumpTo(superStarsController.position.pixels);
                });
              }
            },
            child: SingleChildScrollView(
              scrollDirection: Axis.horizontal,
              child: Row(children: [
                GridView.builder(
                  // controller: controllerList![index],
                  itemCount: 6,
                  shrinkWrap: true,
                  gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                    crossAxisCount: 1,
                    childAspectRatio: 2 / 1.7,
                  ),
                  scrollDirection: Axis.horizontal,
                  itemBuilder: (context, index) {
                    return StockCardView(
                      advisoryResults: filteredList[index],
                    );
                  },
                ),
                GestureDetector(
                  onTap: () {
                    Navigator.of(context).push(MaterialPageRoute(
                      builder: (context) => StockCallScreen(advisorId: ""),
                    ));
                  },
                  child: Container(
                    height: size.height * 0.975,
                    width: size.width * 0.25,
                    margin: const EdgeInsets.only(top: 20, bottom: 0),
                    decoration: BoxDecoration(
                      color: ConstColor.black29Color.withOpacity(0.1),
                      borderRadius: BorderRadius.circular(10),
                    ),
                    child: const Align(
                      alignment: Alignment.center,
                      child: Text(
                        'View All',
                        style: TextStyle(
                          color: ConstColor.black29Color,
                        ),
                      ),
                    ),
                  ),
                )
              ]),
            ),
          ),
        );
      } else {
        return SizedBox(
            height: size.height / 3.3,
            child: const Center(
              child: Text("No Data"),
            ));
      }
    }
    // return Consumer<GetAdvisorFilterController>(
    //     builder: (context, value, child) {
    //   if (value.getAdvisorCallModel.data == null) {

    //   } else {

    //   }
    // });
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

  // Widget _buildCardView(
  //     Size size, List<AdvisoryResults> filteredList, int index) {
  //   return Padding(
  //     padding: EdgeInsets.only(left: 0, top: size.height * 0.02),
  //     child: Container(
  //       width: size.width * 0.75,
  //       margin: EdgeInsets.only(right: 20),
  //       decoration: BoxDecoration(
  //           color: ConstColor.whiteColor,
  //           borderRadius: BorderRadius.circular(25),
  //           border: Border.all(color: Color(0xFFD6D6D6)),
  //           boxShadow: const [
  //             BoxShadow(
  //                 color: Colors.grey,
  //                 blurRadius: 10.0,
  //                 spreadRadius: 2.0,
  //                 offset: Offset(
  //                   8.0, // Move to right 7.0 horizontally
  //                   8.0, // Move to bottom 8.0 Vertically
  //                 )),
  //           ]),
  //       // elevation: 8,
  //       // shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(15)),
  //       child: Padding(
  //         padding: EdgeInsets.symmetric(horizontal: size.width * 0.06),
  //         child: Column(
  //           crossAxisAlignment: CrossAxisAlignment.start,
  //           children: [
  //             SizedBox(height: size.height * 0.02),
  //             Row(
  //               children: [
  //                 Expanded(
  //                   child: Text(
  //                     filteredList[index]
  //                         .jamoonData!
  //                         .symbolFormatted
  //                         .toString(),
  //                     softWrap: true,
  //                     style: TextStyle(
  //                       color: ConstColor.violet42Color,
  //                       fontSize: size.height * 0.02,
  //                       fontWeight: FontWeight.w600,
  //                     ),
  //                   ),
  //                 ),
  //                 SizedBox(width: size.width * 0.02),
  //                 Row(
  //                   children: [
  //                     Icon(
  //                       filteredList[index].jamoonData!.potentialData! > 0
  //                           ? Icons.keyboard_arrow_up_rounded
  //                           : Icons.keyboard_arrow_down_rounded,
  //                       color:
  //                           filteredList[index].jamoonData!.potentialData! > 0
  //                               ? ConstColor.greenColor75
  //                               : Colors.red,
  //                       size: size.height * 0.02,
  //                     ),
  //                     Text(
  //                       "(${filteredList[index].jamoonData!.potentialData!.toStringAsFixed(2)}%)",
  //                       style: TextStyle(
  //                         color:
  //                             filteredList[index].jamoonData!.potentialData! > 0
  //                                 ? ConstColor.greenColor75
  //                                 : Colors.red,
  //                         fontSize: size.height * 0.015,
  //                         fontWeight: FontWeight.w500,
  //                       ),
  //                     ),
  //                   ],
  //                 ),
  //               ],
  //             ),
  //             // Text(
  //             //   "${advisorCallList![index].callduration.toString()} - ${advisorList![index].status.toString()}", // ""advisorList![index].callduration,
  //             //   style: TextStyle(
  //             //     color: ConstColor.violet42Color,
  //             //     fontSize: size.height * 0.014,
  //             //     fontWeight: FontWeight.w400,
  //             //   ),
  //             // ),
  //             Text(
  //               "by ${filteredList[index].jamoonData?.advisor ?? ''}",
  //               style: TextStyle(
  //                 color: ConstColor.violet42Color,
  //                 fontSize: size.height * 0.014,
  //                 fontWeight: FontWeight.w400,
  //               ),
  //             ),
  //             SizedBox(height: size.height * 0.02),
  //             Row(
  //               mainAxisAlignment: MainAxisAlignment.spaceBetween,
  //               children: [
  //                 callDetailPill(
  //                   size,
  //                   "Category",
  //                   filteredList[index].callcategory.toString(),
  //                 ),
  //                 callDetailPill(
  //                   size,
  //                   "Suitable For",
  //                   filteredList[index].callCategoryText.toString(),
  //                 ),
  //                 callDetailPill(
  //                   size,
  //                   "Duration",
  //                   duartionList.firstWhere((element) =>
  //                       element['type'] ==
  //                       filteredList[index].callduration)['name'],
  //                 ),
  //               ],
  //             ),
  //             SizedBox(height: size.height * 0.015),
  //             Row(
  //               mainAxisAlignment: MainAxisAlignment.spaceBetween,
  //               children: [
  //                 callDetailPill(
  //                   size,
  //                   "Expiry Date",
  //                   filteredList[index]
  //                       .jamoonData!
  //                       .contractexpiry
  //                       .toString()
  //                       .split(" ")[0],
  //                 ),
  //                 callDetailPill(
  //                   size,
  //                   "Days left",
  //                   "${filteredList[index].jamoonData!.daysLeft} days",
  //                 ),
  //                 filteredList[index].jamoonData!.callPutText == ""
  //                     ? SizedBox(
  //                         width: ww() / 10,
  //                       )
  //                     : callDetailPill(
  //                         size,
  //                         "Call/Put",
  //                         filteredList[index]
  //                             .jamoonData!
  //                             .callPutText
  //                             .toString(),
  //                       ),
  //               ],
  //             ),
  //             SizedBox(height: size.height * 0.03),
  //             GestureDetector(
  //               onTap: () {
  //                 Navigator.push(
  //                   context,
  //                   MaterialPageRoute(
  //                     builder: (context) => const BuyStockScreen(),
  //                   ),
  //                 );
  //               },
  //               child: Container(
  //                 decoration: BoxDecoration(
  //                   color: Color(0xFFEB4954).withOpacity(0.6),
  //                   borderRadius: BorderRadius.circular(20),
  //                 ),
  //                 padding:
  //                     const EdgeInsets.symmetric(vertical: 10, horizontal: 20),
  //                 child: Row(
  //                   mainAxisAlignment: MainAxisAlignment.spaceBetween,
  //                   children: [
  //                     Text(
  //                       "Buy Now",
  //                       style: TextStyle(
  //                         color: ConstColor.whiteColor,
  //                       ),
  //                     ),
  //                     Icon(
  //                       Icons.chevron_right,
  //                       size: 28,
  //                       color: ConstColor.whiteColor,
  //                     )
  //                   ],
  //                 ),
  //               ),
  //             ),
  //           ],
  //         ),
  //       ),
  //     ),
  //   );
  // }

  // Widget _buildCardView(Size size, int index) {
  //   return Padding(
  //     padding:
  //         EdgeInsets.only(left: size.width * 0.02, top: size.height * 0.02),
  //     child: Card(
  //       elevation: 8,
  //       shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(15)),
  //       child: Padding(
  //         padding: EdgeInsets.symmetric(horizontal: size.width * 0.06),
  //         child: Column(
  //           crossAxisAlignment: CrossAxisAlignment.start,
  //           children: [
  //             SizedBox(height: size.height * 0.02),
  //             Row(
  //               children: [
  //                 Text(
  //                   'BOSCHLTD',
  //                   style: TextStyle(
  //                     color: ConstColor.violet42Color,
  //                     fontSize: size.height * 0.02,
  //                     fontWeight: FontWeight.w600,
  //                   ),
  //                 ),
  //                 SizedBox(width: size.width * 0.02),
  //                 Row(
  //                   children: [
  //                     Icon(
  //                       Icons.keyboard_arrow_up_rounded,
  //                       color: ConstColor.greenColor75,
  //                       size: size.height * 0.02,
  //                     ),
  //                     Text(
  //                       '(14.21%)',
  //                       style: TextStyle(
  //                         color: ConstColor.greenColor75,
  //                         fontSize: size.height * 0.015,
  //                         fontWeight: FontWeight.w500,
  //                       ),
  //                     ),
  //                   ],
  //                 ),
  //               ],
  //             ),
  //             Text(
  //               'Bosch Limited',
  //               style: TextStyle(
  //                 color: ConstColor.violet42Color,
  //                 fontSize: size.height * 0.014,
  //                 fontWeight: FontWeight.w400,
  //               ),
  //             ),
  //             SizedBox(height: size.height * 0.015),
  //             Row(
  //               children: [
  //                 Column(
  //                   crossAxisAlignment: CrossAxisAlignment.start,
  //                   children: [
  //                     Text(
  //                       'Enter',
  //                       style: TextStyle(
  //                         color: ConstColor.black29Color,
  //                         fontSize: size.height * 0.015,
  //                         fontWeight: FontWeight.w400,
  //                       ),
  //                     ),
  //                     const SizedBox(height: 5),
  //                     Text(
  //                       '\u{20B9} 10,0000',
  //                       style: TextStyle(
  //                         color: ConstColor.black29Color,
  //                         fontSize: size.height * 0.025,
  //                         fontWeight: FontWeight.w600,
  //                       ),
  //                     ),
  //                   ],
  //                 ),
  //                 SizedBox(width: size.width * 0.1),
  //                 Column(
  //                   crossAxisAlignment: CrossAxisAlignment.start,
  //                   children: [
  //                     Text(
  //                       'Target Price',
  //                       style: TextStyle(
  //                         color: ConstColor.black29Color,
  //                         fontSize: size.height * 0.015,
  //                         fontWeight: FontWeight.w400,
  //                       ),
  //                     ),
  //                     SizedBox(height: 5),
  //                     Text(
  //                       '\u{20B9} 10,0000',
  //                       style: TextStyle(
  //                         color: ConstColor.blueFEColor,
  //                         fontSize: size.height * 0.025,
  //                         fontWeight: FontWeight.w600,
  //                       ),
  //                     ),
  //                   ],
  //                 ),
  //               ],
  //             ),
  //             SizedBox(height: size.height * 0.015),
  //             Row(
  //               children: [
  //                 Column(
  //                   crossAxisAlignment: CrossAxisAlignment.start,
  //                   children: [
  //                     Text(
  //                       'Enter',
  //                       style: TextStyle(
  //                         color: ConstColor.black29Color,
  //                         fontSize: size.height * 0.015,
  //                         fontWeight: FontWeight.w400,
  //                       ),
  //                     ),
  //                     const SizedBox(height: 5),
  //                     Text(
  //                       '\u{20B9} 10,0000',
  //                       style: TextStyle(
  //                         color: ConstColor.black29Color,
  //                         fontSize: size.height * 0.025,
  //                         fontWeight: FontWeight.w600,
  //                       ),
  //                     ),
  //                   ],
  //                 ),
  //                 SizedBox(width: size.width * 0.1),
  //                 Column(
  //                   crossAxisAlignment: CrossAxisAlignment.start,
  //                   children: [
  //                     Text(
  //                       'Target Price',
  //                       style: TextStyle(
  //                         color: ConstColor.black29Color,
  //                         fontSize: size.height * 0.015,
  //                         fontWeight: FontWeight.w400,
  //                       ),
  //                     ),
  //                     SizedBox(height: 5),
  //                     Text(
  //                       '\u{20B9} 10,0000',
  //                       style: TextStyle(
  //                         color: ConstColor.blueFEColor,
  //                         fontSize: size.height * 0.025,
  //                         fontWeight: FontWeight.w600,
  //                       ),
  //                     ),
  //                   ],
  //                 ),
  //               ],
  //             ),
  //             SizedBox(height: size.height * 0.03),
  //             SliderButton(
  //               height: 60,
  //               buttonColor: ConstColor.whiteColor,
  //               action: () {},
  //               label: Text(
  //                 "Slide to cancel Event",
  //                 style: TextStyle(
  //                   color: Color(0xff4a4a4a),
  //                   fontWeight: FontWeight.w500,
  //                   fontSize: size.height * 0.018,
  //                 ),
  //               ),
  //               buttonSize: size.height * 0.06,
  //               shimmer: false,
  //               icon: Icon(
  //                 Icons.arrow_forward_ios_rounded,
  //                 color: ConstColor.black29Color,
  //               ),
  //             )
  //           ],
  //         ),
  //       ),
  //     ),
  //   );
  // }
}
