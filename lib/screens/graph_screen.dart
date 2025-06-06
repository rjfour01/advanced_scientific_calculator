import 'package:flutter/material.dart';
import 'package:fl_chart/fl_chart.dart';
import 'package:math_expressions/math_expressions.dart';

class GraphScreen extends StatelessWidget {
  final String expression;
  const GraphScreen({super.key, required this.expression});

  @override
  Widget build(BuildContext context) {
    List<FlSpot> points = [];
    try {
      Parser p = Parser();
      Expression exp = p.parse(expression.replaceAll('^', '**'));
      ContextModel cm = ContextModel();
      for (double x = -10; x <= 10; x += 0.5) {
        cm.bindVariable(Variable('x'), Number(x));
        double y = exp.evaluate(EvaluationType.REAL, cm);
        if (y.isFinite) {
          points.add(FlSpot(x, y));
        }
      }
    } catch (_) {}
    return Scaffold(
      appBar: AppBar(title: const Text('Graph Plot')),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: points.isEmpty
            ? Center(child: Text('Invalid or empty expression'))
            : LineChart(
                LineChartData(
                  minX: -10,
                  maxX: 10,
                  minY: points.map((e) => e.y).reduce((a, b) => a < b ? a : b),
                  maxY: points.map((e) => e.y).reduce((a, b) => a > b ? a : b),
                  lineBarsData: [
                    LineChartBarData(
                      spots: points,
                      isCurved: true,
                      color: Colors.blue,
                      barWidth: 2,
                    ),
                  ],
                  gridData: FlGridData(show: true),
                  borderData: FlBorderData(show: true),
                  titlesData: FlTitlesData(show: true),
                ),
              ),
      ),
    );
  }
}
