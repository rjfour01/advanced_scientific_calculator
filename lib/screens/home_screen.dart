import 'package:flutter/material.dart';
import '../widgets/display.dart';
import '../widgets/button_pad.dart';
import '../widgets/history_list.dart';
import '../services/calculator_service.dart';
import '../services/storage_service.dart';
import '../models/calculation.dart';
import 'graph_screen.dart';

class HomeScreen extends StatefulWidget {
  final VoidCallback onToggleTheme;
  final bool isDark;
  const HomeScreen(
      {super.key, required this.onToggleTheme, required this.isDark});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  String expression = '';
  String result = '0';
  final CalculatorService _calculatorService = CalculatorService();
  final StorageService _storageService = StorageService();
  List<Calculation> history = [];

  @override
  void initState() {
    super.initState();
    _loadHistory();
  }

  Future<void> _loadHistory() async {
    final items = await _storageService.getCalculations();
    setState(() {
      history = items.reversed.toList();
    });
  }

  void onButtonPressed(String value) async {
    setState(() {
      if (value == 'C') {
        expression = '';
        result = '0';
      } else if (value == 'DEL') {
        if (expression.isNotEmpty) {
          expression = expression.substring(0, expression.length - 1);
        }
      } else if (value == '=') {
        result = _calculatorService.evaluateExpression(expression);
        if (expression.isNotEmpty && result != 'Error') {
          final calc = Calculation(
            expression: expression,
            result: result,
            timestamp: DateTime.now(),
          );
          _storageService.addCalculation(calc);
          _loadHistory();
        }
      } else if (['sin', 'cos', 'tan'].contains(value)) {
        expression += '$value(';
      } else {
        expression += value;
      }
    });
  }

  void onPlotPressed() {
    if (expression.isNotEmpty) {
      Navigator.push(
        context,
        MaterialPageRoute(
          builder: (context) => GraphScreen(expression: expression),
        ),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Scientific Calculator'),
        actions: [
          IconButton(
            icon: Icon(widget.isDark ? Icons.light_mode : Icons.dark_mode),
            onPressed: widget.onToggleTheme,
          ),
          IconButton(
            icon: const Icon(Icons.delete),
            tooltip: 'Clear History',
            onPressed: () async {
              await _storageService.clearHistory();
              _loadHistory();
            },
          ),
        ],
      ),
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
          child: Column(
            children: [
              // Display area with fixed constraints
              Container(
                height: 100,
                padding:
                    const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
                decoration: BoxDecoration(
                  color: Theme.of(context).cardColor,
                  borderRadius: BorderRadius.circular(12),
                  boxShadow: [
                    BoxShadow(
                      color: Colors.black.withOpacity(0.1),
                      blurRadius: 4,
                      offset: const Offset(0, 2),
                    ),
                  ],
                ),
                child: Display(expression: expression, result: result),
              ),
              const SizedBox(height: 16),
              // Calculator buttons and graph
              Expanded(
                flex: 3,
                child: Row(
                  children: [
                    Expanded(
                      flex: 6,
                      child: ButtonPad(onPressed: onButtonPressed),
                    ),
                    const SizedBox(width: 8),
                    Container(
                      width: 48,
                      child: Column(
                        children: [
                          IconButton(
                            icon: const Icon(Icons.show_chart),
                            tooltip: 'Plot Graph',
                            onPressed: onPlotPressed,
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
              const Divider(height: 16),
              // History
              Expanded(
                flex: 1,
                child: HistoryList(history: history),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
