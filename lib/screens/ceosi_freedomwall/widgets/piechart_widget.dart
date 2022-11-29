import 'package:flutter/material.dart';
import 'package:pie_chart/pie_chart.dart';

import '../../../constants/colors.dart';

class PieChartWidget extends StatefulWidget {
  final Map<String, double> dataMap;
  final String? centerText;

  const PieChartWidget({
    super.key,
    required this.centerText,
    required this.dataMap,
  });

  @override
  State<PieChartWidget> createState() => _PieChartWidgetState();
}

class _PieChartWidgetState extends State<PieChartWidget> {
  @override
  Widget build(BuildContext context) {
    return PieChart(
      dataMap: widget.dataMap,
      animationDuration: const Duration(milliseconds: 800),
      chartLegendSpacing: 32,
      chartRadius: MediaQuery.of(context).size.width / 1.9,
      colorList: CustomColors().piechartColors,
      initialAngleInDegree: 1,
      chartType: ChartType.disc,
      ringStrokeWidth: 32,
      centerText: widget.centerText,
      legendOptions: const LegendOptions(
        showLegendsInRow: false,
        legendPosition: LegendPosition.bottom,
        showLegends: true,
        legendShape: BoxShape.rectangle,
        legendTextStyle: TextStyle(
          fontWeight: FontWeight.bold,
        ),
      ),
      chartValuesOptions: const ChartValuesOptions(
        showChartValueBackground: true,
        showChartValues: true,
        showChartValuesInPercentage: true,
        showChartValuesOutside: true,
        decimalPlaces: 1,
      ),
    );
  }
}
