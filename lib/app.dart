import 'package:flutter/material.dart';
import 'package:flutter_mobile_bx/splash.dart';
import 'package:flutter_mobile_bx/helpers/navigation_context.dart';
import 'package:flutter_mobile_bx/view/basket/controller/basket_controller.dart';
import 'package:flutter_mobile_bx/view/basket/controller/basket_summary_controller.dart';
import 'package:flutter_mobile_bx/view/blinkx_profile/controller/blinkx_user_controller.dart';
import 'package:flutter_mobile_bx/view/buy_stock/controller/order_place_controller.dart';
import 'package:flutter_mobile_bx/view/helper/controller/helper_controller.dart';
import 'package:flutter_mobile_bx/view/home/controller/home_cotroller.dart';
import 'package:flutter_mobile_bx/view/orders/controller/orders_controller.dart';
import 'package:flutter_mobile_bx/view/portfolio/controller/portfolio_controller.dart';
import 'package:flutter_mobile_bx/view/stock_detail/controller/get_advisor_filter_controller.dart';
import 'package:flutter_mobile_bx/view/user_profile/controller/user_profile_controller.dart';
import 'package:flutter_mobile_bx/view/x_advice/controller/advisor_controller.dart';
import 'package:flutter_mobile_bx/websocket/web_socket.dart';
import 'package:provider/provider.dart';

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        //Orders Provider
        ChangeNotifierProvider<OrderController>(
            create: (context) => OrderController()),
        //Order Place Provider
        ChangeNotifierProvider<OrderPlaceController>(
            create: (context) => OrderPlaceController()),

        //Basket Provider
        ChangeNotifierProvider<BasketController>(
            create: (context) => BasketController()),

        //Basket Summary Provider
        ChangeNotifierProvider<BasketSummaryController>(
            create: (context) => BasketSummaryController()),

        //Portfolio Provider
        ChangeNotifierProvider<PortfolioController>(
            create: (context) => PortfolioController()),

        //Home Provider
        ChangeNotifierProvider<HomeController>(
            create: (context) => HomeController()),
        //Home Provider
        ChangeNotifierProvider<GetAdvisorFilterController>(
            create: (context) => GetAdvisorFilterController()),
        //advisor Provider
        ChangeNotifierProvider<AdvisorController>(
            create: (context) => AdvisorController()),
        //advisor Provider
        ChangeNotifierProvider<UserProfileController>(
            create: (context) => UserProfileController()),
        //helper Provider
        ChangeNotifierProvider<HelperController>(
            create: (context) => HelperController()),
        //helper Provider
        ChangeNotifierProvider<BlinkxUserController>(
            create: (context) => BlinkxUserController()),
        //helper Provider
        ChangeNotifierProvider<CommonSocket>(
            create: (context) => CommonSocket()),
      ],
      child: MaterialApp(
        navigatorKey: Navigation.navigatorKey,
        debugShowCheckedModeBanner: false,
        title: 'Flutter Demo',
        theme: ThemeData(
          fontFamily: 'ReadexPro',
          primarySwatch: Colors.blue,
        ),
        home: const SplashPage(),
      ),
    );
  }
}
