import 'package:flutter/material.dart';
import 'package:flutter_mobile_bx/view/basket/model/basket_perf_model.dart';
import 'package:syncfusion_flutter_charts/charts.dart';

class LineChartScreen extends StatefulWidget {
  const LineChartScreen({
    super.key,
    required this.chartData,
    required this.chart2Data,
  });
  final List<AnnualizedReturn>? chartData;
  final List<AnnualizedReturn>? chart2Data;
  @override
  State<LineChartScreen> createState() => _LineChartScreenState();
}

class ChartData {
  ChartData(this.x, this.y);
  final String? x;
  final double? y;
}

class _LineChartScreenState extends State<LineChartScreen> {
  @override
  Widget build(BuildContext context) {
    return _buildChart();
  }

  Widget _buildChart() {
    List<ChartData> chartData = [];
    List<ChartData> chart2Data = [];
    widget.chartData!.forEach((e) {
      chartData.add(ChartData(e.label, double.parse(e.value!)));
    });
    widget.chart2Data!.forEach((e) {
      chart2Data.add(ChartData(e.label, double.parse(e.value!)));
    });
    debugPrint("$chart2Data");
    return SfCartesianChart(
      plotAreaBorderWidth: 0,
      primaryXAxis: CategoryAxis(
        majorGridLines: MajorGridLines(width: 0),
        axisLine: AxisLine(width: 0),
      ),
      primaryYAxis: NumericAxis(
        majorGridLines: MajorGridLines(width: 0),
        axisLine: AxisLine(width: 0),
      ),
      series: <ChartSeries>[
        // Renders line chart
        StackedLineSeries<ChartData, String>(
            dataSource: chartData,
            xValueMapper: (ChartData data, _) => data.x,
            yValueMapper: (ChartData data, _) => data.y),
        StackedLineSeries<ChartData, String>(
            dataSource: chart2Data,
            xValueMapper: (ChartData data, _) => data.x,
            yValueMapper: (ChartData data, _) => data.y)
      ],
    );
  }
}
