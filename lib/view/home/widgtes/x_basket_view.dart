import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_mobile_bx/const/color.dart';
import 'package:slider_button/slider_button.dart';

class XBasketView extends StatefulWidget {
  const XBasketView({super.key});

  @override
  State<XBasketView> createState() => _XBasketViewState();
}

class _XBasketViewState extends State<XBasketView> {
  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Stack(
      alignment: Alignment.bottomCenter,
      children: [
        Container(
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
                  color: ConstColor.lightOrange,
                  borderRadius: BorderRadius.horizontal(
                    right: Radius.circular(50),
                  ),
                ),
                padding: EdgeInsets.symmetric(
                  horizontal: size.width * 0.07,
                  vertical: 6,
                ),
                child: Text(
                  'Xbasket',
                  style: TextStyle(
                    letterSpacing: 4,
                    color: ConstColor.whiteColor,
                    fontSize: size.height * 0.02,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
              SizedBox(height: size.height * 0.02),
              Padding(
                padding: EdgeInsets.symmetric(
                  horizontal: size.width * 0.07,
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      'Pre-made themed \nstock baskets',
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
              SizedBox(height: size.height * 1.09),
            ],
          ),
        ),
        Container(
          width: size.width,
          decoration: BoxDecoration(
            gradient: LinearGradient(
              begin: Alignment.centerRight,
              end: Alignment.bottomRight,
              colors: [
                ConstColor.violet61Color,
                ConstColor.violetF0Color.withOpacity(0.8),
              ],
            ),
            borderRadius: BorderRadius.only(
              topLeft: Radius.circular(size.height * 0.02),
              topRight: Radius.circular(size.height * 0.02),
            ),
          ),
          padding: EdgeInsets.symmetric(vertical: size.height * 0.03),
          child: Column(
            children: [
              _buildListView(size),
              SizedBox(height: size.height * 0.025),
              _buildListView(size),
              SizedBox(height: size.height * 0.025),
              Padding(
                padding: EdgeInsets.symmetric(horizontal: size.width * 0.05),
                child: Column(
                  children: [
                    const Divider(
                      color: ConstColor.whiteColor,
                      thickness: 1,
                    ),
                    SizedBox(height: size.height * 0.02),
                    Row(
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
                    )
                  ],
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }

  Widget _buildListView(Size size) {
    return SizedBox(
      height: size.height / 2.3,
      child: ListView.builder(
        itemCount: 5,
        shrinkWrap: true,
        scrollDirection: Axis.horizontal,
        itemBuilder: (context, index) {
          return _buildCardView(size);
        },
      ),
    );
  }

  Widget _buildCardView(Size size) {
    return Padding(
      padding:
          EdgeInsets.only(left: size.width * 0.02, top: size.height * 0.02),
      child: SizedBox(
        width: size.width / 1.3,
        child: Card(
          shape:
              RoundedRectangleBorder(borderRadius: BorderRadius.circular(15)),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              _buldImageView(size),
              // Container(
              //   height: size.height / 6,
              //   decoration: BoxDecoration(
              //       color: ConstColor.black29Color,
              //       borderRadius: BorderRadius.circular(15),
              //       image: DecorationImage(
              //           image: NetworkImage(
              //               'https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcQnnu6obVk9X7KpF7ddIVK0Xukk7GK5uWC1GA&usqp=CAU'))),
              // ),
              Padding(
                padding: EdgeInsets.symmetric(horizontal: size.width * 0.06),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    SizedBox(height: size.height * 0.02),
                    Row(
                      children: [
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              '2Y CAGR',
                              style: TextStyle(
                                color: ConstColor.black29Color,
                                fontSize: size.height * 0.012,
                                fontWeight: FontWeight.w400,
                              ),
                            ),
                            const SizedBox(height: 5),
                            Text(
                              '71.20%',
                              style: TextStyle(
                                color: ConstColor.violetE4Color,
                                fontSize: size.height * 0.02,
                                fontWeight: FontWeight.w600,
                              ),
                            ),
                          ],
                        ),
                        SizedBox(width: size.width * 0.04),
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              'Min Amount',
                              style: TextStyle(
                                color: ConstColor.black29Color,
                                fontSize: size.height * 0.012,
                                fontWeight: FontWeight.w400,
                              ),
                            ),
                            SizedBox(height: 5),
                            Text(
                              '\u{20B9} 10K',
                              style: TextStyle(
                                color: ConstColor.violet61Color,
                                fontSize: size.height * 0.02,
                                fontWeight: FontWeight.w600,
                              ),
                            ),
                          ],
                        ),
                      ],
                    ),
                    SizedBox(height: size.height * 0.03),
                    SliderButton(
                      height: 60,
                      buttonColor: ConstColor.whiteColor,
                      action: () {},
                      label: Text(
                        "Slide to cancel Event",
                        style: TextStyle(
                          color: Color(0xff4a4a4a),
                          fontWeight: FontWeight.w500,
                          fontSize: size.height * 0.018,
                        ),
                      ),
                      buttonSize: size.height * 0.06,
                      shimmer: false,
                      icon: Icon(
                        Icons.arrow_forward_ios_rounded,
                        color: ConstColor.black29Color,
                      ),
                    ),
                  ],
                ),
              )
            ],
          ),
        ),
      ),
    );
  }

  Widget _buldImageView(Size size) {
    return Container(
      height: size.height / 5,
      width: size.width / 1.3,
      clipBehavior: Clip.hardEdge,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(15),
      ),
      child: Stack(
        children: [
          SizedBox(
            height: size.height / 5,
            width: size.width / 1.3,
            child: CachedNetworkImage(
              imageUrl:
                  'https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcQnnu6obVk9X7KpF7ddIVK0Xukk7GK5uWC1GA&usqp=CAU',
              fit: BoxFit.fill,
            ),
          ),
          Container(
            height: size.height / 6,
            width: size.width,
            clipBehavior: Clip.hardEdge,
            decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(15),
                color: ConstColor.black29Color.withOpacity(0.2)),
          ),
          Padding(
            padding: EdgeInsets.symmetric(horizontal: size.width * 0.03),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                SizedBox(height: size.height * 0.015),
                Row(
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: [
                    Text(
                      'View Details',
                      style: TextStyle(
                        color: ConstColor.whiteColor,
                        fontSize: size.height * 0.014,
                        fontWeight: FontWeight.w400,
                      ),
                    ),
                    const SizedBox(width: 5),
                    Icon(
                      Icons.arrow_forward_ios_rounded,
                      size: size.height * 0.014,
                      color: ConstColor.whiteColor,
                    )
                  ],
                ),
                CircleAvatar(),
                SizedBox(height: size.height * 0.01),
                SizedBox(
                  width: size.width / 3,
                  child: Text(
                    'Green Energy',
                    style: TextStyle(
                      color: ConstColor.whiteColor,
                      fontSize: size.height * 0.025,
                      fontWeight: FontWeight.w700,
                    ),
                  ),
                )
              ],
            ),
          ),
        ],
      ),
    );
  }
}
