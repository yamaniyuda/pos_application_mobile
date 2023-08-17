import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:pos_application_mobile/domain/entities/bar_weekly_entity.dart';

class BarCharWidget extends StatelessWidget {
  final List<double> weeklySummary;
  const BarCharWidget({
    super.key,
    required this.weeklySummary
  });

  Widget _customButtonTitle(double value, TitleMeta meta) {
    const style = TextStyle(
      color: Colors.grey,
      fontWeight: FontWeight.bold,
      fontSize: 14
    );

    Widget text;

    switch (value.toInt()) {
      case 0:
        text = const Text('S', style: style);
        break;
      case 1:
        text = const Text('M', style: style);
        break;
      case 2:
        text = const Text('T', style: style);
        break;
      case 3:
        text = const Text('W', style: style);
        break;
      case 4:
        text = const Text('T', style: style);
        break;
      case 5:
        text = const Text('F', style: style);
        break;
      case 6:
        text = const Text('S', style: style);
        break;
      default:
        text = const Text('', style: style);
        break;
    }

    return SideTitleWidget(axisSide: meta.axisSide, child: text);
  }

  @override
  Widget build(BuildContext context) {
    BarWeeklyEntity barData = BarWeeklyEntity(
      sunAmount: weeklySummary[0],
      monAmount: weeklySummary[1],
      tueAmount: weeklySummary[2],
      wedAmount: weeklySummary[3],
      thurAmount: weeklySummary[4],
      friAmount: weeklySummary[5],
      satAmount: weeklySummary[6]
    );

    barData.initializeBarWeekly();

    return BarChart(
      BarChartData(
        maxY: 50,
        minY: 0,
        gridData: const FlGridData(show: false),
        borderData: FlBorderData(show: false),
        titlesData: FlTitlesData(
          show: true,
          topTitles: const AxisTitles(sideTitles: SideTitles(showTitles: false)),
          rightTitles: const AxisTitles(sideTitles: SideTitles(showTitles: false)),
          bottomTitles: AxisTitles(sideTitles: SideTitles(
            showTitles: true,
            getTitlesWidget: _customButtonTitle,
          ))
        ),
        barGroups: barData.barData.map(
          (e) => BarChartGroupData(
            x: e.x,
            barRods: [
              BarChartRodData(
                toY: e.y,
                color: Colors.grey[800],
                width: 25,
                borderRadius: BorderRadius.circular(4),
                backDrawRodData: BackgroundBarChartRodData(
                  show: true,
                  toY: 50,
                  color: Colors.grey[200]
                )
              )
            ]
          )
        ).toList()
      )
    );
  }
}
