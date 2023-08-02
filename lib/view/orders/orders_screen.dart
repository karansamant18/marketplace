import 'package:flutter/material.dart';
import 'package:flutter_mobile_bx/const/color.dart';
import 'package:flutter_mobile_bx/const/styles.dart';
import 'package:flutter_mobile_bx/helpers/common_functions.dart';
import 'package:flutter_mobile_bx/helpers/sizes.dart';
import 'package:flutter_mobile_bx/helpers/user_auth.dart';
import 'package:flutter_mobile_bx/view/auth/screen/widget/auth_card.dart';
import 'package:flutter_mobile_bx/view/bottom_bar.dart';
import 'package:flutter_mobile_bx/view/orders/controller/orders_controller.dart';
import 'package:flutter_mobile_bx/view/orders/model/orders_model.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:provider/provider.dart';

class OrdersScreen extends StatefulWidget {
  const OrdersScreen({super.key});

  @override
  State<OrdersScreen> createState() => _OrdersScreenState();
}

class _OrdersScreenState extends State<OrdersScreen>
    with SingleTickerProviderStateMixin {
  String selectedCategory = 'complete';
  TextEditingController searchController = TextEditingController();
  Map<String, String> orderStatusMap = {
    'pending': 'open',
    'executed': 'complete',
    'rejected': 'rejected',
    'cancelled': 'cancelled',
  };
  // TabController? _tabController;
  OrderController orderController = OrderController();
  @override
  void initState() {
    // _tabController = TabController(
    //   length: 2,
    //   vsync: this,
    // );
    orderController = Provider.of<OrderController>(context, listen: false);
    if (UserAuth().isJmClient() && UserAuth().isLoggedInBlinkX()) {
      orderController.orderBookController();
    }
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Scaffold(
      backgroundColor: Colors.transparent,
      body: Container(
        decoration: BoxDecoration(
          gradient: LinearGradient(colors: ConstColor.mainThemeGradient),
        ),
        height: hh(),
        width: ww(),
        child: Container(
          // padding: const EdgeInsets.fromLTRB(30, 30, 30, 0),
          child: Column(
            // mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              GestureDetector(
                onTap: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => BottomBarScreen(),
                    ),
                  );
                },
                child: Container(
                  padding: const EdgeInsets.fromLTRB(30, 50, 30, 10),
                  child: Icon(
                    Icons.arrow_back,
                    size: size.height * 0.035,
                    color: ConstColor.whiteColor,
                  ),
                ),
              ),
              Expanded(
                child: Container(
                  padding: const EdgeInsets.fromLTRB(30, 30, 30, 0),
                  decoration: const BoxDecoration(
                    color: Color(0xFF000000),
                    borderRadius: BorderRadius.only(
                      topLeft: Radius.circular(25),
                      topRight: Radius.circular(25),
                    ),
                  ),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      // sh(height: 35),
                      Text(
                        "Orders",
                        style: TextStyle(
                          color: ConstColor.whiteColor,
                          fontSize: hh() * 0.035,
                          // fontWeight: FontWeight.bold,
                        ),
                      ),
                      sh(height: 30),
                      buildFilters(size),
                      sh(height: 30),
                      buildSearch(size),
                      sh(height: 50),
                      UserAuth().isJmClient()
                          ? UserAuth().isLoggedInBlinkX()
                              ? buildOrders(size)
                              : Padding(
                                  padding: EdgeInsets.only(top: hh() / 20),
                                  child: AuthCard.loginCard(context,
                                      nextPage: OrdersScreen()),
                                )
                          : Padding(
                              padding: EdgeInsets.only(top: hh() / 20),
                              child: AuthCard.createAccountCard(context),
                            )
                    ],
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget buildOrders(Size size) {
    return Consumer<OrderController>(builder: (context, value, child) {
      if (value.orderModel.data == null) {
        return const Expanded(
          child: SizedBox(
            // height: size.height * 0.618,
            child: Center(child: CircularProgressIndicator()),
          ),
        );
      } else {
        List<Order> ordersList = value.orderModel.data!.data
            .where((element) =>
                element.status!.toLowerCase() == selectedCategory.toLowerCase())
            .toList();
        if (searchController.text != "" && searchController.text.isNotEmpty) {
          ordersList = ordersList
              .where((element) => element.tradingsymbol!
                  .toLowerCase()
                  .contains(searchController.text.toLowerCase()))
              .toList();
        }
        if (ordersList.isNotEmpty) {
          return Expanded(
            child: SingleChildScrollView(
              child: ListView.builder(
                padding: const EdgeInsets.all(0),
                shrinkWrap: true,
                itemCount: ordersList.length,
                physics: const NeverScrollableScrollPhysics(),
                itemBuilder: (context, index) {
                  return orderCardView(size, ordersList, index);
                },
              ),
            ),
          );
        } else {
          return Expanded(
            child: SizedBox(
              // height: size.height * 0.618,
              child: Center(
                  child: Text(
                'No ${selectedCategory.toString().capitalize()} Orders',
                style: const TextStyle(color: ConstColor.whiteColor),
              )),
            ),
          );
        }
      }
    });
  }

  Widget orderCardView(Size size, List<Order> orders, int index) {
    return Container(
      decoration: const BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.all(
          Radius.circular(15),
        ),
      ),
      padding: const EdgeInsets.all(20.0),
      margin: const EdgeInsets.only(bottom: 15.0),
      child: Column(
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                orders[index].transactiontype.toString(),
                style: sBodySmall.copyWith(
                  fontSize: 11,
                  color: orders[index].transactiontype == 'SELL'
                      ? Colors.red
                      : Colors.green,
                ),
              ),
              selectedCategory == 'rejected'
                  ? Text(
                      orders[index]
                          .orderstatus
                          .toString()
                          .split(" ")[0]
                          .capitalize(),
                      style:
                          sBodySmall.copyWith(fontSize: 11, color: Colors.red),
                    )
                  : Container(),
              // Text(orders[index].status.toString()),
            ],
          ),
          sh(),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              SizedBox(
                width: size.width * 0.3,
                child: Text(
                  orders[index].tradingsymbol.toString(),
                  softWrap: true,
                ),
              ),
              Text(
                  "${orders[index].quantity.toString()}/${orders[index].quantity.toString()} @${orders[index].averageprice.toString()}"),
            ],
          ),
          sh(),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                  "${orders[index].exchange.toString()} | ${orders[index].producttype.toString()}"),
              Row(
                children: [
                  Text("LTP ${orders[index].ltp.toString()}"),
                  // sw(),
                  // const RotatedBox(
                  //   quarterTurns: 2 <= 5 ? 3 : 1,
                  //   child: Icon(
                  //     2 <= 5 ? Icons.arrow_forward_ios : Icons.arrow_back_ios,
                  //     size: 14,
                  //     color: 2 <= 5 ? Colors.green : Colors.red,
                  //   ),
                  // ),
                ],
              ),
            ],
          ),
          selectedCategory == 'open'
              ? Container(
                  padding: EdgeInsets.only(top: 10),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.end,
                    children: [
                      GestureDetector(
                        onTap: () {
                          orderController
                              .cancelOrderController(
                                  orderId: orders[index].orderid!)
                              .then((value) {
                            if (value.data == true) {
                              Fluttertoast.showToast(
                                msg: 'Order Cancelled Successfully',
                                toastLength: Toast.LENGTH_SHORT,
                                gravity: ToastGravity.BOTTOM,
                                timeInSecForIosWeb: 1,
                                backgroundColor: Colors.green,
                                textColor: Colors.white,
                                fontSize: 16.0,
                              );
                              orderController.orderBookController();
                            } else {
                              Fluttertoast.showToast(
                                msg: 'Failed to Cancel',
                                toastLength: Toast.LENGTH_SHORT,
                                gravity: ToastGravity.BOTTOM,
                                timeInSecForIosWeb: 1,
                                backgroundColor: Colors.red,
                                textColor: Colors.white,
                                fontSize: 16.0,
                              );
                            }
                          });
                        },
                        child: const Text(
                          "Cancel",
                          style: TextStyle(
                            color: Colors.red,
                            fontSize: 13,
                            decoration: TextDecoration.underline,
                          ),
                        ),
                      )
                    ],
                  ),
                )
              : Container(),
          // Text(orders[index].text.toString())
        ],
      ),
    );
  }

  Widget buildSearch(Size size) {
    return Container(
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(30),
      ),
      child: Row(
        children: [
          SizedBox(
            width: size.width * 0.85,
            height: size.height * 0.045,
            child: TextFormField(
              autofocus: false,
              controller: searchController,
              cursorColor: const Color(0xFF6D6D6D),
              style: const TextStyle(
                color: Color(0xFF6D6D6D),
              ),
              onChanged: (value) {
                setState(() {});
              },
              cursorHeight: 20,
              keyboardType: TextInputType.text,
              decoration: InputDecoration(
                border: InputBorder.none,
                prefixIconColor: const Color(0xFF6D6D6D),
                prefixIcon: const Padding(
                  padding: EdgeInsets.all(0),
                  child: Icon(Icons.search),
                ),
                contentPadding: EdgeInsets.symmetric(
                  horizontal: size.width * 0.05,
                  vertical: size.height * 0.003,
                ),
                hintText: 'Search for a symbol/name',
                hintStyle: const TextStyle(
                  color: Color(0xFF6D6D6D),
                  fontSize: 14,
                ),
              ),
            ),
          )
        ],
      ),
    );
  }

  Widget buildFilters(Size size) {
    return Container(
      height: size.height * 0.04,
      width: size.width,
      child: ListView(
        scrollDirection: Axis.horizontal,
        children: [
          categoryPill(
            size: size,
            name: 'Executed',
            index: 0,
          ),
          sw(width: 50),
          categoryPill(
            size: size,
            name: 'Pending',
            index: 1,
          ),
          sw(width: 50),
          categoryPill(
            size: size,
            name: 'Rejected',
            index: 2,
          ),
          // sw(width: 50),
          // categoryPill(
          //   size: size,
          //   name: 'Cancelled',
          //   index: 2,
          // ),
        ],
      ),
    );
  }

  Widget categoryPill({
    required String name,
    required int index,
    required Size size,
  }) {
    return GestureDetector(
      onTap: () {
        setState(() {
          searchController.text = "";
          selectedCategory = orderStatusMap[name.toLowerCase()].toString();
        });
      },
      child: Container(
        decoration: BoxDecoration(
            color: selectedCategory == orderStatusMap[name.toLowerCase()]
                ? Colors.white
                : null,
            border: Border.all(color: Colors.white.withOpacity(0.5)),
            borderRadius: const BorderRadius.all(Radius.circular(20.0))),
        padding: EdgeInsets.symmetric(
          horizontal: size.width * 0.035,
          vertical: size.width * 0.015,
        ),
        child: Text(
          name,
          style: TextStyle(
            fontSize: 13,
            color: selectedCategory == orderStatusMap[name.toLowerCase()]
                ? const Color.fromARGB(255, 122, 15, 144)
                : Colors.white.withOpacity(0.5),
          ),
        ),
      ),
    );
  }
}
