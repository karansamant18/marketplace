// import 'dart:math';

// import 'package:carousel_slider/carousel_slider.dart';
// import 'package:flutter/material.dart';
// import 'package:flutter_mobile_bx/const/color.dart';
// import 'package:flutter_mobile_bx/const/image.dart';
// import 'package:flutter_mobile_bx/view/home/controller/card_controller.dart';
// import 'package:flutter_mobile_bx/view/stock_detail/view/stock_detail_screen.dart';
// import 'package:flutter_svg/flutter_svg.dart';
// import 'package:provider/provider.dart';

// class HeaderCardView extends StatefulWidget {
//   const HeaderCardView({super.key});

//   @override
//   State<HeaderCardView> createState() => _HeaderCardViewState();
// }

// class _HeaderCardViewState extends State<HeaderCardView> {
//   CarouselController carouselController = CarouselController();
//   CardProvider cardProvider = CardProvider();

//   @override
//   void initState() {
//     super.initState();
//     cardProvider = Provider.of<CardProvider>(context, listen: false);
//     WidgetsBinding.instance.addPersistentFrameCallback((_) {
//       Size size = MediaQuery.of(context).size;
//       cardProvider.setScreenSize(size);
//     });
//   }

//   @override
//   Widget build(BuildContext context) {
//     Size size = MediaQuery.of(context).size;
//     return Container(
//       width: size.width,
//       decoration: const BoxDecoration(
//         gradient: LinearGradient(
//           begin: Alignment.topLeft,
//           end: Alignment.bottomRight,
//           colors: [
//             Color(0xFFE13662),
//             Color(0xffEB4954),
//             ConstColor.violetF0Color,
//             // const Color(0xffE43C5E).withOpacity(0.8),
//             // const Color(0xffE43C5E).withOpacity(0.6),
//             // ConstColor.violetF0Color,
//             // ConstColor.violetF0Color
//           ],
//         ),
//       ),
//       child: Column(
//         crossAxisAlignment: CrossAxisAlignment.start,
//         children: [
//           SizedBox(height: size.height * 0.03),
//           Padding(
//             padding: EdgeInsets.symmetric(horizontal: size.width * 0.07),
//             child: Row(
//               children: [
//                 SvgPicture.asset(
//                   ConstImage.appLogoSvg,
//                   color: ConstColor.whiteColor,
//                   width: size.width * 0.2,
//                 ),
//               ],
//             ),
//           ),
//           SizedBox(height: size.height * 0.04),

//           SizedBox(
//             height: size.height / 1.6,
//             child: Stack(
//               alignment: Alignment.bottomCenter,
//               children: [
//                 Align(
//                   alignment: Alignment.topCenter,
//                   child: Container(
//                     height: size.height / 1.6,
//                     width: size.width / 1.35,
//                     decoration: BoxDecoration(
//                       color: ConstColor.whiteColor,
//                       borderRadius: BorderRadius.circular(15),
//                     ),
//                     child: Container(
//                       height: size.height / 5.2,
//                       decoration: BoxDecoration(
//                         color: ConstColor.black29Color,
//                         borderRadius: BorderRadius.circular(15),
//                       ),
//                       width: size.width,
//                       child: Stack(
//                         children: [
//                           Padding(
//                             padding: EdgeInsets.only(top: size.height * 0.02),
//                             child:
//                                 SvgPicture.asset(ConstImage.cardBackgroundImg),
//                           ),
//                           Center(
//                             child: Column(
//                               crossAxisAlignment: CrossAxisAlignment.center,
//                               children: [
//                                 SizedBox(height: size.height * 0.02),
//                                 Text(
//                                   'Hot',
//                                   style: TextStyle(
//                                     color: ConstColor.whiteColor,
//                                     fontSize: size.height * 0.02,
//                                     fontWeight: FontWeight.w400,
//                                   ),
//                                 ),
//                                 Text(
//                                   'Calls',
//                                   style: TextStyle(
//                                     color: ConstColor.whiteColor,
//                                     fontSize: size.height * 0.035,
//                                     fontWeight: FontWeight.w600,
//                                   ),
//                                 ),
//                               ],
//                             ),
//                           ),
//                         ],
//                       ),
//                     ),
//                   ),
//                 ),
//                 _buildCardView(size),
//               ],
//             ),
//           ),
//           // _buildCardView(size),
//           SizedBox(height: size.height * 0.05),
//         ],
//       ),
//     );
//   }

//   Widget _buildCardView(Size size) {
//     return LayoutBuilder(builder: (context, constraints) {
//       return Builder(
//         builder: (context) {
//           final position = cardProvider.position;
//           int microseconds = cardProvider.isDragging ? 0 : 400;
//           final center = constraints.smallest.center(Offset.zero);
//           final angle = cardProvider.angle * pi / 180;

//           final rotatedMatrix = Matrix4.identity()
//             ..translate(center.dx, center.dy)
//             ..rotateZ(angle)
//             ..translate(-center.dx, -center.dy);

//           return AnimatedContainer(
//             curve: Curves.easeInOut,
//             duration: Duration(microseconds: microseconds),
//             transform: rotatedMatrix..translate(position.dx, position.dy),
//             child: GestureDetector(
//               onPanStart: (details) {
//                 cardProvider.startPosition(details);
//               },
//               onPanUpdate: (details) {
//                 cardProvider.updatePosition(details);
//               },
//               onPanEnd: (details) {
//                 cardProvider.endPosition();
//               },
//               // onHorizontalDragEnd: (DragEndDetails details) {
//               //   if ((details.primaryVelocity ?? 0) > 0) {
//               //     Navigator.of(context).push(MaterialPageRoute(
//               //       builder: (context) => BuyStockScreen(),
//               //     ));
//               //   } else if ((details.primaryVelocity ?? 0) < 0) {
//               //     Navigator.of(context).push(MaterialPageRoute(
//               //       builder: (context) => BuyStockScreen(),
//               //     ));
//               //   }
//               // },
//               child: CarouselSlider(
//                 disableGesture: false,
//                 carouselController: carouselController,
//                 options: CarouselOptions(
//                   scrollPhysics: const NeverScrollableScrollPhysics(),
//                   height: size.height / 2,
//                 ),
//                 items: [1, 2, 3, 4, 5].map((i) {
//                   return Builder(
//                     builder: (BuildContext context) {
//                       return Container(
//                         width: MediaQuery.of(context).size.width,
//                         margin:
//                             EdgeInsets.symmetric(horizontal: size.width * 0.02),
//                         decoration: BoxDecoration(
//                             color: ConstColor.whiteColor,
//                             borderRadius: BorderRadius.circular(15)),
//                         padding:
//                             EdgeInsets.symmetric(horizontal: size.width * 0.05),
//                         child: Column(
//                           children: [
//                             SizedBox(height: size.height * 0.03),
//                             GestureDetector(
//                               onTap: () {
//                                 Navigator.of(context).push(MaterialPageRoute(
//                                   builder: (context) => StockDetailScreen(),
//                                 ));
//                               },
//                               child: Text(
//                                 'SIEMENS LTD',
//                                 style: TextStyle(
//                                   fontSize: size.height * 0.025,
//                                   fontWeight: FontWeight.bold,
//                                   color: ConstColor.violet42Color,
//                                 ),
//                               ),
//                             ),
//                             SizedBox(height: size.height * 0.01),
//                             Text(
//                               'Mass Tech Technologies',
//                               style: TextStyle(
//                                 fontSize: size.height * 0.014,
//                                 fontWeight: FontWeight.w500,
//                                 color: ConstColor.violet42Color,
//                               ),
//                             ),
//                             SizedBox(height: size.height * 0.04),
//                             Row(
//                               mainAxisAlignment: MainAxisAlignment.spaceAround,
//                               children: [
//                                 Column(
//                                   crossAxisAlignment: CrossAxisAlignment.start,
//                                   children: [
//                                     Text(
//                                       'Enter',
//                                       style: TextStyle(
//                                         color: ConstColor.black29Color,
//                                         fontSize: size.height * 0.015,
//                                         fontWeight: FontWeight.w400,
//                                       ),
//                                     ),
//                                     const SizedBox(height: 5),
//                                     Text(
//                                       '\u{20B9} 10,0000',
//                                       style: TextStyle(
//                                         color: ConstColor.black29Color,
//                                         fontSize: size.height * 0.02,
//                                         fontWeight: FontWeight.w600,
//                                       ),
//                                     ),
//                                   ],
//                                 ),
//                                 Column(
//                                   crossAxisAlignment: CrossAxisAlignment.start,
//                                   children: [
//                                     SizedBox(height: size.height * 0.015),
//                                     Text(
//                                       'Target Price',
//                                       style: TextStyle(
//                                         color: ConstColor.black29Color,
//                                         fontSize: size.height * 0.015,
//                                         fontWeight: FontWeight.w400,
//                                       ),
//                                     ),
//                                     SizedBox(height: 5),
//                                     Text(
//                                       '\u{20B9} 10,0000',
//                                       style: TextStyle(
//                                         color: ConstColor.blueFEColor,
//                                         fontSize: size.height * 0.02,
//                                         fontWeight: FontWeight.w600,
//                                       ),
//                                     ),
//                                     Row(
//                                       children: [
//                                         Icon(
//                                           Icons.keyboard_arrow_up,
//                                           size: size.height * 0.02,
//                                           color: ConstColor.greenColor75,
//                                         ),
//                                         Text(
//                                           '(14.21%)',
//                                           style: TextStyle(
//                                             color: ConstColor.greenColor75,
//                                             fontSize: size.height * 0.014,
//                                             fontWeight: FontWeight.w400,
//                                           ),
//                                         ),
//                                       ],
//                                     ),
//                                   ],
//                                 ),
//                               ],
//                             ),
//                             SizedBox(height: size.height * 0.04),
//                             Row(
//                               mainAxisAlignment: MainAxisAlignment.spaceAround,
//                               children: [
//                                 Column(
//                                   crossAxisAlignment: CrossAxisAlignment.start,
//                                   children: [
//                                     Text(
//                                       'Enter',
//                                       style: TextStyle(
//                                         color: ConstColor.black29Color,
//                                         fontSize: size.height * 0.015,
//                                         fontWeight: FontWeight.w400,
//                                       ),
//                                     ),
//                                     const SizedBox(height: 5),
//                                     Text(
//                                       '\u{20B9} 10,0000',
//                                       style: TextStyle(
//                                         color: ConstColor.black29Color,
//                                         fontSize: size.height * 0.02,
//                                         fontWeight: FontWeight.w600,
//                                       ),
//                                     ),
//                                   ],
//                                 ),
//                                 Column(
//                                   crossAxisAlignment: CrossAxisAlignment.start,
//                                   children: [
//                                     Text(
//                                       'Target Price',
//                                       style: TextStyle(
//                                         color: ConstColor.black29Color,
//                                         fontSize: size.height * 0.015,
//                                         fontWeight: FontWeight.w400,
//                                       ),
//                                     ),
//                                     SizedBox(height: 5),
//                                     Text(
//                                       '\u{20B9} 10,0000',
//                                       style: TextStyle(
//                                         color: ConstColor.blueFEColor,
//                                         fontSize: size.height * 0.02,
//                                         fontWeight: FontWeight.w600,
//                                       ),
//                                     ),
//                                   ],
//                                 ),
//                               ],
//                             ),
//                             SizedBox(height: size.height * 0.04),
//                             Row(
//                               mainAxisAlignment: MainAxisAlignment.spaceEvenly,
//                               children: [
//                                 _buildButton(
//                                     icon: ConstImage.leftArrowIcon,
//                                     onTap: () {
//                                       carouselController.previousPage();
//                                     },
//                                     size: size,
//                                     title: 'Previous'),
//                                 _buildButton(
//                                     icon: ConstImage.rightArrowIcon,
//                                     onTap: () {
//                                       carouselController.nextPage();
//                                     },
//                                     size: size,
//                                     title: 'Skip'),
//                               ],
//                             )
//                           ],
//                         ),
//                       );
//                     },
//                   );
//                 }).toList(),
//               ),
//             ),
//           );
//         },
//       );
//     });
//   }

//   Column _buildButton({
//     required Size size,
//     required String icon,
//     required String title,
//     required void Function() onTap,
//   }) {
//     return Column(
//       children: [
//         GestureDetector(
//           onTap: onTap,
//           child: Card(
//             elevation: 6,
//             shape: RoundedRectangleBorder(
//               borderRadius: BorderRadius.circular(50),
//             ),
//             child: Padding(
//               padding: EdgeInsets.all(size.height * 0.017),
//               child: SvgPicture.asset(
//                 icon,
//                 height: size.height * 0.02,
//                 color: ConstColor.violet61Color,
//               ),
//             ),
//           ),
//         ),
//         SizedBox(height: size.height * 0.01),
//         Text(
//           title,
//           style: TextStyle(
//             fontSize: size.height * 0.015,
//             fontWeight: FontWeight.w500,
//             color: ConstColor.black29Color.withOpacity(0.7),
//           ),
//         )
//       ],
//     );
//   }
// }
