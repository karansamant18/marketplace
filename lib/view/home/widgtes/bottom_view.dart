import 'dart:async';

import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_mobile_bx/const/color.dart';
import 'package:flutter_mobile_bx/const/keys.dart';
import 'package:flutter_mobile_bx/view/x_advice/widget/advisor_profile_view.dart';
import 'package:flutter_mobile_bx/view/x_advice/controller/advisor_controller.dart';
import 'package:flutter_mobile_bx/view/x_advice/model/get_advisor_model.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:provider/provider.dart';
import 'package:visibility_detector/visibility_detector.dart';

import '../controller/home_cotroller.dart';

class BottomView extends StatefulWidget {
  final List<GetAdvisorListModel>? getAdvisorList;
  const BottomView({super.key, required this.getAdvisorList});

  @override
  State<BottomView> createState() => _BottomViewState();
}

class _BottomViewState extends State<BottomView> {
  AdvisorController advisorController = AdvisorController();
  late ScrollController superStarsController;
  late HomeController homeController;

  @override
  void initState() {
    // TODO: implement initState
    superStarsController = ScrollController();
    homeController = Provider.of<HomeController>(context, listen: false);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Container(
      width: size.width,
      color: ConstColor.blackColor,
      child: Padding(
        padding: EdgeInsets.symmetric(vertical: size.height * 0.03),
        child: Column(
          children: [
            // SvgPicture.asset(
            //   ConstImage.flashIcon,
            //   color: ConstColor.pink62Color,
            //   height: size.height * 0.025,
            // ),
            // SizedBox(height: size.height * 0.015),
            Row(
              children: [
                Expanded(
                  child: Container(
                    // color: ConstColor.whiteColor,
                    child: SvgPicture.asset(
                      'assets/image/svg/home_bottom.svg',
                    ),
                  ),
                ),
                Container(
                  width: size.width * 0.05,
                  color: ConstColor.blackColor,
                )
              ],
            ),
            // GradientText(
            //   'blinkx super stars'.toUpperCase(),
            //   style: TextStyle(
            //     fontSize: size.height * 0.023,
            //     fontWeight: FontWeight.bold,
            //   ),
            //   gradient: const LinearGradient(
            //     colors: [
            //       ConstColor.pink62Color,
            //       ConstColor.lightOrange,
            //       ConstColor.violetF0Color
            //     ],
            //   ),
            // ),
            SizedBox(height: size.height * 0.025),
            Text(
              'The high, the mighty \n& the famous.',
              textAlign: TextAlign.center,
              style: TextStyle(
                color: ConstColor.whiteColor,
                fontSize: size.height * 0.03,
                fontWeight: FontWeight.bold,
              ),
            ),
            SizedBox(height: size.height * 0.025),
            Text(
              'Simply follow these kings of finance \nas they lead you to success!',
              textAlign: TextAlign.center,
              style: TextStyle(
                color: ConstColor.whiteColor.withOpacity(0.7),
                fontSize: size.height * 0.015,
                fontWeight: FontWeight.w500,
              ),
            ),
            SizedBox(height: size.height * 0.03),
            _buildListView(size),
            _buildButtonView(
              context: context,
              onTap: () {
                homeController.updateFromExplore(true);
                homeController.updateBottomSelectedIndex(1);
                // Navigator.of(context).push(MaterialPageRoute(
                //   builder: (context) => XAdviceScreen(fromExplore: true),
                // ));
              },
              size: size,
              title: 'Explore',
            ),
            SizedBox(height: size.height * 0.1),
          ],
        ),
      ),
    );
  }

  Widget _buildListView(Size size) {
    return SizedBox(
      height: size.height / 3.3,
      child: VisibilityDetector(
        key: UniqueKey(),
        onVisibilityChanged: (VisibilityInfo info) {
          // debugPrint(info.visibleFraction);

          if (info.visibleFraction == 1.0 &&
              (preferences.getBool(Keys.animateSuperStarsScroll) ?? true)) {
            Future.delayed(Duration(minutes: 00, milliseconds: 500), () {
              // debugPrint("scroooled");
              superStarsController
                  .animateTo(
                100,
                duration: const Duration(milliseconds: 800),
                curve: Curves.easeOut,
              )
                  .then((value) async {
                await superStarsController.animateTo(
                  0,
                  duration: const Duration(milliseconds: 800),
                  curve: Curves.easeOut,
                );

                preferences.setBool(Keys.animateSuperStarsScroll, false);
              });
              // superStarsController.jumpTo(superStarsController.position.pixels);
            });
          }
        },
        child: ListView.builder(
          controller: superStarsController,
          itemCount: widget.getAdvisorList?.length,
          shrinkWrap: true,
          scrollDirection: Axis.horizontal,
          itemBuilder: (context, index) {
            var advisorData = widget.getAdvisorList?[index];
            return Padding(
              padding: EdgeInsets.symmetric(horizontal: size.width * 0.05),
              child: GestureDetector(
                onTap: () async {
                  final userResponse =
                      await advisorController.getAdvisorByIdController(
                          id: advisorData?.id.toString() ?? '');

                  if (userResponse.status == 200) {
                    buildUserBottomSheet(
                      context: context,
                      advisorInfo: userResponse.data,
                    );
                  }
                },
                child: Column(
                  children: [
                    SizedBox(height: size.height * 0.02),
                    CachedNetworkImage(
                      imageUrl: advisorData?.picLoc ?? '',
                      imageBuilder: (context, imageProvider) => Container(
                        width: size.height * 0.1,
                        height: size.height * 0.1,
                        decoration: BoxDecoration(
                          shape: BoxShape.circle,
                          image: DecorationImage(
                              image: imageProvider, fit: BoxFit.cover),
                        ),
                      ),
                      placeholder: (context, url) =>
                          CircularProgressIndicator(),
                      errorWidget: (context, url, error) => Icon(Icons.error),
                    ),
                    SizedBox(height: size.height * 0.02),
                    Text(
                      "${advisorData?.blinkxAdvisorName ?? ''}",
                      style: TextStyle(
                        color: ConstColor.whiteColor,
                        fontSize: size.height * 0.02,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                    SizedBox(height: size.height * 0.01),
                    SizedBox(
                      width: size.width * 0.35,
                      child: Text(
                        advisorData?.advisorDesignation ?? '',
                        textAlign: TextAlign.center,
                        style: TextStyle(
                          color: ConstColor.whiteColor.withOpacity(0.7),
                          fontSize: size.height * 0.013,
                          fontWeight: FontWeight.w500,
                        ),
                      ),
                    ),
                    SizedBox(height: 2),
                    SizedBox(
                      width: size.width * 0.35,
                      child: Text(
                        advisorData?.advisorTeam ?? '',
                        textAlign: TextAlign.center,
                        style: TextStyle(
                          color: ConstColor.whiteColor.withOpacity(0.7),
                          fontSize: size.height * 0.013,
                          fontWeight: FontWeight.w500,
                        ),
                      ),
                    )
                  ],
                ),
              ),
            );
          },
        ),
      ),
    );
  }

  Widget _buildButtonView({
    required BuildContext context,
    required Size size,
    required String title,
    required void Function() onTap,
  }) {
    return Center(
      child: GestureDetector(
        onTap: onTap,
        child: Container(
          width: size.width / 2.7,
          decoration: BoxDecoration(
            gradient: const LinearGradient(
              begin: Alignment.topLeft,
              end: Alignment.bottomRight,
              colors: [
                ConstColor.pink62Color,
                ConstColor.lightOrange,
                ConstColor.violetF0Color
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
              const SizedBox(),
              Text(
                title,
                style: TextStyle(
                  color: ConstColor.whiteColor,
                  fontSize: size.height * 0.018,
                  fontWeight: FontWeight.bold,
                ),
              ),
              const Icon(
                Icons.arrow_forward_ios_rounded,
                color: ConstColor.whiteColor,
              )
            ],
          ),
        ),
      ),
    );
  }
}
