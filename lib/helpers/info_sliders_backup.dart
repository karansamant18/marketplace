// ignore_for_file: prefer_const_constructors, prefer_const_literals_to_create_immutables

import 'package:flutter/material.dart';
import 'package:flutter_mobile_bx/helpers/sizes.dart';

import '../const/color.dart';

class InfoSliderModel {
  String? name;
  double? val;
  bool? status;
  InfoSliderModel({this.name, this.val, this.status = true});
}

class InfoSlider extends StatefulWidget {
  InfoSlider({this.info, required this.width});
  List<InfoSliderModel>? info;
  double width;

  @override
  State<InfoSlider> createState() => _InfoSliderState();
}

class _InfoSliderState extends State<InfoSlider> {
  late List<InfoSliderModel>? info;
  @override
  void initState() {
    info = widget.info;
    // TODO: implement initState
    super.initState();

    info!.sort(((a, b) {
      return a.val!.compareTo(b.val!);
    }));
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      // color: Colors.amber,
      height: 50,
      child: Stack(clipBehavior: Clip.none, children: [
        Container(
          height: 10,
          width: widget.width,
          decoration: BoxDecoration(
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
        info![0].status == true ? firstItem(true) : Container(),
        info![0].status == true ? firstItem(false) : Container(),

        info![1].status == true ? secondItem(true) : Container(),
        info![1].status == true ? secondItem(false) : Container(),

        info![2].status == true ? thirdItem(true) : Container(),
        info![2].status == true ? thirdItem(false) : Container(),

        info![3].status == true ? fourthItem(true) : Container(),
        info![3].status == true ? fourthItem(false) : Container(),
        // Positioned(
        //   left: (info![1].val! - info![0].val!) * 2,
        //   child: SizedBox(
        //       height: 10,
        //       child: VerticalDivider(
        //         thickness: 2,
        //         color: Colors.black,
        //       )),
        // ),
        // Positioned(
        //   right: (info![3].val! - info![2].val!) * 2,
        //   child: SizedBox(
        //       height: 10,
        //       child: VerticalDivider(
        //         thickness: 2,
        //         color: Colors.black,
        //       )),
        // ),
        // Positioned(
        //   right: 0,
        //   child: SizedBox(
        //       height: 10,
        //       child: VerticalDivider(
        //         thickness: 2,
        //         color: Colors.black,
        //       )),
        // ),
      ]),
    );
  }

  double maxMinDif() {
    return info![3].val! - info![0].val!;
  }

  firstItem(bool isMarker) {
    double dif = info![0].val! - info![0].val!;
    double ratio = (dif / maxMinDif());

    double xValue = widget.width * ratio;

    // double x = (info![0].val! - info![0].val!) * unit();

    return isMarker
        ? Positioned(
            left: xValue,
            child: SizedBox(
                height: 10,
                child: VerticalDivider(
                  thickness: 2,
                  color: Colors.black,
                )),
          )
        : Positioned(
            left: xValue,
            bottom: -5,
            child: Column(children: [
              Text(
                info![0].name!,
                style: TextStyle(
                  color: ConstColor.greyColor,
                  fontSize: hh() * 0.014,
                  fontWeight: FontWeight.w500,
                ),
              ),
              const SizedBox(height: 1),
              Text(
                "\u{20B9} ${info![0].val!.toStringAsFixed(1)}",
                style: TextStyle(
                  color: ConstColor.blackColor,
                  fontSize: hh() * 0.015,
                  fontWeight: FontWeight.w500,
                ),
              )
              // Text(info![0].name!),
              // Text(info![0].val!.toString()),
            ]),
          );
  }

  secondItem(bool isMarker) {
    double dif = info![1].val! - info![0].val!;
    double ratio = (dif / maxMinDif());

    double xValue = widget.width * ratio;
    // double x = (info![1].val! - info![0].val!) * unit();
    return isMarker
        ? Positioned(
            left: xValue,
            child: SizedBox(
                height: 10,
                child: VerticalDivider(
                  thickness: 2,
                  color: Colors.black,
                )),
          )
        : Positioned(
            left: xValue - 10,
            top: -40,
            child: Column(children: [
              Row(
                children: [
                  const CircleAvatar(
                    radius: 3,
                    backgroundColor: ConstColor.yellowColor6E,
                  ),
                  const SizedBox(width: 5),
                  Text(
                    info![1].name!,
                    style: TextStyle(
                      color: ConstColor.greyColor,
                      fontSize: hh() * 0.013,
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 1),
              Text(
                "\u{20B9} ${info![1].val!.toStringAsFixed(1)}",
                style: TextStyle(
                  color: ConstColor.yellowColor6E,
                  fontSize: hh() * 0.018,
                  fontWeight: FontWeight.w500,
                ),
              )
            ]),
          );
  }

  thirdItem(bool isMarker) {
    double dif = info![2].val! - info![0].val!;
    double ratio = (dif / maxMinDif());

    double xValue = widget.width * ratio;

    return isMarker
        ? Positioned(
            left: xValue,
            top: -10,
            child: SizedBox(
              height: 30,
              child: RotationTransition(
                turns: AlwaysStoppedAnimation(45 / 360),
                child: Icon(
                  Icons.arrow_upward_rounded,
                  color: ConstColor.greenColor37,
                ),
              ),
            ),
          )
        : Positioned(
            left: xValue - 10,
            bottom: -5,
            child: Column(children: [
              Text(
                info![2].name!,
                style: TextStyle(
                  color: ConstColor.greyColor,
                  fontSize: hh() * 0.014,
                  fontWeight: FontWeight.w500,
                ),
              ),
              SizedBox(height: 1),
              Text(
                "\u{20B9} ${info![2].val!.toStringAsFixed(1)}",
                style: TextStyle(
                  color: ConstColor.greenColor37,
                  fontSize: hh() * 0.017,
                  fontWeight: FontWeight.w500,
                ),
              ),
            ]),
          );
  }

  fourthItem(bool isMarker) {
    double dif = info![3].val! - info![0].val!;
    double ratio = (dif / maxMinDif());

    double xValue = widget.width * ratio - ww() / 7;
    return isMarker
        ? Positioned(
            left: xValue,
            child: SizedBox(
                height: 10,
                child: VerticalDivider(
                  thickness: 2,
                  color: Colors.black,
                )),
          )
        : Positioned(
            left: xValue - 40,
            top: -40,
            child: Column(children: [
              Text(
                info![3].name!,
                style: TextStyle(
                  color: ConstColor.greyColor,
                  fontSize: hh() * 0.014,
                  fontWeight: FontWeight.w500,
                ),
              ),
              const SizedBox(height: 1),
              Text(
                "\u{20B9} ${info![3].val!.toStringAsFixed(1)}",
                style: TextStyle(
                  color: ConstColor.violetF0Color,
                  fontSize: hh() * 0.018,
                  fontWeight: FontWeight.w500,
                ),
              ),
            ]),
          );
  }

  // double unit() {
  //   double diff = widthDiff();
  //   double dif = info![3].val! - info![0].val!;

  //   return dif / (ww() / 1.2);
  // }

  // Widget buildPointer(String name) {
  //   return name.toLowerCase() == 'ltp'
  //       ? SizedBox(
  //           height: 30,
  //           child: RotationTransition(
  //             turns: AlwaysStoppedAnimation(45 / 360),
  //             child: Icon(
  //               Icons.arrow_upward_rounded,
  //               color: ConstColor.greenColor37,
  //             ),
  //           ),
  //         )
  //       : SizedBox(
  //           height: 10,
  //           child: VerticalDivider(
  //             thickness: 2,
  //             color: Colors.black,
  //           ),
  //         );
  // }

  Column _buildItems(InfoSliderModel data) {
    return Column(
      children: [
        SizedBox(
            height: 10,
            child: VerticalDivider(
              thickness: 2,
              color: Colors.black,
            )),
        sh(),
        Text(data.name ?? ""),
        Text(data.val.toString() ?? "r"),
      ],
    );
  }
}
