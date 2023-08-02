// To parse this JSON data, do
//
//     final orderModel = orderModelFromJson(jsonString);

import 'dart:convert';

OrderModel orderModelFromJson(String str) =>
    OrderModel.fromJson(json.decode(str));

class OrderModel {
  bool status;
  String message;
  String errorcode;
  dynamic emsg;
  List<Order> data;

  OrderModel({
    required this.status,
    required this.message,
    required this.errorcode,
    this.emsg,
    required this.data,
  });

  factory OrderModel.fromJson(Map<String, dynamic> json) => OrderModel(
        status: json["status"],
        message: json["message"],
        errorcode: json["errorcode"],
        emsg: json["emsg"],
        data: json["data"] != null
            ? List<Order>.from(json["data"].map((x) => Order.fromJson(x)))
            : [],
      );
}

class Order {
  String? variety;
  String? ordertype;
  String? producttype;
  String? duration;
  String? price;
  String? triggerprice;
  String? quantity;
  String? disclosedquantity;
  String? squareoff;
  String? stoploss;
  String? trailingstoploss;
  String? tradingsymbol;
  String? transactiontype;
  String? exchange;
  String? symboltoken;
  String? instrumenttype;
  String? strikeprice;
  String? optiontype;
  String? expirydate;
  String? lotsize;
  String? cancelsize;
  String? averageprice;
  String? filledshares;
  String? unfilledshares;
  String? orderid;
  String? exchorderid;
  String? text;
  String? status;
  String? orderstatus;
  String? updatetime;
  String? exseg;
  String? syomorderid;
  String? exchtime;
  String? exchorderupdatetime;
  String? fillid;
  String? filltime;
  String? parentorderid;
  String? remarks;
  String? specialordertype;
  String? gtdValdate;
  double? ltp;

  Order({
    required this.variety,
    required this.ordertype,
    required this.producttype,
    required this.duration,
    required this.price,
    required this.triggerprice,
    required this.quantity,
    required this.disclosedquantity,
    required this.squareoff,
    required this.stoploss,
    required this.trailingstoploss,
    required this.tradingsymbol,
    required this.transactiontype,
    required this.exchange,
    required this.symboltoken,
    required this.instrumenttype,
    required this.strikeprice,
    required this.optiontype,
    required this.expirydate,
    required this.lotsize,
    required this.cancelsize,
    required this.averageprice,
    required this.filledshares,
    required this.unfilledshares,
    required this.orderid,
    required this.exchorderid,
    required this.text,
    required this.status,
    required this.orderstatus,
    required this.updatetime,
    required this.exseg,
    required this.syomorderid,
    required this.exchtime,
    required this.exchorderupdatetime,
    required this.fillid,
    required this.filltime,
    required this.parentorderid,
    required this.remarks,
    required this.specialordertype,
    required this.gtdValdate,
    required this.ltp,
  });

  factory Order.fromJson(Map<String, dynamic> json) => Order(
        variety: json["variety"],
        ordertype: json["ordertype"],
        producttype: json["producttype"],
        duration: json["duration"],
        price: json["price"],
        triggerprice: json["triggerprice"],
        quantity: json["quantity"],
        disclosedquantity: json["disclosedquantity"],
        squareoff: json["squareoff"],
        stoploss: json["stoploss"],
        trailingstoploss: json["trailingstoploss"],
        tradingsymbol: json["tradingsymbol"],
        transactiontype: json["transactiontype"],
        exchange: json["exchange"],
        symboltoken: json["symboltoken"],
        instrumenttype: json["instrumenttype"],
        strikeprice: json["strikeprice"],
        optiontype: json["optiontype"],
        expirydate: json["expirydate"],
        lotsize: json["lotsize"],
        cancelsize: json["cancelsize"],
        averageprice: json["averageprice"],
        filledshares: json["filledshares"],
        unfilledshares: json["unfilledshares"],
        orderid: json["orderid"],
        exchorderid: json["exchorderid"],
        text: json["text"],
        status: json["status"] == 'received'
            ? 'open'
            : json["status"] == 'cancelled'
                ? 'rejected'
                : json["status"],
        orderstatus: json["orderstatus"],
        updatetime: json["updatetime"],
        exseg: json["exseg"],
        syomorderid: json["syomorderid"],
        exchtime: json["exchtime"],
        exchorderupdatetime: json["exchorderupdatetime"],
        fillid: json["fillid"],
        filltime: json["filltime"],
        parentorderid: json["parentorderid"],
        remarks: json["remarks"],
        specialordertype: json["specialordertype"],
        gtdValdate: json["gtdValdate"],
        ltp: 0.00,
      );
}
