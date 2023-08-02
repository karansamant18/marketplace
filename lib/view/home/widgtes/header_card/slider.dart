import 'package:flutter/material.dart';

class CommanSlider extends StatelessWidget {
  const CommanSlider({super.key});

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return SizedBox(
      height: size.height * 0.1,
      child: Padding(
        padding: EdgeInsets.symmetric(horizontal: size.width * 0.06),
        child: Stack(
          alignment: Alignment.topCenter,
          children: [
            Padding(
              padding: EdgeInsets.only(top: size.height * 0.025),
              child: Container(
                height: 8,
                width: size.width,
                decoration: const BoxDecoration(
                  gradient: LinearGradient(
                    begin: Alignment.topLeft,
                    end: Alignment.bottomRight,
                    colors: [
                      Color(0xFFE13662),
                      Color(0xffFBEB7C),
                      Color(0xff64DAC2),
                      Color(0xff92C255),
                    ],
                  ),
                  borderRadius: BorderRadius.all(Radius.circular(10)),
                ),
              ),
            ),
            // Row(
            //   crossAxisAlignment: CrossAxisAlignment.end,
            //   children: [
            //     Padding(
            //       padding: EdgeInsets.only(top: size.height * 0.01),
            //       child: Column(
            //         children: [
            //           Text(
            //             '|',
            //             style: TextStyle(
            //               fontSize: size.height * 0.02,
            //               fontWeight: FontWeight.bold,
            //               color: ConstColor.blackColor,
            //             ),
            //           ),
            //           SizedBox(height: size.height * 0.02),
            //           Text(
            //             'SL',
            //             style: TextStyle(
            //               fontSize: size.height * 0.015,
            //               fontWeight: FontWeight.w500,
            //               color: ConstColor.greyColor,
            //             ),
            //           ),
            //           Text('data'),
            //         ],
            //       ),
            //     ),
            //     Padding(
            //       padding: EdgeInsets.only(bottom: size.height * 0.02),
            //       child: Column(
            //         children: [
            //           Text(
            //             'SL',
            //             style: TextStyle(
            //               fontSize: size.height * 0.015,
            //               fontWeight: FontWeight.w500,
            //               color: ConstColor.greyColor,
            //             ),
            //           ),

            //           Text(
            //             '|',
            //             style: TextStyle(
            //               fontSize: size.height * 0.02,
            //               fontWeight: FontWeight.bold,
            //               color: ConstColor.blackColor,
            //             ),
            //           ),
            //           SizedBox(height: size.height * 0.05),
            //           // SizedBox(height: size.height * 0.02),
            //           // Text(
            //           //   'SL',
            //           //   style: TextStyle(
            //           //     fontSize: size.height * 0.015,
            //           //     fontWeight: FontWeight.w500,
            //           //     color: ConstColor.greyColor,
            //           //   ),
            //           // ),
            //           // Text('data'),
            //         ],
            //       ),
            //     )
            //   ],
            // ),
          ],
        ),
      ),
    );
  }
}
