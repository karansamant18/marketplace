import 'package:flutter/material.dart';
import 'package:flutter_mobile_bx/const/image.dart';
import 'package:flutter_mobile_bx/helpers/common_functions.dart';
import 'package:flutter_mobile_bx/helpers/sizes.dart';
import 'package:flutter_mobile_bx/helpers/user_auth.dart';
import 'package:flutter_mobile_bx/view/home/home_screen.dart';
import 'package:flutter_mobile_bx/view/on_boarding/on_bording_screen.dart';
import 'package:flutter_mobile_bx/view/orders/orders_screen.dart';
import 'package:flutter_mobile_bx/view/portfolio/portfolio_screen.dart';
import 'package:flutter_mobile_bx/view/support/support_screen.dart';
import 'package:flutter_mobile_bx/view/user_profile/user_profile_screen.dart';
import 'package:flutter_mobile_bx/view/x_advice/x_advice_screen.dart';
import 'package:flutter_mobile_bx/widgets/bottom_modal.dart';
import 'package:flutter_mobile_bx/widgets/pill.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:provider/provider.dart';

import 'home/controller/home_cotroller.dart';

class BottomBarScreen extends StatefulWidget {
  const BottomBarScreen({super.key});

  @override
  _BottomBarScreenState createState() => _BottomBarScreenState();
}

class _BottomBarScreenState extends State<BottomBarScreen> {
  int _selectedIndex = 0;
  final List<Widget> _widgetOptions = <Widget>[
    // const HomeScreen(),
    HomeScreen(),
    Consumer<HomeController>(builder: (context, homeCtrlValue, child) {
      return XAdviceScreen(
        fromExplore: homeCtrlValue.fromExplore,
      );
    }),
    // BasketHome(),
    OnBoardingScreen(
      fromBasket: true,
    )
    // showModal(),
    // const Text('Profile Page',
    //     style: TextStyle(fontSize: 35, fontWeight: FontWeight.bold)),
  ];

  void _onItemTapped(int index) {
    if (homeController.fromExplore) {
      homeController.updateFromExplore(false);
    }
    if (index == 3) {
      // showModal();
      CommonDialogs.bottomDialog(bottomModalContent(), height: hh() / 3);
    } else {
      homeController.updateBottomSelectedIndex(index);

      // setState(() {
      //   _selectedIndex = index;
      // });
    }
  }

  late HomeController homeController;
  @override
  void initState() {
    super.initState();
    homeController = Provider.of<HomeController>(context, listen: false);
  }

  @override
  void dispose() {
    super.dispose();
    // homeController.dispose();
    homeController.updateFromExplore(false);
    homeController.updateBottomSelectedIndex(0);
  }

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Consumer<HomeController>(builder: (context, homeCtrlValue, child) {
      return Scaffold(
        extendBody: true,
        body: Center(
          child: _widgetOptions.elementAt(homeCtrlValue.bottomSelectedIndex),
        ),
        bottomNavigationBar: ClipRRect(
          borderRadius: BorderRadius.only(
            topLeft: Radius.circular(size.height * 0.02),
            topRight: Radius.circular(size.height * 0.02),
          ),
          child: BottomNavigationBar(
            items: <BottomNavigationBarItem>[
              const BottomNavigationBarItem(
                  icon: Padding(
                    padding: EdgeInsets.only(top: 8.0),
                    child: Icon(Icons.home),
                  ),
                  label: 'Home',
                  backgroundColor: Colors.green),
              BottomNavigationBarItem(
                icon: Padding(
                  padding: const EdgeInsets.only(top: 11.0),
                  child: SvgPicture.asset(
                    ConstImage.chatIcon,
                    height: size.height * 0.025,
                    color: homeCtrlValue.bottomSelectedIndex == 1
                        ? const Color.fromARGB(255, 0, 0, 0)
                        : const Color.fromARGB(255, 150, 150, 150),
                  ),
                ),
                label: 'XResearch',
              ),
              const BottomNavigationBarItem(
                icon: Padding(
                  padding: EdgeInsets.only(top: 8.0),
                  child: Icon(Icons.card_giftcard),
                ),
                label: 'XBasket',
              ),
              const BottomNavigationBarItem(
                icon: Padding(
                  padding: EdgeInsets.only(top: 8.0),
                  child: Icon(Icons.dialpad),
                ),
                label: 'More',
              ),
            ],
            type: BottomNavigationBarType.fixed,
            currentIndex: homeCtrlValue.bottomSelectedIndex,
            selectedItemColor: Colors.black,

            // iconSize: 40,
            onTap: _onItemTapped,
            elevation: 5,
          ),
        ),
      );
    });
  }

  Widget bottomModalContent() {
    String? name = UserAuth().firstName;
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        name == null
            ? const SizedBox.shrink()
            : Row(
                children: [
                  Text(
                    'Hey ${name.capitalize()}!',
                    style: const TextStyle(
                      color: Color(0xFF542961),
                      fontSize: 26,
                    ),
                  ),
                  const Spacer(),
                  GestureDetector(
                    onTap: () {
                      UserAuth.allLogout();
                    },
                    child: Container(
                      height: hh() / 18.5,
                      width: ww() / 8.3,
                      alignment: Alignment.center,
                      decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(8),
                          color: const Color.fromARGB(81, 167, 82, 193)),
                      child: const FaIcon(
                        FontAwesomeIcons.powerOff,
                        size: 20,
                        color: Color(
                          0xFF542961,
                        ),
                      ),
                    ),
                  )
                ],
              ),
        sh(height: 15),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            routePill(
              icon: Icons.library_books_outlined,
              value: "Orders",
              color: const Color(0xFF542961),
              fn: () {
                Navigator.pushReplacement(
                  context,
                  MaterialPageRoute(
                    builder: (context) => const OrdersScreen(),
                  ),
                );
              },
            ),
            routePill(
              icon: Icons.pie_chart_rounded,
              value: "Portfolio",
              color: const Color(0xFF542961),
              fn: () {
                Navigator.pushReplacement(
                  context,
                  MaterialPageRoute(
                    builder: (context) => const PortfolioScreen(),
                  ),
                );
              },
            ),
            routePill(
              icon: Icons.person,
              value: "Profile",
              color: const Color(0xFF542961),
              fn: () {
                Navigator.pushReplacement(
                  context,
                  MaterialPageRoute(
                    builder: (context) => UserProfileScreen(),
                  ),
                );
              },
            ),
            routePill(
              icon: Icons.chat_bubble,
              value: "Support",
              color: const Color(0xFF542961),
              fn: () {
                Navigator.pushReplacement(
                  context,
                  MaterialPageRoute(
                    builder: (context) => SupportScreen(),
                  ),
                );
              },
            ),
            // routePill(
            //   icon: Icons.tune,
            //   value: "Settings",
            //   color: const Color(0xFF542961),
            //   fn: () {},
            // ),
          ],
        ),
        sh(height: 20),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            SvgPicture.asset(
              ConstImage.appLogoLightSvg,
              // height: size.height * 0.025,
            ),
            Row(
              children: [
                Text(
                  "Privacy Policy",
                  style: TextStyle(
                    color: const Color(0xFF5053D9).withOpacity(0.9),
                    fontSize: 10,
                  ),
                ),
                sw(width: 50),
                Text(
                  "© 2023 JM Financial",
                  style: TextStyle(
                    color: const Color(0xFF43284B).withOpacity(0.75),
                    fontSize: 10,
                  ),
                ),
              ],
            )
          ],
        )
      ],
    );
  }

  // showModal() {
  //   Size size = MediaQuery.of(context).size;
  //   return showModalBottomSheet(
  //     enableDrag: true,
  //     clipBehavior: Clip.antiAliasWithSaveLayer,
  //     context: context,
  //     shape: RoundedRectangleBorder(
  //       borderRadius: BorderRadius.only(
  //         topLeft: new Radius.circular(10),
  //         topRight: new Radius.circular(10),
  //       ),
  //     ),
  //     backgroundColor: ConstColor.whiteColor,
  //     isScrollControlled: true,
  //     builder: (ctx) {
  //       return Container(
  //         height: hh() / 3,
  //         padding: const EdgeInsets.symmetric(
  //           vertical: 20,
  //           horizontal: 30,
  //         ),
  //         child: Column(
  //           crossAxisAlignment: CrossAxisAlignment.start,
  //           children: [
  //             Center(
  //               child: Container(
  //                 width: size.width * 0.1,
  //                 padding: const EdgeInsets.symmetric(
  //                   vertical: 1,
  //                   horizontal: 2,
  //                 ),
  //                 decoration: const BoxDecoration(
  //                     color: ConstColor.greyColor,
  //                     borderRadius: BorderRadius.all(Radius.circular(5))),
  //               ),
  //             ),
  //             sh(height: 25),
  //           ],
  //         ),
  //       );
  //     },
  //   ).then((value) {
  //     debugPrint(value);
  //     // globalProvider.updateSearchText("");
  //   });
  // }

  Widget routePill({
    required IconData icon,
    required String value,
    required Function() fn,
    required Color color,
  }) {
    return GestureDetector(
      behavior: HitTestBehavior.translucent,
      onTap: fn,
      child: Pill.widgetTextPill(
        head: Icon(
          icon,
          color: color,
          size: 22,
        ),
        value: value,
        valueStyle: TextStyle(
          color: color,
          fontSize: 12,
        ),
      ),
    );
  }
}
