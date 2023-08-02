// To parse this JSON data, do
//
//     final positionsModel = positionsModelFromJson(jsonString);

import 'dart:convert';

PositionsModel positionsModelFromJson(String str) =>
    PositionsModel.fromJson(json.decode(str));

// String positionsModelToJson(PositionsModel data) => json.encode(data.toJson());
class PositionsModel {
  bool? status;
  String? message;
  String? errorcode;
  String? emsg;
  List<Position>? data;

  PositionsModel(
      {this.status, this.message, this.errorcode, this.emsg, this.data});

  PositionsModel.fromJson(Map<String, dynamic> json) {
    status = json['status'];
    message = json['message'];
    errorcode = json['errorcode'];
    emsg = json['emsg'] ?? "";
    data = <Position>[];
    if (json['data'] != null) {
      json['data'].forEach((v) {
        data!.add(new Position.fromJson(v));
      });
    }
  }
}

class Position {
  String? exchange;
  String? symboltoken;
  String? producttype;
  String? tradingsymbol;
  String? symbolname;
  String? instrumenttype;
  String? priceden;
  String? pricenum;
  String? genden;
  String? gennum;
  String? precision;
  String? multiplier;
  String? boardlotsize;
  String? buyqty;
  String? sellqty;
  String? buyamount;
  String? sellamount;
  String? symbolgroup;
  String? strikeprice;
  String? optiontype;
  String? expirydate;
  String? lotsize;
  String? cfbuyqty;
  String? cfsellqty;
  String? cfbuyamount;
  String? cfsellamount;
  String? buyavgprice;
  String? sellavgprice;
  String? avgnetprice;
  double? avgPrice;
  String? netvalue;
  String? netqty;
  String? totalbuyvalue;
  String? totalsellvalue;
  String? cfbuyavgprice;
  String? cfsellavgprice;
  String? totalbuyavgprice;
  String? totalsellavgprice;
  String? fillbuyquantity;
  String? fillsellquantity;
  String? closedquantity;
  String? netprice;
  double? ltp;
  double? invested;

  Position({
    this.exchange,
    this.symboltoken,
    this.producttype,
    this.tradingsymbol,
    this.symbolname,
    this.instrumenttype,
    this.priceden,
    this.pricenum,
    this.genden,
    this.gennum,
    this.precision,
    this.multiplier,
    this.boardlotsize,
    this.buyqty,
    this.sellqty,
    this.buyamount,
    this.sellamount,
    this.symbolgroup,
    this.strikeprice,
    this.optiontype,
    this.expirydate,
    this.lotsize,
    this.cfbuyqty,
    this.cfsellqty,
    this.cfbuyamount,
    this.cfsellamount,
    this.avgPrice,
    this.buyavgprice,
    this.sellavgprice,
    this.avgnetprice,
    this.netvalue,
    this.netqty,
    this.totalbuyvalue,
    this.totalsellvalue,
    this.cfbuyavgprice,
    this.cfsellavgprice,
    this.totalbuyavgprice,
    this.totalsellavgprice,
    this.fillbuyquantity,
    this.fillsellquantity,
    this.closedquantity,
    this.netprice,
    this.ltp,
    this.invested,
  });

  Position.fromJson(Map<String, dynamic> json) {
    exchange = json['exchange'];
    symboltoken = json['symboltoken'];
    producttype = json['producttype'];
    tradingsymbol = json['tradingsymbol'];
    symbolname = json['symbolname'];
    instrumenttype = json['instrumenttype'];
    priceden = json['priceden'];
    pricenum = json['pricenum'];
    genden = json['genden'];
    gennum = json['gennum'];
    precision = json['precision'];
    multiplier = json['multiplier'];
    boardlotsize = json['boardlotsize'];
    buyqty = json['buyqty'];
    sellqty = json['sellqty'];
    buyamount = json['buyamount'].toString().replaceAll(',', '');
    sellamount = json['sellamount'].toString().replaceAll(',', '');
    symbolgroup = json['symbolgroup'];
    strikeprice = json['strikeprice'].toString().replaceAll(',', '');
    optiontype = json['optiontype'];
    expirydate = json['expirydate'];
    lotsize = json['lotsize'];
    cfbuyqty = json['cfbuyqty'];
    cfsellqty = json['cfsellqty'];
    cfbuyamount = json['cfbuyamount'];
    cfsellamount = json['cfsellamount'];
    buyavgprice = json['buyavgprice'].toString().replaceAll(',', '');
    sellavgprice = json['sellavgprice'].toString().replaceAll(',', '');
    avgnetprice = json['avgnetprice'].toString().replaceAll(',', '');
    netvalue = json['netvalue'].toString().replaceAll(',', '');
    netqty = json['buyqty']; // need to update based on logic later
    totalbuyvalue = json['totalbuyvalue'].toString().replaceAll(',', '');
    totalsellvalue = json['totalsellvalue'].toString().replaceAll(',', '');
    cfbuyavgprice = json['cfbuyavgprice'].toString().replaceAll(',', '');
    cfsellavgprice = json['cfsellavgprice'].toString().replaceAll(',', '');
    totalbuyavgprice = json['totalbuyavgprice'].toString().replaceAll(',', '');
    totalsellavgprice =
        json['totalsellavgprice'].toString().replaceAll(',', '');
    fillbuyquantity = json['fillbuyquantity'];
    fillsellquantity = json['fillsellquantity'];
    closedquantity = json['closedquantity'];
    netprice = json['netprice'].toString().replaceAll(',', '');
    ltp = 0.0;
    avgPrice = double.parse(buyavgprice!);
    invested = int.parse(netqty!) * double.parse(avgPrice!.toString());
  }
}
