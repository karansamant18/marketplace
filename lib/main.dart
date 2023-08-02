import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_mobile_bx/const/keys.dart';
import 'package:flutter_mobile_bx/helpers/user_auth.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'app.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  SharedPreferences prefs = await SharedPreferences.getInstance();
  preferences = prefs;
  UserAuth().initiateRefreshToken();
  SystemChrome.setPreferredOrientations([
    DeviceOrientation.portraitUp,
  ]);
  runApp(const MyApp());
}
