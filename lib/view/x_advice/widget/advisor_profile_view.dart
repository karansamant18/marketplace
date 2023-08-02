import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_mobile_bx/const/color.dart';
import 'package:flutter_mobile_bx/const/keys.dart';
import 'package:flutter_mobile_bx/helpers/sizes.dart';
import 'package:flutter_mobile_bx/view/stock_detail/view/stock_call_sceen.dart';
import 'package:flutter_mobile_bx/view/x_advice/controller/advisor_controller.dart';
import 'package:flutter_mobile_bx/view/x_advice/model/follow_advisor_list_model.dart';
import 'package:flutter_mobile_bx/view/x_advice/model/get_advisor_model.dart';
import 'package:provider/provider.dart';

import '../../../widgets/bottom_modal.dart';

class AdvisorProfileView extends StatefulWidget {
  AdvisorProfileView({super.key, required this.advisorInfo});

  final GetAdvisorListModel? advisorInfo;

  @override
  State<AdvisorProfileView> createState() => _AdvisorProfileViewState();
}

class _AdvisorProfileViewState extends State<AdvisorProfileView> {
  bool followed = false;
  AdvisorController advisorController = AdvisorController();
  List<FollowAdvisorList>? followAdvisorList;
  FollowAdvisorList? followedAdvisor;

  @override
  void initState() {
    super.initState();
    advisorController = Provider.of<AdvisorController>(context, listen: false);
    fetchAdvisorList();
  }

  fetchAdvisorList() {
    if (advisorController.followAdvisorList.data == null ||
        advisorController.followAdvisorList.data!.isEmpty) {
      advisorController.getFollowAdvisorController().then((value) {
        debugPrint("follow advisor list fetched");
        followAdvisorList = value.data!;
        checkFollowStatus();
      });
    } else {
      followAdvisorList = advisorController.followAdvisorList.data!;
      checkFollowStatus();
    }
  }

  checkFollowStatus() {
    followAdvisorList!.forEach((element) {
      if (element.advisorId.toString() == widget.advisorInfo!.id.toString()) {
        debugPrint("advisor found");
        followedAdvisor = element;
        if (mounted) {
          setState(() {
            followed = true;
          });
        }
      }
    });
  }

  followUnfollowAdvisor() {
    dynamic bodyData = {
      "id": followed == true ? followedAdvisor!.id : 0,
      "advisorId": widget.advisorInfo!.id,
      // "userId": 4,
      "userId": int.parse(preferences.getString(Keys.userId).toString()),
      "followStatus": followed == true ? 0 : 1
    };
    advisorController.followAdvisorController(body: bodyData).then((value) {
      if (value.data!.followStatus == 0) {
        setState(() {
          followed = false;
        });
      } else {
        setState(() {
          followed = true;
        });
      }
      advisorController.followAdvisorList.data = null;
      fetchAdvisorList();
    });
  }

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Expanded(
      child: SingleChildScrollView(
        child: Container(
          color: ConstColor.black42Color,
          child: Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // SizedBox(height: size.height * 0.02),
              // Center(
              //   child: Container(
              //     width: size.width * 0.1,
              //     height: 5,
              //     decoration: BoxDecoration(
              //       color: ConstColor.greyColor,
              //       borderRadius: BorderRadius.circular(15),
              //     ),
              //   ),
              // ),
              // SizedBox(height: size.height * 0.03),
              Row(
                children: [
                  CachedNetworkImage(
                    imageUrl: widget.advisorInfo?.picLoc ?? '',
                    imageBuilder: (context, imageProvider) => Container(
                      width: size.height * 0.1,
                      height: size.height * 0.1,
                      decoration: BoxDecoration(
                        shape: BoxShape.circle,
                        image: DecorationImage(
                            image: imageProvider, fit: BoxFit.cover),
                      ),
                    ),
                    placeholder: (context, url) => CircularProgressIndicator(),
                    errorWidget: (context, url, error) => Icon(Icons.error),
                  ),
                ],
              ),
              SizedBox(height: size.height * 0.01),
              Text(
                widget.advisorInfo?.blinkxAdvisorName ?? '',
                style: TextStyle(
                  color: ConstColor.whiteColor,
                  fontSize: size.height * 0.023,
                  fontWeight: FontWeight.w600,
                ),
              ),
              SizedBox(height: size.height * 0.015),
              Text(
                widget.advisorInfo?.advisorDesignation ?? '',
                style: TextStyle(
                  color: ConstColor.whiteColor.withOpacity(0.7),
                  fontSize: size.height * 0.017,
                  fontWeight: FontWeight.w400,
                ),
              ),
              Text(
                widget.advisorInfo?.advisorTeam ?? '',
                style: TextStyle(
                  color: ConstColor.whiteColor.withOpacity(0.7),
                  fontSize: size.height * 0.017,
                  fontWeight: FontWeight.w400,
                ),
              ),
              SizedBox(height: size.height * 0.03),
              _buildButtonView(size, widget.advisorInfo),
              SizedBox(height: size.height * 0.03),
              Text(
                'About ${widget.advisorInfo?.blinkxAdvisorName}',
                style: TextStyle(
                  color: ConstColor.whiteColor,
                  fontSize: size.height * 0.017,
                  fontWeight: FontWeight.bold,
                ),
              ),
              SizedBox(height: size.height * 0.01),
              Text(
                widget.advisorInfo?.about ?? '',
                style: TextStyle(
                  color: ConstColor.whiteColor.withOpacity(0.7),
                  fontSize: size.height * 0.017,
                  fontWeight: FontWeight.w400,
                ),
              ),
              SizedBox(height: size.height * 0.03),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildButtonView(Size size, GetAdvisorListModel? advisorInfo) {
    return Row(
      children: [
        Expanded(
          child: GestureDetector(
            onTap: () {
              followUnfollowAdvisor();
            },
            child: Container(
              decoration: followed == false
                  ? BoxDecoration(
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
                    )
                  : BoxDecoration(
                      color: null,
                      borderRadius: BorderRadius.circular(25),
                      border: Border.all(
                        color: ConstColor.whiteColor,
                      )),
              padding: EdgeInsets.symmetric(
                  horizontal: size.width * 0.05, vertical: size.height * 0.012),
              child: Text(
                followed == true ? "Unfollow" : "Follow",
                textAlign: TextAlign.center,
                style: TextStyle(
                  color: ConstColor.whiteColor,
                  fontSize: size.height * 0.018,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
          ),
        ),
        SizedBox(width: size.width * 0.05),
        Expanded(
          child: GestureDetector(
            onTap: () {
              Navigator.of(context).push(MaterialPageRoute(
                builder: (context) =>
                    StockCallScreen(advisorId: advisorInfo!.blinkxAdvisorId),
              ));
            },
            child: Container(
              decoration: BoxDecoration(
                border: Border.all(color: ConstColor.whiteColor),
                borderRadius: BorderRadius.circular(30),
              ),
              padding: EdgeInsets.symmetric(
                  horizontal: size.width * 0.05, vertical: size.height * 0.012),
              child: Text(
                "View Calls",
                textAlign: TextAlign.center,
                style: TextStyle(
                  color: ConstColor.whiteColor,
                  fontSize: size.height * 0.018,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
          ),
        )
      ],
    );
  }
}

Future<void> buildUserBottomSheet(
    {required BuildContext context, GetAdvisorListModel? advisorInfo}) async {
  await CommonDialogs.bottomDialogWithHeight(
    AdvisorProfileView(advisorInfo: advisorInfo),
    height: hh() / 1.5,
    color: ConstColor.black42Color,
  );
}
