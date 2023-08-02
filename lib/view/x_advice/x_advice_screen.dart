import 'package:flutter/material.dart';
import 'package:flutter_mobile_bx/const/color.dart';
import 'package:flutter_mobile_bx/const/image.dart';
import 'package:flutter_mobile_bx/view/home/controller/home_cotroller.dart';
import 'package:flutter_mobile_bx/view/home/model/home_quote_model.dart';
import 'package:flutter_mobile_bx/view/x_advice/model/get_advisor_call_model.dart';
import 'package:flutter_mobile_bx/view/x_advice/widget/blink_superstar_screen.dart';
import 'package:flutter_mobile_bx/view/x_advice/widget/research_call_screen.dart';
import 'package:flutter_mobile_bx/websocket/web_socket.dart';
import 'package:flutter_svg/svg.dart';
import 'package:flutter_mobile_bx/widgets/marquee/marquee.dart';
import 'package:provider/provider.dart';

class XAdviceScreen extends StatefulWidget {
  XAdviceScreen({super.key, this.fromExplore = false});

  final bool fromExplore;

  @override
  State<XAdviceScreen> createState() => _XAdviceScreenState();
}

class _XAdviceScreenState extends State<XAdviceScreen> {
  HomeController homeController = HomeController();
  List<HomeQuoteModel>? quoteData;
  List<AdvisoryResults>? quoteList;

  late ScrollController scr;
  @override
  void initState() {
    homeController = Provider.of<HomeController>(context, listen: false);

    homeController.getQuoteController().then((value) {
      setState(() {
        quoteData = value.data;
      });
      quoteData = value.data;
      quoteList = [];
      quoteData!.forEach((quote) {
        quoteList!.add(AdvisoryResults(
          symbol: quote.symbol,
          secToken: quote.symphonyToken,
          exchange: 'NSE',
        ));
      });
      CommonSocket().subscribeTokens(quoteList ?? []);
      socketConnectSub.stream.listen((event) {
        if (event == true) {
          CommonSocket().subscribeTokens(quoteList ?? []);
        }
      });
    });
    scr = ScrollController();
    WidgetsBinding.instance.addPostFrameCallback((_) async {
      if (widget.fromExplore == true) {
        scr.animateTo(800,
            duration: Duration(milliseconds: 800), curve: Curves.easeInOut);
      }
    });

    // TODO: implement initState
    super.initState();
  }

  @override
  void dispose() {
    super.dispose();
    CommonSocket().unsubscribeTokens(quoteList ?? []);
  }

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;

    return Scaffold(
      backgroundColor: ConstColor.violetF0Color,
      body: SingleChildScrollView(
        controller: scr,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
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
            Container(
              width: size.width,
              height: size.height / 3.2,
              decoration: BoxDecoration(
                gradient: LinearGradient(
                  begin: Alignment.topLeft,
                  end: Alignment.bottomLeft,
                  colors: [
                    const Color(0xffE43C5E),
                    const Color(0xffE43C5E).withOpacity(0.8),
                    ConstColor.violetF0Color,
                  ],
                ),
              ),
              child: Padding(
                padding: EdgeInsets.symmetric(horizontal: size.width * 0.04),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    SizedBox(height: size.height * 0.03),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        SvgPicture.asset(
                          ConstImage.appLogoSvg,
                          color: ConstColor.whiteColor,
                          width: size.width * 0.3,
                        ),
                        // const Icon(
                        //   Icons.search,
                        //   color: ConstColor.whiteColor,
                        // )
                      ],
                    ),
                    SizedBox(height: size.height * 0.035),
                    Text(
                      'Welcome to \nXAdvice.',
                      style: TextStyle(
                        color: ConstColor.whiteColor,
                        fontSize: size.height * 0.03,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    SizedBox(height: size.height * 0.02),
                    Text(
                      'Get your stock journey going without the \nheadache of endless hours of research!',
                      style: TextStyle(
                        color: ConstColor.whiteColor.withOpacity(0.7),
                        fontSize: size.height * 0.017,
                        fontWeight: FontWeight.w400,
                      ),
                    ),
                  ],
                ),
              ),
            ),
            ResearchCallScreen(),
            BlinkSuperStarView()
          ],
        ),
      ),
    );
  }
}
