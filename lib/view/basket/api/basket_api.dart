import 'dart:convert';
import 'package:flutter_mobile_bx/const/keys.dart';
import 'package:flutter_mobile_bx/const/url.dart';
import 'package:flutter_mobile_bx/view/basket/api/dummy_data.dart';
import 'package:flutter_mobile_bx/view/basket/model/basket_intro_model.dart';
import 'package:flutter_mobile_bx/view/basket/model/basket_perf_model.dart';
import 'package:flutter_mobile_bx/view/basket/model/basket_proposal.dart';
import 'package:flutter_mobile_bx/view/basket/model/invest_basket_modal.dart';
import 'package:flutter_mobile_bx/view/basket/model/place_trade_model.dart';
import 'package:flutter_mobile_bx/view/basket/model/post_trade_model.dart';
import 'package:flutter_mobile_bx/helpers/user_model.dart';
import 'package:http/http.dart' as http;

import '../model/basket_model.dart';

dynamic basketPerfStatic = {
  "status": "success",
  "data": {
    "productID": "P2212",
    "productSeries": {
      "seriesName": "Dividend Titans",
      "isBenchmark": false,
      "lastUpdatedAt": "2023-05-11T01:10:31.191684Z",
      "monthlyReturnList": [
        {"label": "31-Dec-05", "value": "0.00"},
        {"label": "31-Jan-06", "value": "4.01"},
        {"label": "28-Feb-06", "value": "0.19"},
        {"label": "31-Mar-06", "value": "7.47"},
        {"label": "30-Apr-06", "value": "3.23"},
        {"label": "31-May-06", "value": "-12.41"},
        {"label": "30-Jun-06", "value": "-3.55"},
        {"label": "31-Jul-06", "value": "-1.32"},
        {"label": "31-Aug-06", "value": "9.39"},
        {"label": "30-Sep-06", "value": "5.63"},
        {"label": "31-Oct-06", "value": "3.17"},
        {"label": "30-Nov-06", "value": "0.32"},
        {"label": "31-Dec-06", "value": "-0.17"},
        {"label": "31-Jan-07", "value": "2.66"},
        {"label": "28-Feb-07", "value": "-6.55"},
        {"label": "31-Mar-07", "value": "1.15"},
        {"label": "30-Apr-07", "value": "9.37"},
        {"label": "31-May-07", "value": "9.42"},
        {"label": "30-Jun-07", "value": "-1.08"},
        {"label": "31-Jul-07", "value": "2.90"},
        {"label": "31-Aug-07", "value": "-2.90"},
        {"label": "30-Sep-07", "value": "12.86"},
        {"label": "31-Oct-07", "value": "10.62"},
        {"label": "30-Nov-07", "value": "0.39"},
        {"label": "31-Dec-07", "value": "15.57"},
        {"label": "31-Jan-08", "value": "-10.64"},
        {"label": "29-Feb-08", "value": "3.68"},
        {"label": "31-Mar-08", "value": "-3.47"},
        {"label": "30-Apr-08", "value": "5.85"},
        {"label": "31-May-08", "value": "2.44"},
        {"label": "30-Jun-08", "value": "-11.36"},
        {"label": "31-Jul-08", "value": "2.67"},
        {"label": "31-Aug-08", "value": "3.54"},
        {"label": "30-Sep-08", "value": "-11.04"},
        {"label": "31-Oct-08", "value": "-19.10"},
        {"label": "30-Nov-08", "value": "-2.43"},
        {"label": "31-Dec-08", "value": "6.11"},
        {"label": "31-Jan-09", "value": "1.27"},
        {"label": "28-Feb-09", "value": "-3.81"},
        {"label": "31-Mar-09", "value": "9.30"},
        {"label": "30-Apr-09", "value": "11.07"},
        {"label": "31-May-09", "value": "18.59"},
        {"label": "30-Jun-09", "value": "6.81"},
        {"label": "31-Jul-09", "value": "6.48"},
        {"label": "31-Aug-09", "value": "5.83"},
        {"label": "30-Sep-09", "value": "6.21"},
        {"label": "31-Oct-09", "value": "4.34"},
        {"label": "30-Nov-09", "value": "5.17"},
        {"label": "31-Dec-09", "value": "8.07"},
        {"label": "31-Jan-10", "value": "-1.81"},
        {"label": "28-Feb-10", "value": "2.04"},
        {"label": "31-Mar-10", "value": "9.26"},
        {"label": "30-Apr-10", "value": "3.50"},
        {"label": "31-May-10", "value": "3.52"},
        {"label": "30-Jun-10", "value": "7.44"},
        {"label": "31-Jul-10", "value": "5.05"},
        {"label": "31-Aug-10", "value": "3.85"},
        {"label": "30-Sep-10", "value": "6.01"},
        {"label": "31-Oct-10", "value": "3.54"},
        {"label": "30-Nov-10", "value": "-3.00"},
        {"label": "31-Dec-10", "value": "2.17"},
        {"label": "31-Jan-11", "value": "-9.03"},
        {"label": "28-Feb-11", "value": "-2.73"},
        {"label": "31-Mar-11", "value": "9.97"},
        {"label": "30-Apr-11", "value": "0.09"},
        {"label": "31-May-11", "value": "-1.93"},
        {"label": "30-Jun-11", "value": "2.46"},
        {"label": "31-Jul-11", "value": "4.05"},
        {"label": "31-Aug-11", "value": "-7.35"},
        {"label": "30-Sep-11", "value": "-0.96"},
        {"label": "31-Oct-11", "value": "2.66"},
        {"label": "30-Nov-11", "value": "-8.96"},
        {"label": "31-Dec-11", "value": "-5.48"},
        {"label": "31-Jan-12", "value": "8.43"},
        {"label": "29-Feb-12", "value": "6.37"},
        {"label": "31-Mar-12", "value": "0.46"},
        {"label": "30-Apr-12", "value": "-6.28"},
        {"label": "31-May-12", "value": "-4.73"},
        {"label": "30-Jun-12", "value": "5.18"},
        {"label": "31-Jul-12", "value": "-2.09"},
        {"label": "31-Aug-12", "value": "2.75"},
        {"label": "30-Sep-12", "value": "6.30"},
        {"label": "31-Oct-12", "value": "1.56"},
        {"label": "30-Nov-12", "value": "3.31"},
        {"label": "31-Dec-12", "value": "1.27"},
        {"label": "31-Jan-13", "value": "-2.56"},
        {"label": "28-Feb-13", "value": "-2.10"},
        {"label": "31-Mar-13", "value": "4.10"},
        {"label": "30-Apr-13", "value": "0.78"},
        {"label": "31-May-13", "value": "1.50"},
        {"label": "30-Jun-13", "value": "-4.03"},
        {"label": "31-Jul-13", "value": "-6.90"},
        {"label": "31-Aug-13", "value": "-0.94"},
        {"label": "30-Sep-13", "value": "2.01"},
        {"label": "31-Oct-13", "value": "6.14"},
        {"label": "30-Nov-13", "value": "0.73"},
        {"label": "31-Dec-13", "value": "2.84"},
        {"label": "31-Jan-14", "value": "-2.74"},
        {"label": "28-Feb-14", "value": "2.37"},
        {"label": "31-Mar-14", "value": "8.69"},
        {"label": "30-Apr-14", "value": "-0.30"},
        {"label": "31-May-14", "value": "7.55"},
        {"label": "30-Jun-14", "value": "10.91"},
        {"label": "31-Jul-14", "value": "1.58"},
        {"label": "31-Aug-14", "value": "6.29"},
        {"label": "30-Sep-14", "value": "5.69"},
        {"label": "31-Oct-14", "value": "2.60"},
        {"label": "30-Nov-14", "value": "6.47"},
        {"label": "31-Dec-14", "value": "1.19"},
        {"label": "31-Jan-15", "value": "4.60"},
        {"label": "28-Feb-15", "value": "3.74"},
        {"label": "31-Mar-15", "value": "-3.51"},
        {"label": "30-Apr-15", "value": "-5.99"},
        {"label": "31-May-15", "value": "3.00"},
        {"label": "30-Jun-15", "value": "-1.00"},
        {"label": "31-Jul-15", "value": "4.92"},
        {"label": "31-Aug-15", "value": "0.21"},
        {"label": "30-Sep-15", "value": "0.71"},
        {"label": "31-Oct-15", "value": "1.61"},
        {"label": "30-Nov-15", "value": "0.33"},
        {"label": "31-Dec-15", "value": "-0.40"},
        {"label": "31-Jan-16", "value": "-3.74"},
        {"label": "29-Feb-16", "value": "-6.71"},
        {"label": "31-Mar-16", "value": "13.10"},
        {"label": "30-Apr-16", "value": "0.02"},
        {"label": "31-May-16", "value": "7.58"},
        {"label": "30-Jun-16", "value": "4.23"},
        {"label": "31-Jul-16", "value": "3.90"},
        {"label": "31-Aug-16", "value": "2.36"},
        {"label": "30-Sep-16", "value": "-2.95"},
        {"label": "31-Oct-16", "value": "3.79"},
        {"label": "30-Nov-16", "value": "-5.31"},
        {"label": "31-Dec-16", "value": "-0.43"},
        {"label": "31-Jan-17", "value": "4.69"},
        {"label": "28-Feb-17", "value": "5.70"},
        {"label": "31-Mar-17", "value": "4.11"},
        {"label": "30-Apr-17", "value": "2.44"},
        {"label": "31-May-17", "value": "3.40"},
        {"label": "30-Jun-17", "value": "0.92"},
        {"label": "31-Jul-17", "value": "4.10"},
        {"label": "31-Aug-17", "value": "5.63"},
        {"label": "30-Sep-17", "value": "-1.19"},
        {"label": "31-Oct-17", "value": "3.39"},
        {"label": "30-Nov-17", "value": "-0.32"},
        {"label": "31-Dec-17", "value": "4.71"},
        {"label": "31-Jan-18", "value": "2.87"},
        {"label": "28-Feb-18", "value": "-4.06"},
        {"label": "31-Mar-18", "value": "-0.56"},
        {"label": "30-Apr-18", "value": "10.09"},
        {"label": "31-May-18", "value": "-2.55"},
        {"label": "30-Jun-18", "value": "-3.82"},
        {"label": "31-Jul-18", "value": "6.01"},
        {"label": "31-Aug-18", "value": "6.38"},
        {"label": "30-Sep-18", "value": "-10.38"},
        {"label": "31-Oct-18", "value": "-1.34"},
        {"label": "30-Nov-18", "value": "2.90"},
        {"label": "31-Dec-18", "value": "2.86"},
        {"label": "31-Jan-19", "value": "-0.89"},
        {"label": "28-Feb-19", "value": "-1.29"},
        {"label": "31-Mar-19", "value": "5.55"},
        {"label": "30-Apr-19", "value": "-0.61"},
        {"label": "31-May-19", "value": "3.49"},
        {"label": "30-Jun-19", "value": "0.81"},
        {"label": "31-Jul-19", "value": "-4.89"},
        {"label": "31-Aug-19", "value": "0.51"},
        {"label": "30-Sep-19", "value": "1.42"},
        {"label": "31-Oct-19", "value": "2.75"},
        {"label": "30-Nov-19", "value": "-4.58"},
        {"label": "31-Dec-19", "value": "2.98"},
        {"label": "31-Jan-20", "value": "1.87"},
        {"label": "29-Feb-20", "value": "-6.35"},
        {"label": "31-Mar-20", "value": "-23.33"},
        {"label": "30-Apr-20", "value": "12.55"},
        {"label": "31-May-20", "value": "0.93"},
        {"label": "30-Jun-20", "value": "8.42"},
        {"label": "31-Jul-20", "value": "0.35"},
        {"label": "31-Aug-20", "value": "4.19"},
        {"label": "30-Sep-20", "value": "-2.37"},
        {"label": "31-Oct-20", "value": "3.68"},
        {"label": "30-Nov-20", "value": "9.12"},
        {"label": "31-Dec-20", "value": "6.51"},
        {"label": "31-Jan-21", "value": "0.63"},
        {"label": "28-Feb-21", "value": "10.91"},
        {"label": "31-Mar-21", "value": "0.57"},
        {"label": "30-Apr-21", "value": "0.52"},
        {"label": "31-May-21", "value": "5.69"},
        {"label": "30-Jun-21", "value": "7.43"},
        {"label": "31-Jul-21", "value": "0.14"},
        {"label": "31-Aug-21", "value": "-0.47"},
        {"label": "30-Sep-21", "value": "5.77"},
        {"label": "31-Oct-21", "value": "0.84"},
        {"label": "30-Nov-21", "value": "3.42"},
        {"label": "31-Dec-21", "value": "-0.90"},
        {"label": "31-Jan-22", "value": "-5.06"},
        {"label": "28-Feb-22", "value": "-2.66"},
        {"label": "31-Mar-22", "value": "2.70"},
        {"label": "30-Apr-22", "value": "3.38"},
        {"label": "31-May-22", "value": "-0.06"},
        {"label": "30-Jun-22", "value": "-2.76"},
        {"label": "31-Jul-22", "value": "7.72"},
        {"label": "31-Aug-22", "value": "5.01"},
        {"label": "30-Sep-22", "value": "0.63"},
        {"label": "31-Oct-22", "value": "4.21"},
        {"label": "30-Nov-22", "value": "0.68"},
        {"label": "31-Dec-22", "value": "-3.66"},
        {"label": "31-Jan-23", "value": "2.08"},
        {"label": "28-Feb-23", "value": "-2.84"},
        {"label": "31-Mar-23", "value": "-1.63"},
        {"label": "30-Apr-23", "value": "3.09"},
        {"label": "05-May-23", "value": "-0.68"}
      ],
      "AnnualizedReturn": [
        {"label": "Since Inception", "value": "19.67"},
        {"label": "YTD", "value": "-0.12"},
        {"label": "1-Year", "value": "11.75"},
        {"label": "3-Year", "value": "26.83"},
        {"label": "5-Year", "value": "12.51"},
        {"label": "10-Year", "value": "18.56"},
        {"label": "15-Year", "value": "18.46"},
        {"label": "Live", "value": "0.96"}
      ],
      "SipReturn": [
        {"label": "Since Inception", "value": "18.77"},
        {"label": "YTD", "value": "185.61"},
        {"label": "1-Year", "value": "4.52"},
        {"label": "3-Year", "value": "16.86"},
        {"label": "5-Year", "value": "15.83"},
        {"label": "10-Year", "value": "17.20"},
        {"label": "15-Year", "value": "18.35"},
        {"label": "Live", "value": "45.21"}
      ]
    },
    "benchmarkSeries": [
      {
        "seriesName": "Nifty 500",
        "isBenchmark": true,
        "lastUpdatedAt": "2023-05-11T01:10:31.191684Z",
        "monthlyReturnList": [
          {"label": "31-Dec-05", "value": "0.00"},
          {"label": "31-Jan-06", "value": "5.21"},
          {"label": "28-Feb-06", "value": "2.97"},
          {"label": "31-Mar-06", "value": "9.51"},
          {"label": "30-Apr-06", "value": "5.34"},
          {"label": "31-May-06", "value": "-13.90"},
          {"label": "30-Jun-06", "value": "-2.44"},
          {"label": "31-Jul-06", "value": "0.21"},
          {"label": "31-Aug-06", "value": "9.76"},
          {"label": "30-Sep-06", "value": "6.67"},
          {"label": "31-Oct-06", "value": "4.26"},
          {"label": "30-Nov-06", "value": "5.36"},
          {"label": "31-Dec-06", "value": "0.64"},
          {"label": "31-Jan-07", "value": "3.01"},
          {"label": "28-Feb-07", "value": "-8.30"},
          {"label": "31-Mar-07", "value": "1.45"},
          {"label": "30-Apr-07", "value": "7.48"},
          {"label": "31-May-07", "value": "5.49"},
          {"label": "30-Jun-07", "value": "1.96"},
          {"label": "31-Jul-07", "value": "4.49"},
          {"label": "31-Aug-07", "value": "-1.77"},
          {"label": "30-Sep-07", "value": "13.04"},
          {"label": "31-Oct-07", "value": "14.80"},
          {"label": "30-Nov-07", "value": "1.33"},
          {"label": "31-Dec-07", "value": "10.05"},
          {"label": "31-Jan-08", "value": "-18.77"},
          {"label": "29-Feb-08", "value": "0.38"},
          {"label": "31-Mar-08", "value": "-12.24"},
          {"label": "30-Apr-08", "value": "10.40"},
          {"label": "31-May-08", "value": "-6.07"},
          {"label": "30-Jun-08", "value": "-19.00"},
          {"label": "31-Jul-08", "value": "8.23"},
          {"label": "31-Aug-08", "value": "1.11"},
          {"label": "30-Sep-08", "value": "-12.18"},
          {"label": "31-Oct-08", "value": "-27.18"},
          {"label": "30-Nov-08", "value": "-5.95"},
          {"label": "31-Dec-08", "value": "9.85"},
          {"label": "31-Jan-09", "value": "-3.62"},
          {"label": "28-Feb-09", "value": "-4.26"},
          {"label": "31-Mar-09", "value": "8.66"},
          {"label": "30-Apr-09", "value": "16.07"},
          {"label": "31-May-09", "value": "34.48"},
          {"label": "30-Jun-09", "value": "-2.87"},
          {"label": "31-Jul-09", "value": "8.78"},
          {"label": "31-Aug-09", "value": "2.15"},
          {"label": "30-Sep-09", "value": "7.41"},
          {"label": "31-Oct-09", "value": "-6.40"},
          {"label": "30-Nov-09", "value": "7.60"},
          {"label": "31-Dec-09", "value": "4.50"},
          {"label": "31-Jan-10", "value": "-3.98"},
          {"label": "28-Feb-10", "value": "-0.63"},
          {"label": "31-Mar-10", "value": "4.56"},
          {"label": "30-Apr-10", "value": "1.30"},
          {"label": "31-May-10", "value": "-3.17"},
          {"label": "30-Jun-10", "value": "4.83"},
          {"label": "31-Jul-10", "value": "1.38"},
          {"label": "31-Aug-10", "value": "1.46"},
          {"label": "30-Sep-10", "value": "8.74"},
          {"label": "31-Oct-10", "value": "1.03"},
          {"label": "30-Nov-10", "value": "-3.83"},
          {"label": "31-Dec-10", "value": "3.37"},
          {"label": "31-Jan-11", "value": "-10.43"},
          {"label": "28-Feb-11", "value": "-3.97"},
          {"label": "31-Mar-11", "value": "9.04"},
          {"label": "30-Apr-11", "value": "-0.22"},
          {"label": "31-May-11", "value": "-2.55"},
          {"label": "30-Jun-11", "value": "0.98"},
          {"label": "31-Jul-11", "value": "-2.01"},
          {"label": "31-Aug-11", "value": "-8.60"},
          {"label": "30-Sep-11", "value": "-1.39"},
          {"label": "31-Oct-11", "value": "6.02"},
          {"label": "30-Nov-11", "value": "-9.57"},
          {"label": "31-Dec-11", "value": "-5.60"},
          {"label": "31-Jan-12", "value": "13.57"},
          {"label": "29-Feb-12", "value": "4.76"},
          {"label": "31-Mar-12", "value": "-1.20"},
          {"label": "30-Apr-12", "value": "-1.02"},
          {"label": "31-May-12", "value": "-6.16"},
          {"label": "30-Jun-12", "value": "6.90"},
          {"label": "31-Jul-12", "value": "-0.84"},
          {"label": "31-Aug-12", "value": "0.22"},
          {"label": "30-Sep-12", "value": "9.14"},
          {"label": "31-Oct-12", "value": "-1.19"},
          {"label": "30-Nov-12", "value": "5.16"},
          {"label": "31-Dec-12", "value": "1.48"},
          {"label": "31-Jan-13", "value": "1.11"},
          {"label": "28-Feb-13", "value": "-6.58"},
          {"label": "31-Mar-13", "value": "-0.81"},
          {"label": "30-Apr-13", "value": "4.60"},
          {"label": "31-May-13", "value": "1.11"},
          {"label": "30-Jun-13", "value": "-3.46"},
          {"label": "31-Jul-13", "value": "-2.67"},
          {"label": "31-Aug-13", "value": "-4.56"},
          {"label": "30-Sep-13", "value": "5.29"},
          {"label": "31-Oct-13", "value": "9.47"},
          {"label": "30-Nov-13", "value": "-0.70"},
          {"label": "31-Dec-13", "value": "3.06"},
          {"label": "31-Jan-14", "value": "-4.12"},
          {"label": "28-Feb-14", "value": "3.05"},
          {"label": "31-Mar-14", "value": "7.82"},
          {"label": "30-Apr-14", "value": "0.60"},
          {"label": "31-May-14", "value": "10.52"},
          {"label": "30-Jun-14", "value": "6.63"},
          {"label": "31-Jul-14", "value": "0.60"},
          {"label": "31-Aug-14", "value": "2.80"},
          {"label": "30-Sep-14", "value": "0.93"},
          {"label": "31-Oct-14", "value": "4.26"},
          {"label": "30-Nov-14", "value": "3.49"},
          {"label": "31-Dec-14", "value": "-2.07"},
          {"label": "31-Jan-15", "value": "5.82"},
          {"label": "28-Feb-15", "value": "0.64"},
          {"label": "31-Mar-15", "value": "-3.10"},
          {"label": "30-Apr-15", "value": "-3.27"},
          {"label": "31-May-15", "value": "3.18"},
          {"label": "30-Jun-15", "value": "-0.67"},
          {"label": "31-Jul-15", "value": "3.25"},
          {"label": "31-Aug-15", "value": "-6.08"},
          {"label": "30-Sep-15", "value": "-0.26"},
          {"label": "31-Oct-15", "value": "1.65"},
          {"label": "30-Nov-15", "value": "-0.93"},
          {"label": "31-Dec-15", "value": "0.59"},
          {"label": "31-Jan-16", "value": "-5.71"},
          {"label": "29-Feb-16", "value": "-7.97"},
          {"label": "31-Mar-16", "value": "10.89"},
          {"label": "30-Apr-16", "value": "2.12"},
          {"label": "31-May-16", "value": "3.41"},
          {"label": "30-Jun-16", "value": "2.89"},
          {"label": "31-Jul-16", "value": "5.21"},
          {"label": "31-Aug-16", "value": "2.32"},
          {"label": "30-Sep-16", "value": "-1.20"},
          {"label": "31-Oct-16", "value": "1.41"},
          {"label": "30-Nov-16", "value": "-5.48"},
          {"label": "31-Dec-16", "value": "-1.36"},
          {"label": "31-Jan-17", "value": "5.70"},
          {"label": "28-Feb-17", "value": "4.62"},
          {"label": "31-Mar-17", "value": "3.90"},
          {"label": "30-Apr-17", "value": "2.79"},
          {"label": "31-May-17", "value": "1.71"},
          {"label": "30-Jun-17", "value": "0.05"},
          {"label": "31-Jul-17", "value": "5.81"},
          {"label": "31-Aug-17", "value": "-1.01"},
          {"label": "30-Sep-17", "value": "-1.02"},
          {"label": "31-Oct-17", "value": "6.49"},
          {"label": "30-Nov-17", "value": "0.07"},
          {"label": "31-Dec-17", "value": "3.67"},
          {"label": "31-Jan-18", "value": "2.21"},
          {"label": "28-Feb-18", "value": "-4.35"},
          {"label": "31-Mar-18", "value": "-3.64"},
          {"label": "30-Apr-18", "value": "6.57"},
          {"label": "31-May-18", "value": "-1.75"},
          {"label": "30-Jun-18", "value": "-1.48"},
          {"label": "31-Jul-18", "value": "5.58"},
          {"label": "31-Aug-18", "value": "3.69"},
          {"label": "30-Sep-18", "value": "-8.70"},
          {"label": "31-Oct-18", "value": "-3.90"},
          {"label": "30-Nov-18", "value": "4.11"},
          {"label": "31-Dec-18", "value": "0.71"},
          {"label": "31-Jan-19", "value": "-1.77"},
          {"label": "28-Feb-19", "value": "-0.41"},
          {"label": "31-Mar-19", "value": "7.98"},
          {"label": "30-Apr-19", "value": "0.01"},
          {"label": "31-May-19", "value": "1.56"},
          {"label": "30-Jun-19", "value": "-1.32"},
          {"label": "31-Jul-19", "value": "-6.09"},
          {"label": "31-Aug-19", "value": "-0.54"},
          {"label": "30-Sep-19", "value": "4.07"},
          {"label": "31-Oct-19", "value": "3.87"},
          {"label": "30-Nov-19", "value": "1.31"},
          {"label": "31-Dec-19", "value": "0.61"},
          {"label": "31-Jan-20", "value": "-0.10"},
          {"label": "29-Feb-20", "value": "-6.28"},
          {"label": "31-Mar-20", "value": "-24.03"},
          {"label": "30-Apr-20", "value": "14.53"},
          {"label": "31-May-20", "value": "-2.31"},
          {"label": "30-Jun-20", "value": "8.39"},
          {"label": "31-Jul-20", "value": "6.82"},
          {"label": "31-Aug-20", "value": "3.84"},
          {"label": "30-Sep-20", "value": "-0.28"},
          {"label": "31-Oct-20", "value": "2.70"},
          {"label": "30-Nov-20", "value": "11.94"},
          {"label": "31-Dec-20", "value": "7.48"},
          {"label": "31-Jan-21", "value": "-1.85"},
          {"label": "28-Feb-21", "value": "7.92"},
          {"label": "31-Mar-21", "value": "1.15"},
          {"label": "30-Apr-21", "value": "0.45"},
          {"label": "31-May-21", "value": "7.11"},
          {"label": "30-Jun-21", "value": "2.06"},
          {"label": "31-Jul-21", "value": "1.58"},
          {"label": "31-Aug-21", "value": "6.60"},
          {"label": "30-Sep-21", "value": "3.48"},
          {"label": "31-Oct-21", "value": "0.31"},
          {"label": "30-Nov-21", "value": "-2.83"},
          {"label": "31-Dec-21", "value": "2.42"},
          {"label": "31-Jan-22", "value": "-0.48"},
          {"label": "28-Feb-22", "value": "-3.95"},
          {"label": "31-Mar-22", "value": "4.14"},
          {"label": "30-Apr-22", "value": "-0.71"},
          {"label": "31-May-22", "value": "-4.23"},
          {"label": "30-Jun-22", "value": "-5.05"},
          {"label": "31-Jul-22", "value": "9.73"},
          {"label": "31-Aug-22", "value": "4.68"},
          {"label": "30-Sep-22", "value": "-3.21"},
          {"label": "31-Oct-22", "value": "4.09"},
          {"label": "30-Nov-22", "value": "3.42"},
          {"label": "31-Dec-22", "value": "-3.12"},
          {"label": "31-Jan-23", "value": "-3.30"},
          {"label": "28-Feb-23", "value": "-2.71"},
          {"label": "31-Mar-23", "value": "0.28"},
          {"label": "30-Apr-23", "value": "4.58"},
          {"label": "05-May-23", "value": "0.39"}
        ],
        "AnnualizedReturn": [
          {"label": "Since Inception", "value": "12.23"},
          {"label": "YTD", "value": "-0.97"},
          {"label": "1-Year", "value": "9.05"},
          {"label": "3-Year", "value": "26.26"},
          {"label": "5-Year", "value": "11.61"},
          {"label": "10-Year", "value": "13.82"},
          {"label": "15-Year", "value": "10.68"},
          {"label": "Live", "value": "3.29"}
        ],
        "SipReturn": [
          {"label": "Since Inception", "value": "12.06"},
          {"label": "YTD", "value": "218.34"},
          {"label": "1-Year", "value": "6.07"},
          {"label": "3-Year", "value": "13.28"},
          {"label": "5-Year", "value": "14.12"},
          {"label": "10-Year", "value": "13.13"},
          {"label": "15-Year", "value": "12.96"},
          {"label": "Live", "value": "54.06"}
        ]
      }
    ]
  }
};

dynamic investBasketStatic = {
  "data": {
    "basketOrderStr":
        "[{\"tradingsymbol\":\"HDFCBANK\",\"transaction_type\":\"BUY\",\"quantity\":30\",\"tag\":\"23000009\"},{\"tradingsymbol\":\"ITC\",\"transaction_type\":\"BUY\",\"quantity\":115\",\"tag\":\"23000009\"},{\"tradingsymbol\":\"HINDPETRO\",\"transaction_type\":\"BUY\",\"quantity\":195\",\"tag\":\"23000009\"},{\"tradingsymbol\":\"RELIANCE\",\"transaction_type\":\"BUY\",\"quantity\":2\",\"tag\":\"23000009\"}]",
    "gatewayName": "elever",
    "orderID": "23000009",
    "scToken": "",
    "transactionID": "TRE_MjAyMy0wNS0xOVQyMTowMjozMS43NzJa"
  },
  "status": "success"
};

class BasketApi {
  Future<ResponseModel<BasketModel>> getAllBasket() async {
    final response = await http.post(Uri.parse(ApiUrl.allBasket), headers: {
      'x-api-key': Keys.eleverApiKey,
      // 'Authorization': 'Bearer ${Keys.authToken}'
    });

    if (response.statusCode == 200) {
      BasketModel data = basketModelFromJson(response.body);
      return ResponseModel(
        status: 200,
        data: data,
      );
    } else {
      return ResponseModel(
        status: response.statusCode,
        data: BasketModel(),
      );
    }
  }

  Future<ResponseModel<BasketIntroModel>> basketIntroApi(
      {required String productId}) async {
    final response =
        await http.post(Uri.parse(ApiUrl.basketIntroApi + productId), headers: {
      'x-api-key': Keys.eleverApiKey,
    });
    if (response.statusCode == 200) {
      return ResponseModel(
        status: 200,
        data: BasketIntroModel.fromJson(json.decode(response.body)),
      );
    } else {
      return ResponseModel(
        status: 400,
        data: null,
      );
    }
    // return ResponseModel(
    //   status: 200,
    //   data: BasketIntroModel.fromJson(basketIntroStatic),
    // );
  }

  Future<ResponseModel<BasketPerfModel>> basketPerfApi() async {
    // final response = await http.post(Uri.parse(ApiUrl.orderBookApi), headers: {
    //   'apikey': Keys.apiKey,
    //   'Authorization': 'Bearer ${Keys.authToken}'
    // });
    // if (response.statusCode == 200) {
    //   return ResponseModel(
    //     status: 200,
    //     data: BasketIntroModel.fromJson(json.decode(basketIntroStatic)),
    //   );
    // } else {
    //   return ResponseModel(
    //     status: 400,
    //     data: null,
    //   );
    // }
    return ResponseModel(
      status: 200,
      data: BasketPerfModel.fromJson(basketPerfStatic),
    );
  }

  Future<ResponseModel<BasketProposalModel>> basketProposalApi({
    required String productID,
    required double investAmt,
  }) async {
    final response = await http.post(Uri.parse(ApiUrl.basketProposalApi),
        body: json.encode({
          "productID": productID,
          "investAmt": investAmt,
        }),
        headers: {
          'x-api-key': Keys.eleverApiKey,
          'Authorization': Keys.eleverAuthToken,
          "Content-Type": "application/json"
        });
    if (response.statusCode == 200) {
      return ResponseModel(
        status: 200,
        data: BasketProposalModel.fromJson(json.decode(response.body)),
      );
    } else {
      return ResponseModel(
        status: 400,
        data: null,
      );
    }
  }

  Future<ResponseModel<InvestInBasektModel>> investBasketApi(
      {required Map<String, dynamic> object}) async {
    final response = await http.post(Uri.parse(ApiUrl.investBasketApi),
        body: json.encode(object),
        headers: {
          'x-api-key': Keys.eleverApiKey,
          'Authorization': Keys.eleverAuthToken,
          "Content-Type": "application/json"
        });
    if (response.statusCode == 200) {
      return ResponseModel(
        status: 200,
        data: InvestInBasektModel.fromJson(investBasketStatic),
      );
    } else {
      return ResponseModel(
        status: 400,
        data: InvestInBasektModel.fromJson(investBasketStatic),
      );
    }
  }

  Future<ResponseModel<PlaceTradeModel>> placeTradeApi(
      {required String orderID}) async {
    final response = await http.post(Uri.parse(ApiUrl.placeTradeApi),
        body: json.encode({"orderID": orderID}),
        headers: {
          'x-api-key': Keys.eleverApiKey,
          'Authorization': Keys.eleverAuthToken,
          "Content-Type": "application/json"
        });
    if (response.statusCode == 200) {
      return ResponseModel(
        status: 200,
        data: PlaceTradeModel.fromJson(investBasketStatic),
      );
    } else {
      return ResponseModel(
        status: 400,
        data: PlaceTradeModel.fromJson(investBasketStatic),
      );
    }
  }

  Future<ResponseModel<PostTradeModel>> eleverPostTradeApi(
      {required Map<String, dynamic> object}) async {
    final response = await http.post(Uri.parse(ApiUrl.eleverPostTradeApi),
        body: json.encode(object),
        headers: {
          'x-api-key': Keys.eleverApiKey,
          'Authorization': Keys.eleverAuthToken,
          "Content-Type": "application/json"
        });
    if (response.statusCode == 200) {
      return ResponseModel(
        status: 200,
        data: PostTradeModel.fromJson(dummyData.activeData),
      );
    } else {
      return ResponseModel(
        status: 400,
        data: PostTradeModel.fromJson(dummyData.activeData),
      );
    }
  }
}
