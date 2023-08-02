import 'package:flutter/material.dart';
import 'package:flutter_mobile_bx/const/color.dart';
import 'package:flutter_mobile_bx/view/x_advice/model/get_advisor_call_model.dart';
import 'package:flutter_mobile_bx/view/stock_card/stock_card_view.dart';
import 'package:flutter_mobile_bx/view/stock_detail/view/stock_call_sceen.dart';
import 'package:flutter_mobile_bx/websocket/web_socket.dart';

class ResearchView extends StatefulWidget {
  final List<AdvisoryResults>? advisoryResults;
  const ResearchView({super.key, required this.advisoryResults});

  @override
  State<ResearchView> createState() => _ResearchViewState();
}

class _ResearchViewState extends State<ResearchView> {
  late ScrollController scrollController;
  bool isEnd = false;
  @override
  void initState() {
    CommonSocket().subscribeTokens(widget.advisoryResults ?? []);
    socketConnectSub.stream.listen((event) {
      if (event == true) {
        CommonSocket().subscribeTokens(widget.advisoryResults ?? []);
      }
    });
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
    super.initState();
  }

  @override
  void didUpdateWidget(covariant ResearchView oldWidget) {
    // TODO: implement didUpdateWidget
    super.didUpdateWidget(oldWidget);
  }

  // @override
  // void didUpdateWidget(covariant ResearchView oldWidget) {
  //   super.didUpdateWidget(oldWidget);
  //   CommonSocket().unsubscribeTokens(oldWidget.advisoryResults ?? []);
  //   debugPrint("unsubscribed");
  //   CommonSocket().subscribeTokens(widget.advisoryResults ?? []);
  // }

  @override
  void dispose() {
    super.dispose();
    debugPrint("unsubscribing research home...");
    CommonSocket().unsubscribeTokens(widget.advisoryResults ?? []);
  }

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;

    return Container(
      decoration: BoxDecoration(
        color: ConstColor.whiteColor,
        borderRadius: BorderRadius.only(
          topLeft: Radius.circular(size.width * 0.07),
          topRight: Radius.circular(size.width * 0.07),
        ),
      ),
      width: size.width,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          SizedBox(height: size.height * 0.04),
          Container(
            decoration: const BoxDecoration(
              color: ConstColor.blueD9Color,
              borderRadius: BorderRadius.horizontal(
                right: Radius.circular(50),
              ),
            ),
            padding: EdgeInsets.symmetric(
              horizontal: size.width * 0.07,
              vertical: 6,
            ),
            child: Text(
              'Research Calls',
              style: TextStyle(
                letterSpacing: 4,
                color: ConstColor.whiteColor,
                fontSize: size.height * 0.02,
                fontWeight: FontWeight.bold,
              ),
            ),
          ),
          SizedBox(height: size.height * 0.02),
          Container(
            padding: EdgeInsets.symmetric(horizontal: size.width * 0.07),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  'Our research, your \nwindfall!',
                  style: TextStyle(
                    color: ConstColor.violet61Color,
                    fontSize: size.height * 0.035,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                SizedBox(height: size.height * 0.025),
                Text(
                  "Find out what's going up or down \nbefore you make your investment.",
                  style: TextStyle(
                    color: ConstColor.violet61Color.withOpacity(0.7),
                    fontSize: size.height * 0.017,
                    fontWeight: FontWeight.w600,
                  ),
                ),
              ],
            ),
          ),
          SizedBox(height: size.height * 0.02),
          Container(
            width: size.width,
            decoration: BoxDecoration(
              gradient: const LinearGradient(
                begin: Alignment.topLeft,
                end: Alignment.bottomRight,
                colors: [
                  Color(0xFFE13662),
                  Color(0xffEB4954),
                  ConstColor.violetF0Color,
                ],
              ),
              borderRadius: BorderRadius.only(
                topLeft: Radius.circular(size.height * 0.02),
                topRight: Radius.circular(size.height * 0.02),
              ),
            ),
            padding: EdgeInsets.only(top: size.height * 0.03),
            child: Column(
              children: [
                SizedBox(
                  height: size.height * 0.5,
                  child: Stack(
                    children: [
                      GridView.builder(
                        itemCount: widget.advisoryResults?.length,
                        padding: EdgeInsets.only(right: 150),
                        scrollDirection: Axis.horizontal,
                        controller: scrollController,
                        gridDelegate:
                            const SliverGridDelegateWithFixedCrossAxisCount(
                          childAspectRatio: 2 / 1.7,
                          crossAxisCount: 1,
                        ),
                        itemBuilder: (context, index) {
                          return StockCardView(
                            advisoryResults: widget.advisoryResults![index],
                          );
                        },
                      ),
                      isEnd == true
                          ? Positioned(
                              right: 20,
                              child: GestureDetector(
                                onTap: () {
                                  Navigator.of(context).push(MaterialPageRoute(
                                    builder: (context) =>
                                        StockCallScreen(advisorId: ""),
                                  ));
                                },
                                child: Container(
                                  height: size.height * 0.475,
                                  width: size.width * 0.25,
                                  margin: const EdgeInsets.only(top: 20),
                                  decoration: BoxDecoration(
                                    color: Colors.white.withOpacity(0.1),
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
                ),
                SizedBox(height: size.height * 0.025),
                Padding(
                  padding: EdgeInsets.symmetric(horizontal: size.width * 0.05),
                  child: Column(
                    children: [
                      const Divider(
                        color: ConstColor.whiteColor,
                        thickness: 1,
                      ),
                      // SizedBox(height: size.height * 0.02),
                      GestureDetector(
                        onTap: () {
                          Navigator.of(context).push(MaterialPageRoute(
                            builder: (context) =>
                                StockCallScreen(advisorId: ""),
                          ));
                        },
                        child: Container(
                          decoration: const BoxDecoration(
                            color: null,
                          ),
                          width: size.width,
                          height: size.height * 0.07,
                          // color: ConstColor.black29Color,
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
                      )
                    ],
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
