import 'package:flutter/material.dart';
import 'package:syncfusion_flutter_charts/charts.dart';

class SyncfusionRadicalChart extends StatefulWidget {
  const SyncfusionRadicalChart({super.key});

  @override
  State<SyncfusionRadicalChart> createState() => _SyncfusionRadicalChartState();
}

class _SyncfusionRadicalChartState extends State<SyncfusionRadicalChart> {
  late TooltipBehavior _tooltip;

  @override
  void initState() {
    _tooltip = TooltipBehavior(enable: true);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(6), color: Colors.white),
      child:
          SfCircularChart(tooltipBehavior: _tooltip, series: <CircularSeries>[
        RadialBarSeries<ChartData, String>(
            dataSource: chartData,
            dataLabelSettings: const DataLabelSettings(
                textStyle: TextStyle(fontSize: 10, fontWeight: FontWeight.w400),
                isVisible: true),
            radius: '100',
            useSeriesColor: true,
            trackOpacity: 0.3,
            cornerStyle: CornerStyle.endCurve,
            xValueMapper: (ChartData data, _) => data.x,
            yValueMapper: (ChartData data, _) => data.y)
      ]),
    );
  }

  final List<ChartData> chartData = [
    ChartData('Flutter', 35),
    ChartData('Kotlin', 23),
    ChartData('Swift UI', 34),
    ChartData('Ionic', 25),
    ChartData('Flutter Flow', 40)
  ];
}

class ChartData {
  ChartData(this.x, this.y);
  final String x;
  final double y;
}
