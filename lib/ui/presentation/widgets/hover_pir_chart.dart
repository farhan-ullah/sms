import 'package:flutter/material.dart';
import 'package:fl_chart/fl_chart.dart';

class HoverPieChart extends StatefulWidget {
  @override
  _HoverPieChartState createState() => _HoverPieChartState();
}

class _HoverPieChartState extends State<HoverPieChart> {
  bool _isHovered = false;

  @override
  Widget build(BuildContext context) {
    return MouseRegion(
      onEnter: (_) {
        setState(() {
          _isHovered = true;
        });
      },
      onExit: (_) {
        setState(() {
          _isHovered = false;
        });
      },
      child: AnimatedScale(
        scale: _isHovered ? 1.1 : 1.0, // Scale the chart on hover
        duration: const Duration(milliseconds: 200),
        child: Container(
          width: 160,
          height: 160,
          child: PieChart(
            PieChartData(
              sections: [
                PieChartSectionData(
                  value: 60,
                  color: _isHovered ? Colors.greenAccent : Colors.green, // Change color on hover
                  title: 'Pass',
                  radius: _isHovered ? 70 : 60, // Increase radius on hover
                ),
                PieChartSectionData(
                  value: 40,
                  color: _isHovered ? Colors.redAccent : Colors.red, // Change color on hover
                  title: 'Fail',
                  radius: _isHovered ? 70 : 60, // Increase radius on hover
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
