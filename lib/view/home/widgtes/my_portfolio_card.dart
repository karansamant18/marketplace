import 'package:flutter/material.dart';
import 'package:flutter_mobile_bx/const/color.dart';
import 'package:flutter_mobile_bx/view/helper/api/helper_api.dart';
import 'package:flutter_mobile_bx/view/home/controller/home_cotroller.dart';
// import 'package:flutter_mobile_bx/view/home/controller/home_cotroller.dart';
import 'package:flutter_mobile_bx/view/portfolio/controller/portfolio_controller.dart';
import 'package:flutter_mobile_bx/view/portfolio/model/portfolio_holdings_model.dart';
import 'package:flutter_mobile_bx/view/portfolio/portfolio_screen.dart';
import 'package:provider/provider.dart';

class MyPortfolioCard extends StatefulWidget {
  const MyPortfolioCard({super.key});

  @override
  State<MyPortfolioCard> createState() => _MyPortfolioCardState();
}

class _MyPortfolioCardState extends State<MyPortfolioCard> {
  PortfolioController portfolioController = PortfolioController();
  double? invested = 0;
  double? current = 0;
  double? pnl = 0;
  @override
  void initState() {
    portfolioController =
        Provider.of<PortfolioController>(context, listen: false);
    portfolioController.portfolioHoldingsController();
    portfolioTokenSetSub.stream.listen((event) {
      if (event == true &&
          portfolioController.portfolioHoldingsModel.data == null) {
        portfolioController.portfolioHoldingsController();
      }
    });
    tokenSetSub.stream.listen((event) {
      if (event == true && current == 0) {
        portfolioController.portfolioHoldingsController();
      }
    });

    super.initState();
  }

  calculatePortfolioValues(List<EquityHolding>? data) {
    if (data!.isNotEmpty) {
      double inv = data!
          .map((element) {
            return (element.netQty! * element.netRate!);
          })
          .toList()
          .reduce((a, b) => a + b);
      double curr = data
          .map((element) {
            return (element.netQty! * element.symbol!.ltp!);
          })
          .toList()
          .reduce((a, b) => a + b);
      double pl = curr - inv;
      pnl = double.parse(pl.toStringAsFixed(2));
      invested = double.parse(inv.toStringAsFixed(2));
      current = double.parse(curr.toStringAsFixed(2));
    }

    // setState(() {
    //   pnl = pl;
    //   invested = inv;
    //   current = curr;
    // });
  }

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Container(
      width: size.width,
      decoration: BoxDecoration(
          color: ConstColor.violet42Color,
          borderRadius: BorderRadius.circular(20)),
      padding: EdgeInsets.symmetric(
        horizontal: size.width * 0.07,
        vertical: size.height * 0.025,
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                'My Portfolio',
                textAlign: TextAlign.center,
                style: TextStyle(
                  color: ConstColor.whiteColor,
                  fontSize: size.height * 0.02,
                  fontWeight: FontWeight.bold,
                ),
              ),
              GestureDetector(
                onTap: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => const PortfolioScreen(),
                    ),
                  );
                },
                child: Container(
                  decoration: BoxDecoration(
                    gradient: const LinearGradient(
                      begin: Alignment.centerLeft,
                      end: Alignment.centerRight,
                      colors: [
                        Color(0xFFE13662),
                        Color(0xffEB4954),
                        ConstColor.violetF0Color,
                      ],
                    ),
                    borderRadius: BorderRadius.circular(10),
                  ),
                  padding: EdgeInsets.symmetric(
                      horizontal: size.width * 0.025, vertical: 3),
                  child: Icon(
                    Icons.arrow_forward_ios_rounded,
                    size: size.height * 0.018,
                    color: ConstColor.whiteColor,
                  ),
                ),
              )
            ],
          ),
          SizedBox(height: size.height * 0.015),
          Divider(
            color: ConstColor.whiteColor.withOpacity(0.9),
          ),
          SizedBox(height: size.height * 0.01),
          portfolioDataView(size),
        ],
      ),
    );
  }

  Widget portfolioDataView(Size size) {
    return Consumer<PortfolioController>(builder: (context, value, child) {
      if (value.portfolioHoldingsModel.data == null ||
          (value.portfolioHoldingsModel.data != null &&
              value.portfolioHoldingsModel.data!.data!.portfolio != null &&
              value.portfolioHoldingsModel.data!.data!.portfolio!
                  .equityHoldings!.isNotEmpty &&
              value.portfolioHoldingsModel.data!.data!.portfolio!
                      .equityHoldings![0].symbol!.ltp! ==
                  0)) {
        return SizedBox(
          height: size.height * 0.15,
          child: Center(child: CircularProgressIndicator()),
        );
      } else {
        // if (value.portfolioHoldingsModel.data != null &&
        //     value.portfolioHoldingsModel.data!.data!.portfolio!.equityHoldings!
        //         .isNotEmpty) {
        //   calculatePortfolioValues(value
        //       .portfolioHoldingsModel.data!.data!.portfolio!.equityHoldings!);
        // }
        if (value.portfolioHoldingsModel.data!.data!.portfolio != null) {
          calculatePortfolioValues(value
              .portfolioHoldingsModel.data!.data!.portfolio!.equityHoldings!);
        }
        return Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'Net P/L',
              style: TextStyle(
                color: ConstColor.whiteColor.withOpacity(0.6),
                fontSize: size.height * 0.015,
                fontWeight: FontWeight.w600,
              ),
            ),
            SizedBox(height: size.height * 0.01),
            Row(
              children: [
                Text(
                  '\u{20B9} $pnl',
                  style: TextStyle(
                    color: pnl! >= 0
                        ? ConstColor.greenColor37
                        : ConstColor.pink62Color,
                    fontSize: size.height * 0.023,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                SizedBox(width: size.width * 0.02),
                Text(
                  '(${invested! > 0 ? (((pnl! / invested!) * 100).toStringAsFixed(2)) : 0}%)',
                  style: TextStyle(
                    color: pnl! >= 0
                        ? ConstColor.greenColor37
                        : ConstColor.pink62Color,
                    fontSize: size.height * 0.018,
                    fontWeight: FontWeight.w500,
                  ),
                ),
              ],
            ),
            // SizedBox(height: size.height * 0.007),
            // Row(
            //   children: [
            //     Text(
            //       '(-601.05)',
            //       style: TextStyle(
            //         color: ConstColor.violetCAColor,
            //         fontSize: size.height * 0.014,
            //         fontWeight: FontWeight.w400,
            //       ),
            //     ),
            //     SizedBox(width: size.width * 0.02),
            //     Text(
            //       '13:00',
            //       style: TextStyle(
            //         color: ConstColor.violetE4Color,
            //         fontSize: size.height * 0.014,
            //         fontWeight: FontWeight.w400,
            //       ),
            //     ),
            //   ],
            // ),
            SizedBox(height: size.height * 0.02),
            Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      'Invested',
                      style: TextStyle(
                        color: ConstColor.whiteColor.withOpacity(0.6),
                        fontSize: size.height * 0.014,
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                    SizedBox(width: size.width * 0.02),
                    Text(
                      '\u{20B9} $invested',
                      style: TextStyle(
                        color: ConstColor.whiteColor.withOpacity(0.9),
                        fontSize: size.height * 0.023,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ],
                ),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      'Current',
                      style: TextStyle(
                        color: ConstColor.whiteColor.withOpacity(0.6),
                        fontSize: size.height * 0.014,
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                    SizedBox(width: size.width * 0.02),
                    Text(
                      '\u{20B9} $current',
                      style: TextStyle(
                        color: ConstColor.whiteColor.withOpacity(0.9),
                        fontSize: size.height * 0.023,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ],
        );
      }
    });
  }
}
