import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_mobile_bx/const/image.dart';
import 'package:flutter_mobile_bx/const/keys.dart';
import 'package:flutter_mobile_bx/view/bottom_bar.dart';
// import 'package:flutter_mobile_bx/view/marketplace/marketplace_allproduct/marketplace_allproduct.dart';
// import 'package:flutter_mobile_bx/view/marketplace/marketplace_allproduct/widget/alldata_filter_screen.dart';
import 'package:flutter_mobile_bx/view/splash/spash_screen.dart';
import 'package:flutter_mobile_bx/websocket/web_socket.dart';

class SplashPage extends StatefulWidget {
  const SplashPage({super.key});
  @override
  State<SplashPage> createState() => _SplashPageState();
}

class _SplashPageState extends State<SplashPage> with WidgetsBindingObserver {
  @override
  void initState() {
    WidgetsBinding.instance.addObserver(this);
    Future.delayed(
      const Duration(seconds: 3),
      () => Navigator.pushReplacement(
        context,
        MaterialPageRoute(
          builder: (context) => kDebugMode
              // dev
              ? preferences.getString(Keys.accessToken) != null
                  ? BottomBarScreen()
                  : SplashScreen()
              // prod release
              : preferences.getString(Keys.accessToken) != null
                  ? BottomBarScreen()
                  : SplashScreen(),
        ),
      ),
    );
    super.initState();
  }

  @override
  void didChangeAppLifecycleState(AppLifecycleState state) {
    super.didChangeAppLifecycleState(state);
    switch (state) {
      case AppLifecycleState.inactive:
        debugPrint("AppLifecycleState: $state");
        break;
      case AppLifecycleState.resumed:
        handleResumeEvents();
        debugPrint("AppLifecycleState: $state");
        break;
      case AppLifecycleState.paused:
        debugPrint("AppLifecycleState: $state");
        break;
      case AppLifecycleState.detached:
        debugPrint("AppLifecycleState: $state");
        break;
      default:
    }
  }

  handleResumeEvents() {
    debugPrint("resume event start");
    if (CommonSocket().isSocketConnected() == null) {
      CommonSocket().advisiorySocket();
    } else {
      CommonSocket().connectionMade();
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Image.asset(ConstImage.appLogoImg),
      ),
    );
  }
}
