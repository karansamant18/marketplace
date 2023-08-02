import 'package:flutter/material.dart';
import 'package:flutter_mobile_bx/const/color.dart';
import 'package:flutter_mobile_bx/const/image.dart';
import 'package:flutter_mobile_bx/view/buy_stock/buy_stock_screen.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:syncfusion_flutter_charts/charts.dart';

class ChartData {
  ChartData(this.x, this.y);
  final int x;
  final double y;
}

class StockDetailScreen extends StatefulWidget {
  const StockDetailScreen({super.key});

  @override
  State<StockDetailScreen> createState() => _StockDetailScreenState();
}

class _StockDetailScreenState extends State<StockDetailScreen> {
  bool isMoreDetail = false;
  final List<ChartData> chartData = [
    ChartData(2010, 35),
    ChartData(2011, 28),
    ChartData(2012, 34),
    ChartData(2013, 32),
    ChartData(2014, 40)
  ];
  final List<ChartData> chart2Data = [
    ChartData(2010, 39),
    ChartData(2011, 88),
    ChartData(2012, 90),
    ChartData(2013, 63),
    ChartData(2014, 40)
  ];
  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Scaffold(
      backgroundColor: ConstColor.violet42Color,
      appBar: _buildAppBar(context),
      body: Stack(
        alignment: Alignment.bottomCenter,
        children: [
          SingleChildScrollView(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                SizedBox(height: size.height * 0.015),
                Padding(
                  padding: EdgeInsets.symmetric(horizontal: size.width * 0.04),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      _buildStockName(size),
                      SizedBox(height: size.height * 0.02),
                      _buildMoreDetailView(size),
                      SizedBox(height: size.height * 0.02),
                      Text(
                        'WHY THIS STOCK?',
                        style: TextStyle(
                          color: ConstColor.violetE4Color,
                          fontSize: size.height * 0.017,
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                      SizedBox(height: size.height * 0.017),
                      Padding(
                        padding: EdgeInsets.only(right: size.width * 0.07),
                        child: Text(
                          "Lorem ipsum dolor sit amet, consetetur sadipscing elitr, sed diam nonumy eirmod tempor invidunt ut labore et dolore magna aliquyam erat, sed diam voluptua. At vero eos et accusam et justo duo dolores et ea rebum. Stet clita kasd gubergren, no sea takimata sanctus est Lorem ipsum dolor sit.",
                          style: TextStyle(
                            color: ConstColor.whiteColor.withOpacity(0.7),
                            fontSize: size.height * 0.017,
                            fontWeight: FontWeight.w400,
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
                SizedBox(height: size.height * 0.05),
                _buildChart(),
                SizedBox(height: size.height * 0.05),
                Padding(
                  padding: EdgeInsets.symmetric(horizontal: size.width * 0.04),
                  child: _buildCratedName(size),
                ),
                SizedBox(height: size.height * 0.1),
              ],
            ),
          ),
          Padding(
            padding: EdgeInsets.symmetric(
                vertical: size.width * 0.05, horizontal: size.width * 0.04),
            child: _buildButton(
              size: size,
              title: "Buy Now",
              image: ConstImage.flashIcon,
              onTap: () {
                Navigator.of(context).push(MaterialPageRoute(
                  builder: (context) => BuyStockScreen(),
                ));
              },
            ),
          )
        ],
      ),
    );
  }

  //Build Button View
  Widget _buildButton(
      {required Size size,
      required String title,
      required String image,
      required void Function() onTap}) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(50),
          gradient: LinearGradient(
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
            colors: [
              Color(0xffE13662),
              Color(0xffEB4954),
              Color(0xffD346F0),
              Color(0xffD346F0),
            ],
          ),
        ),
        padding: EdgeInsets.symmetric(
          vertical: size.height * 0.018,
          horizontal: size.width * 0.04,
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Padding(
              padding: EdgeInsets.symmetric(
                horizontal: size.width * 0.04,
              ),
              child: Text(
                title,
                style: TextStyle(
                  color: ConstColor.whiteColor,
                  fontSize: size.height * 0.02,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
            SvgPicture.asset(image)
          ],
        ),
      ),
    );
  }

  Widget _buildChart() {
    return SfCartesianChart(
      plotAreaBorderWidth: 0,
      primaryXAxis: NumericAxis(
        majorGridLines: MajorGridLines(width: 0),
        axisLine: AxisLine(width: 0),
      ),
      primaryYAxis: NumericAxis(
        majorGridLines: MajorGridLines(width: 0),
        axisLine: AxisLine(width: 0),
      ),
      series: <ChartSeries>[
        // Renders line chart
        LineSeries<ChartData, int>(
            dataSource: chartData,
            xValueMapper: (ChartData data, _) => data.x,
            yValueMapper: (ChartData data, _) => data.y),
        LineSeries<ChartData, int>(
            dataSource: chart2Data,
            xValueMapper: (ChartData data, _) => data.x,
            yValueMapper: (ChartData data, _) => data.y)
      ],
    );
  }

  Widget _buildCratedName(Size size) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'Created By',
              style: TextStyle(
                color: ConstColor.greyColor,
                fontSize: size.height * 0.019,
                fontWeight: FontWeight.w600,
              ),
            ),
            SizedBox(height: size.height * 0.01),
            Text(
              'Abhishek Desai',
              style: TextStyle(
                color: ConstColor.whiteColor,
                fontSize: size.height * 0.02,
                fontWeight: FontWeight.w600,
              ),
            )
          ],
        ),
        CircleAvatar()
      ],
    );
  }

  Widget _buildMoreDetailView(Size size) {
    return Column(
      children: [
        isMoreDetail
            ? const Divider(color: ConstColor.whiteColor)
            : const SizedBox(),
        isMoreDetail
            ? AnimatedContainer(
                duration: const Duration(seconds: 1),
                width: size.width,
                height: size.height / 4.9,
                child: GridView.builder(
                  gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                      crossAxisCount: 3, childAspectRatio: 2 / 1.5),
                  padding: EdgeInsets.symmetric(vertical: size.height * 0.02),
                  itemCount: 5,
                  shrinkWrap: true,
                  physics: const NeverScrollableScrollPhysics(),
                  itemBuilder: (context, index) {
                    return Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          'Segment',
                          style: TextStyle(
                            color: ConstColor.greyColor.withOpacity(0.7),
                            fontSize: size.height * 0.016,
                            fontWeight: FontWeight.w400,
                          ),
                        ),
                        SizedBox(height: size.height * 0.015),
                        Text(
                          'FNO',
                          style: TextStyle(
                            color: ConstColor.whiteColor,
                            fontSize: size.height * 0.016,
                            fontWeight: FontWeight.w500,
                          ),
                        )
                      ],
                    );
                  },
                ),
              )
            : const SizedBox(),
        SizedBox(height: size.height * 0.015),
        GestureDetector(
          onTap: () {
            setState(() {
              isMoreDetail = !isMoreDetail;
            });
          },
          child: Container(
            padding: EdgeInsets.symmetric(vertical: size.width * 0.03),
            child: Row(
              children: [
                Text(
                  'More details',
                  style: TextStyle(
                    color: ConstColor.whiteColor,
                    fontSize: size.height * 0.016,
                    fontWeight: FontWeight.w400,
                  ),
                ),
                Icon(
                  isMoreDetail
                      ? Icons.keyboard_arrow_up_rounded
                      : Icons.keyboard_arrow_down_rounded,
                  color: ConstColor.whiteColor,
                )
              ],
            ),
          ),
        ),
      ],
    );
  }

  Widget _buildStockName(Size size) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          children: [
            Text(
              'BOSCHLTDs',
              style: TextStyle(
                color: ConstColor.whiteColor,
                fontSize: size.height * 0.03,
                fontWeight: FontWeight.bold,
              ),
            ),
            SizedBox(width: size.width * 0.03),
            Text(
              '(14.21%)',
              style: TextStyle(
                color: ConstColor.greenColor75,
                fontSize: size.height * 0.016,
                fontWeight: FontWeight.w500,
              ),
            ),
            SizedBox(width: size.width * 0.01),
            Icon(
              Icons.keyboard_arrow_up_rounded,
              color: ConstColor.greenColor75,
              size: size.height * 0.016,
            ),
          ],
        ),
        SizedBox(height: size.height * 0.01),
        Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            Text(
              'Bosch Limited',
              style: TextStyle(
                color: ConstColor.whiteColor.withOpacity(0.5),
                fontSize: size.height * 0.016,
                fontWeight: FontWeight.w400,
              ),
            ),
            SizedBox(width: size.width * 0.1),
            Text(
              '23 March 2023',
              style: TextStyle(
                color: ConstColor.whiteColor,
                fontSize: size.height * 0.016,
                fontWeight: FontWeight.w400,
              ),
            ),
            SizedBox(width: size.width * 0.1),
            Text(
              '14:42',
              style: TextStyle(
                color: ConstColor.whiteColor,
                fontSize: size.height * 0.016,
                fontWeight: FontWeight.w400,
              ),
            ),
          ],
        ),
      ],
    );
  }

  AppBar _buildAppBar(BuildContext context) {
    return AppBar(
      backgroundColor: ConstColor.violet42Color,
      elevation: 0,
      leading: IconButton(
        icon: const Icon(Icons.arrow_back_ios_rounded),
        color: ConstColor.whiteColor,
        onPressed: () {
          Navigator.of(context).pop();
        },
      ),
    );
  }
}
