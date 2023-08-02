import 'package:flutter/material.dart';

class Navigation { 
  static GlobalKey<NavigatorState> navigatorKey = 
  GlobalKey<NavigatorState>();

  get context =>
  navigatorKey.currentContext;
  
}