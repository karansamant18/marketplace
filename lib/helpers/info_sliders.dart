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

class InfoSliderCopy extends StatefulWidget {
  InfoSliderCopy({this.info, required this.width});
  List<InfoSliderModel?>? info;
  double width;

  @override
  State<InfoSliderCopy> createState() => _InfoSliderState();
}

class _InfoSliderState extends State<InfoSliderCopy> {
  late List<InfoSliderModel?>? info;

  double? min;
  double? max;

  List predefVal = [
    {'name': 'sl', 'color': Colors.black, 'icon': Container()},
    {'name': 'ltp', 'color': Colors.black, 'icon': Container()},
    {
      'name': 'enter',
      'color': Color(0xFFF5CD6E),
      'icon': Icon(
        Icons.star,
        size: 10,
        color: Color(0xFFF5CD6E),
      )
    },
    {
      'name': 'tgt',
      'color': Color(0xFFD346F0),
      'icon': Icon(
        Icons.circle,
        size: 8,
        color: Color(0xFFD346F0),
      )
    },
  ];

  @override
  void initState() {
    super.initState();
    buildLtp();
    // info = widget.info;
    // min = info!.map((e) => e.val).toList().sort();
    // final sorted = info;
    // sorted!.sort(((a, b) {
    //   return a!.val!.compareTo(b!.val!);
    // }));
    // min = sorted[0]!.val;
    // max = sorted[3]!.val;
  }

  buildLtp() {
    info = widget.info;
    final sorted = info;
    sorted!.sort(((a, b) {
      return a!.val!.compareTo(b!.val!);
    }));
    min = sorted[0]!.val;
    max = sorted[3]!.val;
  }

  double maxMinDif() {
    return max! - min!;
  }

  @override
  Widget build(BuildContext context) {
    buildLtp();
    return Container(
      // color: Colors.amber,
      height: 50,
      child: Stack(clipBehavior: Clip.none, children: [
        Container(
          height: 10,
          // width: widget.width,
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
        ...info!.map((e) {
          return e!.status == true ? buildItem(true, data: e) : Container();
        }).toList(),
        ...info!.map((e) {
          // debugPrint("${e.name} - ${e.status}");
          return e!.status == true ? buildItem(false, data: e) : Container();
        }).toList(),
      ]),
    );
  }

  Widget buildItem(bool isMarker, {InfoSliderModel? data}) {
    double dif = data!.val! - info![0]!.val!;
    double ratio = (dif / maxMinDif());
    double xValue = widget.width * ratio;
    final props = predefVal
        .firstWhere((element) => element['name'] == data.name!.toLowerCase());
    return isMarker
        ? Positioned(
            left: (xValue >= widget.width) ? widget.width : xValue,
            top: (data.name!.toLowerCase() != 'ltp') ? 0 : -(hh() / 35),
            child: buildPointer(data.name!),
          )
        : (data.name!.toLowerCase() != 'ltp')
            ? (Positioned(
                left: (xValue >= widget.width)
                    ? (widget.width - 20)
                    : (xValue - 10),
                bottom: -5,
                child: Column(
                  children: [
                    Row(
                      children: [
                        props['icon'],
                        sw(),
                        Text(
                          data.name!,
                          style: TextStyle(
                            color: ConstColor.greyColor,
                            fontSize: hh() * 0.014,
                            fontWeight: FontWeight.w500,
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(height: 1),
                    Text(
                      "\u{20B9} ${data.val!.toStringAsFixed(1)}",
                      style: TextStyle(
                        color: props['color'],
                        fontSize: hh() * 0.015,
                        fontWeight: FontWeight.w500,
                      ),
                    )
                  ],
                ),
              ))
            : Positioned(
                left: (xValue >= widget.width)
                    ? (widget.width - 20)
                    : (xValue - 10),
                top: -(hh() / 17),
                child: Column(
                  children: [
                    Text(
                      data.name!,
                      style: TextStyle(
                        color: ConstColor.greyColor,
                        fontSize: hh() * 0.014,
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                    const SizedBox(height: 1),
                    Text(
                      "\u{20B9} ${data.val!.toStringAsFixed(2)}",
                      style: TextStyle(
                        color: props['color'],
                        fontSize: hh() * 0.015,
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                  ],
                ),
              );
  }

  Widget buildPointer(String name) {
    return name.toLowerCase() == 'ltp'
        ? SizedBox(
            height: 30,
            child: RotationTransition(
              turns: AlwaysStoppedAnimation(90 / 360),
              child: Icon(
                Icons.chevron_right,
                color: ConstColor.greenColor37,
              ),
            ),
          )
        : SizedBox(
            height: 10,
            child: VerticalDivider(
              thickness: 2,
              color: Colors.black,
            ),
          );
  }
}
