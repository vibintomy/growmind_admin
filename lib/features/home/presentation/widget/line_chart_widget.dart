import 'package:flutter/material.dart';
import 'package:fl_chart/fl_chart.dart';
import 'package:intl/intl.dart';

class LineChartGraphWidget extends StatelessWidget {
  final Map<String, dynamic> statsData;
  final String metricType; // Metric to display ('totalRevenue' or 'purchases')

  const LineChartGraphWidget({
    super.key, 
    required this.statsData, 
    required this.metricType
  });

  @override
  Widget build(BuildContext context) {
    // Process data for the chart
    final List<FlSpot> spots = _processDataForChart();
    
    // Debug log the spots to verify data
    debugPrint('Chart spots for $metricType: $spots');
    
    // Ensure we have valid data - if empty, show a message instead
    if (spots.isEmpty) {
      return Container(
        height: 300,
        decoration: BoxDecoration(
          color: Colors.blue[700]!.withOpacity(.1),
          borderRadius: BorderRadius.circular(12)
        ),
        padding: const EdgeInsets.all(16.0),
        child: const Center(
          child: Text(
            'No data available',
            style: TextStyle(color: Colors.white, fontSize: 16),
          ),
        ),
      );
    }
    
    // Calculate min and max values for Y axis with some padding
    double maxY = spots.map((spot) => spot.y).reduce((a, b) => a > b ? a : b);
    maxY = maxY <= 0 ? 50 : (maxY * 1.2); // Add 20% padding, minimum of 50
    maxY = (maxY / 10).ceil() * 10; // Round to nearest 10
    
    // Calculate appropriate interval based on max value
    double interval = maxY > 100 ? 20 : 10;
    if (maxY <= 50) interval = 5;
    
    debugPrint('maxY: $maxY, interval: $interval');
    
    return Container(
      height: 300,
      decoration: BoxDecoration(
        color: Colors.blue[700]!.withOpacity(.1),
        borderRadius: BorderRadius.circular(12)
      ),
      padding: const EdgeInsets.all(16.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            metricType == 'totalRevenue' ? 'Daily Revenue (Last 7 Days)' : 'Daily Purchases (Last 7 Days)',
            style: const TextStyle(
              color: Colors.black,
              fontWeight: FontWeight.bold,
              fontSize: 16,
            ),
          ),
          const SizedBox(height: 8),
          Text(
            'Last updated: ${DateFormat('MMM dd, yyyy HH:mm').format(DateTime.now())}',
            style: TextStyle(
              color: Colors.black.withOpacity(0.7),
              fontSize: 12,
            ),
          ),
          const SizedBox(height: 16),
          Expanded(
            child: LineChart(
              LineChartData(
                gridData: FlGridData(
                  show: true,
                  drawVerticalLine: true,
                  horizontalInterval: interval,
                  verticalInterval: 1,
                  getDrawingHorizontalLine: (value) {
                    return FlLine(
                      color: Colors.white.withOpacity(0.1),
                      strokeWidth: 1,
                    );
                  },
                  getDrawingVerticalLine: (value) {
                    return FlLine(
                      color: Colors.white.withOpacity(0.1),
                      strokeWidth: 1,
                    );
                  },
                ),
                titlesData: FlTitlesData(
                  leftTitles: AxisTitles(
                    sideTitles: SideTitles(
                      showTitles: true,
                      getTitlesWidget: (value, meta) {
                        final style = TextStyle(
                          color: Colors.black.withOpacity(0.8),
                          fontWeight: FontWeight.bold,
                          fontSize: 12,
                        );
                        String text = '';
                        if (value % interval == 0) {
                          text = metricType == 'totalRevenue' 
                              ? '\$${value.toInt()}' 
                              : '${value.toInt()}';
                        }
                        return SideTitleWidget(
                          meta: meta,
                          child: Text(text, style: style),
                        );
                      },
                      reservedSize: 40,
                      interval: interval,
                    ),
                  ),
                  topTitles: const AxisTitles(
                    sideTitles: SideTitles(showTitles: false),
                  ),
                  rightTitles: const AxisTitles(
                    sideTitles: SideTitles(showTitles: false),
                  ),
                  bottomTitles: AxisTitles(
                    sideTitles: SideTitles(
                      showTitles: true,
                      getTitlesWidget: (value, meta) {
                        final style = TextStyle(
                          color: Colors.black.withOpacity(0.8),
                          fontWeight: FontWeight.bold,
                          fontSize: 10,
                        );
                        
                        // Get date labels for the last 7 days
                        List<String> dateLabels = _getDateLabels();
                        String text = '';
                        
                        int index = value.toInt();
                        if (index >= 0 && index < dateLabels.length) {
                          text = dateLabels[index];
                        }
                        
                        return SideTitleWidget(
                          meta: meta,
                          angle: 0.3, // Slight angle to handle longer date texts
                          space: 5,
                          child: Text(text, style: style),
                        );
                      },
                      reservedSize: 40,
                      interval: 1,
                    ),
                  ),
                ),
                borderData: FlBorderData(
                  show: true,
                  border: Border.all(
                    color: Colors.white.withOpacity(0.2),
                    width: 1
                  ),
                ),
                minX: 0,
                maxX: 6, // 7 days (0-6)
                minY: 0,
                maxY: maxY,
                lineBarsData: [
                  LineChartBarData(
                    spots: spots,
                    isCurved: true,
                    curveSmoothness: 0.3,
                    barWidth: 4, // Increased line width for better visibility
                    isStrokeCapRound: true,
                    dotData: const FlDotData(
                      show: true,
                    ),
                    color: Colors.pink,
                    belowBarData: BarAreaData(
                      show: true,
                      color: Colors.pink.withOpacity(0.2),
                      gradient: LinearGradient(
                        colors: [
                          Colors.pink.withOpacity(0.4),
                          Colors.pink.withOpacity(0.05),
                        ],
                        begin: Alignment.topCenter,
                        end: Alignment.bottomCenter,
                      ),
                    ),
                  ),
                ],
                lineTouchData: LineTouchData(
                  enabled: true,
                  touchTooltipData: LineTouchTooltipData(
                
                    getTooltipItems: (List<LineBarSpot> touchedSpots) {
                      return touchedSpots.map((LineBarSpot touchedSpot) {
                        final value = touchedSpot.y;
                        final index = touchedSpot.x.toInt();
                        final dates = _getDateLabels();
                        final date = index < dates.length ? dates[index] : '';
                        
                        return LineTooltipItem(
                          '$date\n${metricType == 'totalRevenue' ? '\$${value.toInt()}' : '${value.toInt()} purchases'}',
                          const TextStyle(color: Colors.black),
                        );
                      }).toList();
                    },
                  ),
                  handleBuiltInTouches: true,
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }

  // Process data for chart
  List<FlSpot> _processDataForChart() {
    // Debug the incoming data structure
    debugPrint('statsData: $statsData');
    
    // If statsData is empty, non-existent or malformed
    if (statsData == null || 
        !statsData.containsKey('data') || 
        statsData['data'] == null ||
        !(statsData['data'] is List) ||
        (statsData['data'] as List).isEmpty) {
        
      debugPrint('Using default data because statsData is invalid');
      return const [
        FlSpot(0, 42),
        FlSpot(1, 38),
        FlSpot(2, 65),
        FlSpot(3, 75),
        FlSpot(4, 58),
        FlSpot(5, 79),
        FlSpot(6, 86),
      ];
    }
    
    try {
      List<dynamic> dataPoints = statsData['data'] as List;
      debugPrint('Data points length: ${dataPoints.length}');
      
      List<FlSpot> spots = [];
      
      // Ensure we only show the last 7 days of data
      int startIndex = dataPoints.length > 7 ? dataPoints.length - 7 : 0;
      
      for (int i = 0; i < 7 && (startIndex + i) < dataPoints.length; i++) {
        var point = dataPoints[startIndex + i];
        
        // Debug individual data point
        debugPrint('Processing point[$i]: $point');
        
        double value = 0;
        
        // Safer way to extract values, handling various potential types
        if (metricType == 'totalRevenue') {
          if (point['revenue'] is int) {
            value = (point['revenue'] as int).toDouble();
          } else if (point['revenue'] is double) {
            value = point['revenue'] as double;
          } else if (point['revenue'] is String) {
            value = double.tryParse(point['revenue'] as String) ?? 0;
          }
        } else if (metricType == 'purchases') {
          if (point['purchases'] is int) {
            value = (point['purchases'] as int).toDouble();
          } else if (point['purchases'] is double) {
            value = point['purchases'] as double;
          } else if (point['purchases'] is String) {
            value = double.tryParse(point['purchases'] as String) ?? 0;
          }
        }
        
        debugPrint('Adding spot: (${i.toDouble()}, $value)');
        spots.add(FlSpot(i.toDouble(), value));
      }
      
      // If we have fewer than 7 days of data, pad with zeros at the beginning
      if (spots.length < 7) {
        debugPrint('Padding with zeros to reach 7 days');
        int padding = 7 - spots.length;
        for (int i = 0; i < padding; i++) {
          spots.insert(0, FlSpot(i.toDouble(), 0));
        }
        
        // Adjust x values to ensure they are sequential from 0 to 6
        for (int i = 0; i < spots.length; i++) {
          spots[i] = FlSpot(i.toDouble(), spots[i].y);
        }
      }
      
      debugPrint('Final spots: $spots');
      return spots;
    } catch (e) {
      debugPrint('Error processing data: $e');
      return const [
        FlSpot(0, 42),
        FlSpot(1, 38),
        FlSpot(2, 65),
        FlSpot(3, 75),
        FlSpot(4, 58),
        FlSpot(5, 79),
        FlSpot(6, 86),
      ];
    }
  }
  
  // Generate date labels for the last 7 days
  List<String> _getDateLabels() {
    try {
      List<dynamic> dataPoints = statsData['data'] ?? [];
      List<String> labels = [];
      
      if (dataPoints.isNotEmpty) {
        // If data contains date information, use it
        int startIndex = dataPoints.length > 7 ? dataPoints.length - 7 : 0;
        
        for (int i = 0; i < 7 && (startIndex + i) < dataPoints.length; i++) {
          var point = dataPoints[startIndex + i];
          String name = point['name'] ?? '';
          labels.add(name);
        }
        
        // Pad with blank labels if needed
        while (labels.length < 7) {
          labels.add('');
        }
      } 
      
      // If we didn't get valid labels from data, generate them
      if (labels.isEmpty || labels.every((label) => label.isEmpty)) {
        // Generate date labels for the last 7 days
        final dateFormat = DateFormat('MM/dd');
        final now = DateTime.now();
        labels = [];
        
        for (int i = 6; i >= 0; i--) {
          final date = now.subtract(Duration(days: i));
          labels.add(dateFormat.format(date));
        }
      }
      
      return labels;
    } catch (e) {
      // Generate date labels for the last 7 days as fallback
      final dateFormat = DateFormat('MM/dd');
      final now = DateTime.now();
      List<String> labels = [];
      
      for (int i = 6; i >= 0; i--) {
        final date = now.subtract(Duration(days: i));
        labels.add(dateFormat.format(date));
      }
      
      return labels;
    }
  }
}

// Example of how to use this widget with proper data
class DailyRevenueChartPage extends StatelessWidget {
  const DailyRevenueChartPage({super.key});

  @override
  Widget build(BuildContext context) {
    // Properly formatted sample data
    final Map<String, dynamic> sampleDailyData = {
      'data': [
        {'name': '03/01', 'purchases': 42, 'revenue': 850},
        {'name': '03/02', 'purchases': 38, 'revenue': 720},
        {'name': '03/03', 'purchases': 65, 'revenue': 1250},
        {'name': '03/04', 'purchases': 75, 'revenue': 1450},
        {'name': '03/05', 'purchases': 58, 'revenue': 1100},
        {'name': '03/06', 'purchases': 79, 'revenue': 1580},
        {'name': '03/07', 'purchases': 86, 'revenue': 1650},
      ]
    };

    return Scaffold(
      appBar: AppBar(
        title: const Text('Daily Revenue Analysis'),
        backgroundColor: Colors.blue[800],
      ),
      body: Container(
        color: Colors.blue[900],
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text(
              'Daily Performance',
              style: TextStyle(
                color: Colors.black,
                fontSize: 24,
                fontWeight: FontWeight.bold,
              ),
            ),
            const SizedBox(height: 24),
            LineChartGraphWidget(
              statsData: sampleDailyData,
              metricType: 'totalRevenue',
            ),
            const SizedBox(height: 24),
            LineChartGraphWidget(
              statsData: sampleDailyData,
              metricType: 'purchases',
            ),
          ],
        ),
      ),
    );
  }
}


class DebugChartPage extends StatelessWidget {
  final Map<String, dynamic> data;
  
  const DebugChartPage({
    super.key,
    required this.data,
  });
  
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Chart Debug View'),
        backgroundColor: Colors.blue[800],
      ),
      body: Container(
        color: Colors.blue[900],
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text(
              'Chart with Debug Data',
              style: TextStyle(
                color: Colors.white,
                fontSize: 24,
                fontWeight: FontWeight.bold,
              ),
            ),
            const SizedBox(height: 16),
            Expanded(
              child: ListView(
                children: [
                  // Display the raw data for debugging
                  Container(
                    padding: const EdgeInsets.all(8),
                    decoration: BoxDecoration(
                      color: Colors.grey[800],
                      borderRadius: BorderRadius.circular(8),
                    ),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        const Text(
                          'Raw Data:',
                          style: TextStyle(
                            color: Colors.white,
                            fontWeight: FontWeight.bold
                          ),
                        ),
                        const SizedBox(height: 8),
                        Text(
                          data.toString(),
                          style: const TextStyle(color: Colors.white),
                        ),
                      ],
                    ),
                  ),
                  const SizedBox(height: 24),
                  LineChartGraphWidget(
                    statsData: data,
                    metricType: 'totalRevenue',
                  ),
                  const SizedBox(height: 24),
                  LineChartGraphWidget(
                    statsData: data,
                    metricType: 'purchases',
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}