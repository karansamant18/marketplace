import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_mobile_bx/const/color.dart';
import 'package:flutter_mobile_bx/helpers/sizes.dart';
import 'package:flutter_mobile_bx/view/basket/model/basket_model.dart';
import 'package:flutter_mobile_bx/view/basket/pages/basket_info_screen.dart';
import 'package:flutter_mobile_bx/view/basket/widgets/basket_card_info.dart';
import 'package:provider/provider.dart';
import 'package:slider_button/slider_button.dart';

import '../../widgets/search_appbar.dart';
import 'controller/basket_controller.dart';

class BasketHome extends StatefulWidget {
  BasketHome({super.key});

  @override
  State<BasketHome> createState() => _BasketHomeState();
}

class _BasketHomeState extends State<BasketHome> {
  late BasketController basketController;
  BasketModel? allBasket;
  @override
  void initState() {
    basketController = Provider.of<BasketController>(context, listen: false);
    // basketController.getAllBasket();
    // basketController.addListener(() {
    //   basketController.getAllBasket().then((value) {
    //     if (mounted)
    //       setState(() {
    //         allBasket = value.data!;
    //       });
    //   });
    // });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Scaffold(
      backgroundColor: Colors.transparent,
      body: Consumer<BasketController>(builder: (context, value, child) {
        if (value.allBasket!.data == null) {
          return const Center(
            child: Text("X Basket"),
          );
        } else {
          allBasket = value.allBasket!.data;
          return Container(
            decoration: const BoxDecoration(
              gradient: LinearGradient(
                begin: Alignment.topLeft,
                end: Alignment.bottomRight,
                colors: <Color>[
                  Color.fromARGB(255, 84, 41, 97),
                  Color.fromARGB(255, 255, 54, 98)
                ],
              ),
            ),
            height: size.height,
            width: size.width,
            child: SingleChildScrollView(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  SizedBox(height: size.height * 0.07),
                  Padding(
                    padding:
                        EdgeInsets.symmetric(horizontal: size.width * 0.06),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        const SearchAppBar(),
                        SizedBox(height: size.height * 0.02),
                        Text(
                          "Invest in \nBasket",
                          style: TextStyle(
                            color: ConstColor.whiteColor,
                            fontSize: size.height * 0.03,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        SizedBox(height: size.height * 0.01),
                        Text(
                          "Get your stock game going without the \nheadache of endless hours of research!",
                          style: TextStyle(
                            color: ConstColor.whiteColor,
                            fontSize: size.height * 0.016,
                            fontWeight: FontWeight.w400,
                          ),
                        ),
                        _basketList(size)
                      ],
                    ),
                  ),
                ],
              ),
            ),
          );
        }
      }),
    );
  }

  Widget _basketList(Size size) {
    return ListView.builder(
      shrinkWrap: true,
      physics: NeverScrollableScrollPhysics(),
      itemCount: allBasket!.data!.length,
      // separatorBuilder: (BuildContext context, int index) {
      //   return const Divider();
      // },
      itemBuilder: (BuildContext context, int index) {
        return basketCard(size, index);
      },
    );
  }

  Widget basketCard(Size size, int index) {
    Basket data = allBasket!.data![index];
    return Container(
      decoration: BoxDecoration(
        color: ConstColor.whiteColor,
        borderRadius: BorderRadius.circular(15),
      ),
      margin: const EdgeInsets.only(bottom: 20),
      child: Column(
        children: [
          Stack(
            children: [
              Container(
                width: ww() / 1,
                height: hh() / 4.5,
                decoration: BoxDecoration(
                    color: ConstColor.whiteColor,
                    borderRadius: BorderRadius.circular(15)),
                child: ClipRRect(
                  borderRadius: const BorderRadius.only(
                    topLeft: Radius.circular(15),
                    topRight: Radius.circular(15),
                    bottomLeft: Radius.circular(15),
                    bottomRight: Radius.circular(15),
                  ),
                  child: CachedNetworkImage(
                    fit: BoxFit.fitWidth,
                    progressIndicatorBuilder: (context, url, progress) =>
                        Center(
                      child: CircularProgressIndicator(
                        value: progress.progress,
                      ),
                    ),
                    imageUrl:
                        'https://images.unsplash.com/photo-1503435980610-a51f3ddfee50?ixlib=rb-4.0.3&ixid=MnwxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8&auto=format&fit=crop&w=1287&q=80',
                  ),
                ),
              ),
              Positioned(
                bottom: 50,
                left: 20,
                child: Container(
                  decoration: const BoxDecoration(
                    color: ConstColor.whiteColor,
                    borderRadius: BorderRadius.all(Radius.circular(50)),
                  ),
                  padding: const EdgeInsets.all(10),
                  child: Icon(
                    Icons.card_giftcard,
                    color: Colors.black.withOpacity(0.4),
                    size: 50,
                  ),
                ),
                // child: SvgPicture.asset(
                //   ConstImage.basketSector,
                //   height: hh() / 7,
                //   width: ww() / 4,
                // ),
              ),
              Positioned(
                bottom: 20,
                left: 20,
                // padding: const EdgeInsets.all(25.0),
                child: Text(
                  allBasket!.data![index].productName!,
                  style: TextStyle(
                    color: ConstColor.whiteColor,
                  ),
                ),
              ),
            ],
          ),
          Padding(
            padding: const EdgeInsets.fromLTRB(10, 10, 10, 0),
            child: BasketCardInfo(
              cagr: data.cagr ?? "",
              minAmount: data.minInvestAmt!,
              volatility: data.volatility!,
              intrestedCount: "N/A",
            ),
          ),
          SizedBox(height: size.height * 0.01),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 8),
            child: Container(
              decoration: const BoxDecoration(
                gradient: LinearGradient(
                  colors: [
                    Color(0xFFE13662),
                    Color(0xFFEB4954),
                    Color(0xFFD346F0)
                  ],
                ),
                borderRadius: BorderRadius.all(Radius.circular(25)),
              ),
              child: SliderButton(
                backgroundColor: Colors.transparent,
                height: 45,
                width: size.width,
                buttonColor: ConstColor.whiteColor,
                action: () {},
                label: Text(
                  "Swipe to buy now",
                  style: TextStyle(
                    color: const Color(0xffFFFFFF).withOpacity(0.75),
                    fontWeight: FontWeight.w500,
                    fontSize: size.height * 0.018,
                  ),
                ),
                buttonSize: size.height * 0.05,
                shimmer: false,
                child: Container(
                  decoration: const BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.all(
                      Radius.circular(30),
                    ),
                  ),
                  padding:
                      const EdgeInsets.symmetric(vertical: 5, horizontal: 20),
                  margin:
                      const EdgeInsets.symmetric(vertical: 0, horizontal: 5),
                  child: const Icon(
                    Icons.chevron_right_rounded,
                    color: Color(0xFFE94657),
                  ),
                ),
              ),
            ),
          ),
          SizedBox(height: size.height * 0.01),
          GestureDetector(
            onTap: () {
              basketController.updateSelectedBasket(allBasket!.data![index]);
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => BasketInfoScreen(),
                ),
              );
            },
            child: Text(
              'View Details',
              style: TextStyle(
                fontSize: size.height * 0.015,
                fontWeight: FontWeight.bold,
              ),
            ),
          ),
          sh(height: 50)
        ],
      ),
    );
  }

  Widget pill(String head, String value,
      {TextStyle? headStyle, TextStyle? valueStyle}) {
    return Column(
      children: [Text(head), Text(value)],
    );
  }
}
