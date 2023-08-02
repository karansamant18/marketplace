import 'package:flutter/material.dart';
import 'package:flutter_mobile_bx/const/color.dart';
import 'package:flutter_mobile_bx/const/image.dart';
import 'package:flutter_mobile_bx/const/keys.dart';
import 'package:flutter_mobile_bx/helpers/navigation_context.dart';
import 'package:flutter_mobile_bx/helpers/sizes.dart';
import 'package:flutter_mobile_bx/helpers/user_auth.dart';
import 'package:flutter_mobile_bx/view/blinkx_login/blinkx_login.dart';
import 'package:flutter_mobile_bx/view/blinkx_profile/controller/blinkx_user_controller.dart';
import 'package:flutter_mobile_bx/view/bottom_bar.dart';
import 'package:flutter_mobile_bx/view/home/controller/home_cotroller.dart';
import 'package:flutter_mobile_bx/view/home/model/home_quote_model.dart';
import 'package:flutter_mobile_bx/view/home/widgtes/bottom_view.dart';
import 'package:flutter_mobile_bx/view/home/widgtes/header_card_view.dart';
import 'package:flutter_mobile_bx/view/home/widgtes/research_view.dart';
import 'package:flutter_mobile_bx/view/home/widgtes/my_portfolio_card.dart';
import 'package:flutter_mobile_bx/view/user_profile/model/is_jm_client_model.dart';
import 'package:flutter_mobile_bx/helpers/user_model.dart';
import 'package:flutter_mobile_bx/view/user_profile/controller/user_profile_controller.dart';
import 'package:flutter_mobile_bx/view/user_profile/model/user_profile_model.dart';
import 'package:flutter_mobile_bx/view/x_advice/controller/advisor_controller.dart';
import 'package:flutter_mobile_bx/view/x_advice/model/get_advisor_call_model.dart';
import 'package:flutter_mobile_bx/widgets/bottom_modal.dart';
import 'package:flutter_mobile_bx/widgets/common_buttons.dart';
import 'package:flutter_mobile_bx/widgets/marquee/marquee.dart';
import 'package:provider/provider.dart';
import 'package:webviewx/webviewx.dart';

import '../../websocket/web_socket.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  HomeController homeController = HomeController();
  AdvisorController advisorController = AdvisorController();
  BlinkxUserController blinkxUserController = BlinkxUserController();

  UserProfileController userProfileController = UserProfileController();
  ResponseModel<IsJmClientModel> isJmClientModel =
      ResponseModel<IsJmClientModel>();
  ResponseModel<UserProfileModel> userModel = ResponseModel<UserProfileModel>();
  bool portfoliIsVisibe = false;

  List<HomeQuoteModel>? quoteData;
  List<AdvisoryResults>? quoteList;

  @override
  void initState() {
    super.initState();
    homeController = Provider.of<HomeController>(context, listen: false);
    advisorController = Provider.of<AdvisorController>(context, listen: false);
    userProfileController =
        Provider.of<UserProfileController>(context, listen: false);
    blinkxUserController =
        Provider.of<BlinkxUserController>(context, listen: false);
    Future.wait([
      blinkxUserController.userProfileSink(),
      homeController.getQuoteController().then((value) {
        quoteData = value.data;
        quoteList = [];
        quoteData!.forEach((quote) {
          quoteList!.add(AdvisoryResults(
            secToken: quote.symphonyToken,
            isCash: true,
          ));
        });
        CommonSocket().subscribeTokens(quoteList ?? []);
        socketConnectSub.stream.listen((event) {
          if (event == true) {
            CommonSocket().subscribeTokens(quoteList ?? []);
          }
        });
      }),
      advisorController.advisorCallsListController(filters: [
        {
          "operator": "eq",
          "values": ["open"],
          "field": "status"
        },
      ]),
      advisorController.getAdvisorListController(),
      advisorController.getFollowAdvisorController(),
      homeController.generateAccessTokenInitial(),
      getUserProfileData(),
    ]);
    connectSocket();
  }

  @override
  void dispose() {
    super.dispose();
    CommonSocket().unsubscribeTokens(quoteList ?? []);
  }

  Future<dynamic> getUserProfileData() async {
    userModel = await userProfileController.jmUserProfileController();
    if (userModel.status == 200) {
      isJmClientModel = await userProfileController.getDetailspApiController(
          phoneNo: preferences.getString(Keys.userPhoneNo) ?? '');
      if (isJmClientModel.data != null) {
        return isJmClientModel;
      } else {
        return isJmClientModel;
      }
    } else {
      isJmClientModel = await userProfileController.getDetailspApiController(
          phoneNo: preferences.getString(Keys.userPhoneNo) ?? '');
      if (isJmClientModel.status == 401) {
        CommonDialogs.bottomDialog(
          WillPopScope(
            onWillPop: () async {
              Navigator.pop(Navigation().context);
              Navigator.pop(Navigation().context);
              return true;
            },
            child: Expanded(
              child: BlinkxLogin(
                nextPage: BottomBarScreen(),
              ),
            ),
          ),
          height: UserAuth().isJmClient() ? hh() / 2 : hh() / 1.5,
        );
      } else {
        return isJmClientModel;
      }
    }
  }

  connectSocket() {
    CommonSocket().advisiorySocket();
    tokenSetStream.listen((event) {
      if (event == true) {
        CommonSocket().advisiorySocket();
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Scaffold(
      backgroundColor: ConstColor.violetF0Color,
      body: SingleChildScrollView(
        child: Consumer<AdvisorController>(
          builder: (context, advisorCallValue, child) {
            final results = advisorCallValue.advisorCallListModel.data;
            return Column(
              children: [
                Container(
                  decoration: const BoxDecoration(
                    gradient: LinearGradient(
                      begin: Alignment.topLeft,
                      end: Alignment.bottomRight,
                      colors: [
                        Color(0xFFE13662),
                        Color(0xffEB4954),
                        ConstColor.violetF0Color,
                      ],
                    ),
                  ),
                  child: Column(
                    children: [
                      Container(
                        padding: const EdgeInsets.only(top: 20),
                        width: size.width,
                        color: const Color(0xFF3B1F42),
                        height: size.height / 12,
                        child: quoteData == null
                            ? Container()
                            : Marquee(quoteModel: quoteData),
                      ),
                      (results != null)
                          ? HeaderCardView(
                              getAdvisorCallsModel: results,
                            )
                          : SizedBox(
                              height: size.height * 1,
                            ),
                      Consumer<UserProfileController>(
                          builder: (context, advisorCallValue, child) {
                        return Container(
                          padding: const EdgeInsets.only(bottom: 20),
                          child: UserAuth().isJmClient()
                              ? UserAuth().isLoggedInBlinkX()
                                  ? Padding(
                                      padding: EdgeInsets.symmetric(
                                        horizontal: size.width * 0.05,
                                      ),
                                      // child: Container(),
                                      child: const MyPortfolioCard(),
                                    )
                                  : jmClientView(size)
                              : nonJmClientView(size),
                        );
                      }),
                    ],
                  ),
                ),
                (results != null)
                    ? Container(
                        color: ConstColor.violetF0Color,
                        child: ResearchView(
                            advisoryResults: results.advisoryResults!
                                .sublist(
                                    0,
                                    results.advisoryResults!.length < 6
                                        ? results.advisoryResults!.length
                                        : 6)
                                .toList()),
                      )
                    : SizedBox(
                        height: size.height * 0.8,
                      ),
                advisorCallValue.getAdvisorListModel.data != null
                    ? BottomView(
                        getAdvisorList:
                            advisorCallValue.getAdvisorListModel.data,
                      )
                    : SizedBox(height: size.height * 0.5),
              ],
            );
          },
        ),
      ),
    );
  }

  Widget nonJmClientView(Size size) {
    return Padding(
      padding: EdgeInsets.symmetric(
        horizontal: size.width * 0.05,
      ),
      child: Container(
        width: size.width,
        height: size.height / 3.5,
        decoration: BoxDecoration(
            color: Color.fromARGB(151, 0, 0, 0),
            borderRadius: BorderRadius.circular(15)),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: [
            // Icon(
            //   Icons.lock,
            //   color: Colors.white,
            //   size: hh() / 22,
            // ),
            // sh(height: 50),
            SizedBox(
              height: hh() / 15,
              child: Image.asset(
                ConstImage.onBoarding1,
                fit: BoxFit.fill,
              ),
            ),
            Text(
              'Create a Demat account to start \nyour investement journey!',
              textAlign: TextAlign.center,
              style: TextStyle(
                color: ConstColor.whiteColor,
                fontSize: size.height * 0.023,
                // fontWeight: FontWeight.bold,
              ),
            ),

            CommonButton.outlinedButton(context, "Sign Up", () {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => const SafeArea(
                    child: Scaffold(
                      body: WebViewX(
                        height: double.infinity,
                        width: double.infinity,
                        javascriptMode: JavascriptMode.unrestricted,
                        initialSourceType: SourceType.url,
                        initialContent: "https://signup.blinkx.in/diy/mobile",
                      ),
                    ),
                  ),
                ),
              );
            })
          ],
        ),
      ),
    );
  }

  Widget jmClientView(Size size) {
    return Padding(
      padding: EdgeInsets.symmetric(
        horizontal: size.width * 0.05,
      ),
      child: Container(
        width: size.width,
        height: size.height / 4,
        decoration: BoxDecoration(
            color: Color.fromARGB(151, 0, 0, 0),
            borderRadius: BorderRadius.circular(15)),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: [
            Icon(
              Icons.lock,
              color: Colors.white,
              size: hh() / 22,
            ),
            Text(
              'Login to with BlinkX account to \ncontinue',
              textAlign: TextAlign.center,
              style: TextStyle(
                color: ConstColor.whiteColor,
                fontSize: size.height * 0.023,
                // fontWeight: FontWeight.bold,
              ),
            ),
            CommonButton.outlinedButton(context, "Login", () {
              UserAuth().showLoginBlinkX(afterLoginPage: BottomBarScreen());
            })
          ],
        ),
      ),
    );
  }
}
