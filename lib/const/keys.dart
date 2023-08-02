import 'package:shared_preferences/shared_preferences.dart';

class Keys {
  static const String accessToken = 'accessToken';
  static const String userName = 'userName';
  static const String userId = 'userId';
  static const String refreshToken = 'refreshToken';
  static const String portfolioToken = 'portfolioToken';

  static const String marketDataToken = 'marketDataToken';
  static const String marketDataAccesstoken = 'marketDataAccesstoken';
  static const String isJmClient = "isJmClient";
  static const String userIdBlinkx = 'userIdBlinkx';
  static const String accessTokenBlinkx = 'accessTokenBlinkx';
  static const String refreshTokenBlinkx = 'refreshTokenBlinkx';
  static const String clientConfig = 'clientConfig';

  static const String animateSuperStarsScroll = 'animateSuperStarsScroll';
  static const String animateSuperStarsXadvise = 'animateSuperStarsXadvise';

  static const String userPhoneNo = 'userPhoneNo';

  // static const String marketDataAccesstoken =
  //     'ea4f7c48d0c0d9be9c3b000f22c59e75e21bf81dd3ab578a0b08d8da0aef788';
  static const String apiKey = 'E9ROIfZOlJXKm4ZGUl9xJDHGCEjgNQDa';
  static const String eleverApiKey =
      'a9dGzJ6rKkyZjPU04SWEqEK4Uwho8NDpNyLz0TNfs61HJNsl';
  static const String eleverAuthToken =
      'Bearer eyJhbGciOiJIUzI1NiIsImtpZCI6IlNsdDlENTlEMW5IdVdGS3YwczJiM3B2TEYtZW5mVEZCT0tEQm9MSW5hLWsifQ.eyJhdWQiOiJodHRwczovL2FwaS5lbGV2ZXJhcGkudGVjaCIsImV4cCI6MTY4NTY4ODQzNywiaXNzIjoiaHR0cHM6Ly9hcGkuZWxldmVyYXBpLnRlY2gvZWxldmVyLXRva2VuLWlzc3VlciIsImp0aSI6IjkxNTAyNDY3ODIyNDI4NDE0MjkiLCJzdWIiOiIyMzAwMDAxMyJ9.kYunM4UNJyRi8BYfwFd4pmOgrb3uBFbQPeBkuSo9hw8';
  // static const String refreshStaticToken =
  //     'WZuk0FjLP+emFtQSDRJg4dqa/jJZlvL1j18DAkgLeEV8csQXOiRZQXS3yBdPPPmgchNz97cltiGEtqxKrRJFXQ==';
}

late SharedPreferences preferences;
