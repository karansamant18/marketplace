import 'package:flutter/material.dart';
import 'package:flutter_mobile_bx/helpers/navigation_context.dart';

double hh() {
  BuildContext context = Navigation().context;
  return MediaQuery.of(context).size.height;
}

double ww() {
  BuildContext context = Navigation().context;
  return MediaQuery.of(context).size.width;
}

Widget sh({double height = 100}) {
  return SizedBox(height: hh() / height);
}

Widget sw({double width = 100}) {
  return SizedBox(width: ww() / width);
}
