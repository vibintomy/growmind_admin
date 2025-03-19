import 'package:flutter/material.dart';
import 'package:growmind_admin/features/home/domain/entities/admin_entites.dart';
import 'package:syncfusion_flutter_charts/charts.dart';

class SyncfusionRadialChart extends StatefulWidget {
  final AdminEntities adminEntities;
  const SyncfusionRadialChart({super.key, required this.adminEntities});

  @override
  State<SyncfusionRadialChart> createState() => _SyncfusionRadialChartState();
}

class _SyncfusionRadialChartState extends State<SyncfusionRadialChart> {
  late TooltipBehavior _tooltip;
  late List<ChartData> _chartData;

  @override
  void initState() {
    super.initState();
    _tooltip = TooltipBehavior(enable: true);
    _updateChartData();
  }

  void _updateChartData() {
    setState(() {
      _chartData = _getChartData();
    });

  }

  List<ChartData> _getChartData() {
    List<ChartData> data = [];

    if (widget.adminEntities.course.isNotEmpty) {    
      List<CourseState> courses = widget.adminEntities.course.values.toList()
        ..sort((a, b) => b.purchase.compareTo(a.purchase));
      for (var course in courses.take(5)) {
        data.add(ChartData(course.name, course.purchase.toDouble()));
      }
    }

    return data;
  }

  @override
  Widget build(BuildContext context) {
     
    return Container(
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(6),
        color: Colors.white,
      ),
      padding: const EdgeInsets.all(8.0),
      child: SfCircularChart(
        title:const ChartTitle(
          text: 'Top 5 Purchased Courses',
          textStyle:  TextStyle(fontSize: 14, fontWeight: FontWeight.bold),
        ),
        legend:const Legend(
          isVisible: true,
          overflowMode: LegendItemOverflowMode.wrap,
          position: LegendPosition.bottom,
        ),
        tooltipBehavior: _tooltip,
        series: <CircularSeries>[
          RadialBarSeries<ChartData, String>(
            dataSource: _chartData,
            dataLabelSettings: const DataLabelSettings(
              isVisible: true,
              textStyle: TextStyle(fontSize: 10, fontWeight: FontWeight.w400),
            ),
            radius: '100%',
            useSeriesColor: true,
            trackOpacity: 0.3,
            cornerStyle: CornerStyle.endCurve,
            xValueMapper: (ChartData data, _) => data.x,
            yValueMapper: (ChartData data, _) => data.y,
          )
        ],
      ),
    );
  }
}

class ChartData {
  ChartData(this.x, this.y);
  final String x;
  final double y;
}
