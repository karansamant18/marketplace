import 'package:flutter/material.dart';
import 'package:flutter_mobile_bx/const/color.dart';
import 'package:flutter_mobile_bx/view/stock_card/stock_card_view.dart';
import 'package:flutter_mobile_bx/view/x_advice/controller/advisor_controller.dart';
import 'package:flutter_mobile_bx/view/x_advice/model/get_advisor_call_model.dart';
import 'package:flutter_mobile_bx/view/x_advice/model/get_advisor_model.dart';
import 'package:syncfusion_flutter_charts/charts.dart';

class PastPerfomanceTab extends StatefulWidget {
  const PastPerfomanceTab(
      {super.key, this.advisoryResultsList, this.advisorId});
  final List<AdvisoryResults>? advisoryResultsList;
  final String? advisorId;

  @override
  State<PastPerfomanceTab> createState() => _PastPerfomanceTabState();
}

class _PastPerfomanceTabState extends State<PastPerfomanceTab> {
  late List<ChartData> data = [];
  late TooltipBehavior _tooltip;

  AdvisorController advisorController = AdvisorController();
  List<GetAdvisorListModel>? advisorsList;
  double totalHits = 0;
  double totalMisses = 0;

  @override
  void initState() {
    if (widget.advisorId != null && widget.advisorId != "") {
      advisorController.getAdvisorListController().then((value) {
        advisorsList = [
          value.data!.firstWhere(
              (element) => element.blinkxAdvisorId == widget.advisorId)
        ];
        setData();
      });
    } else {
      advisorController.getAdvisorListController().then((value) {
        advisorsList = value.data!;
        setData();
      });
    }
    _tooltip = TooltipBehavior(enable: true);
    super.initState();
  }

  setData() {
    totalHits = advisorsList!.fold(0, (sum, item) => sum + item.callsHit!);
    totalMisses = advisorsList!.fold(0, (sum, item) => sum + item.callsMiss!);
    data = [
      ChartData('Hits', totalHits, ConstColor.greenColor96),
      // ChartData('Education', 38, ConstColor.yellowColor27),
      ChartData('Misses', totalMisses, ConstColor.lightOrange),
      // ChartData('Manufacture', 52, ConstColor.violetCAColor),
    ];
  }

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        _buildChartView(size),
        _buildListView(size),
      ],
    );
  }

  Widget _buildListView(Size size) {
    if (widget.advisoryResultsList!.isEmpty) {
      return const SizedBox(
        child: Center(
          child: Text(
            'No Data Found',
            style: TextStyle(color: ConstColor.whiteColor),
          ),
        ),
      );
    } else {
      return SizedBox(
        height: size.height / 2,
        child: ListView.builder(
          itemCount: widget.advisoryResultsList!.length,
          shrinkWrap: true,
          padding: EdgeInsets.zero,
          itemBuilder: (context, index) {
            var advisoryResultsData = widget.advisoryResultsList![index];
            return StockCardView(
              advisoryResults: advisoryResultsData,
            );
          },
        ),
      );
    }
  }

  Widget _buildChartView(Size size) {
    return Row(
      children: [
        SizedBox(
          height: size.height * 0.18,
          width: size.width / 2.3,
          child: SfCircularChart(
            tooltipBehavior: _tooltip,
            series: [
              DoughnutSeries<ChartData, String>(
                dataSource: data,
                xValueMapper: (ChartData data, _) => data.x,
                yValueMapper: (ChartData data, _) => data.y,
                name: 'Performance',
                pointColorMapper: (ChartData data, _) => data.color,
              )
            ],
          ),
        ),
        Expanded(
          child: Column(
            children: [
              Row(
                // mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  _buildChatValue(
                    size: size,
                    title: 'Hits',
                    value: totalHits.toString(),
                    valueColor: ConstColor.greenColor96,
                  ),
                  SizedBox(width: size.width * 0.1),
                  _buildChatValue(
                    size: size,
                    title: 'Misses',
                    value: totalMisses.toString(),
                    valueColor: ConstColor.lightOrange,
                  ),
                ],
              ),
              SizedBox(height: size.height * 0.015),
              Row(
                // mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  _buildChatValue(
                    size: size,
                    title: 'Total calls',
                    value: (totalHits + totalMisses).toString(),
                    valueColor: ConstColor.yellowColor27,
                  ),
                  SizedBox(width: size.width * 0.06),
                  _buildChatValue(
                    size: size,
                    title: 'Accuracy',
                    value: (100 * totalHits / (totalHits + totalMisses))
                        .toStringAsFixed(1),
                    valueColor: ConstColor.violetCAColor,
                  ),
                ],
              ),
            ],
          ),
        )
      ],
    );
  }

  Widget _buildChatValue({
    required Size size,
    required String title,
    required String value,
    required Color valueColor,
  }) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          title,
          style: TextStyle(
            color: ConstColor.whiteColor.withOpacity(0.7),
            fontSize: size.height * 0.015,
            fontWeight: FontWeight.w400,
          ),
        ),
        Text(
          title.toLowerCase() == 'accuracy'
              ? '${value == 'NaN' ? 0 : value}%'
              : value.replaceAll(".0", ""),
          style: TextStyle(
            color: valueColor,
            fontSize: size.height * 0.03,
            fontWeight: FontWeight.bold,
          ),
        )
      ],
    );
  }
}

class ChartData {
  ChartData(this.x, this.y, [this.color]);

  final String x;
  final double y;
  final Color? color;
}
