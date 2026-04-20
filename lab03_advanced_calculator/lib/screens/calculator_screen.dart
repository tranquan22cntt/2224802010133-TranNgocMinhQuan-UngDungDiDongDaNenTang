import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../providers/calculator_provider.dart';
import '../providers/history_provider.dart'; // THÊM DÒNG NÀY
import '../models/calculator_mode.dart';
import '../widgets/calculator_button.dart';
import 'settings_screen.dart';
import 'history_screen.dart';

class CalculatorScreen extends StatelessWidget {
  const CalculatorScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final provider = Provider.of<CalculatorProvider>(context);
    final isScientific = provider.mode == CalculatorMode.scientific;
    final history = Provider.of<HistoryProvider>(context, listen: false);

    return Scaffold(
      backgroundColor: Theme.of(context).scaffoldBackgroundColor,
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
        leading: IconButton(
          icon: Icon(Icons.history, color: Theme.of(context).iconTheme.color),
          onPressed: () => Navigator.push(
              context,
              MaterialPageRoute(builder: (context) => const HistoryScreen())
          ),
        ),
        actions: [
          IconButton(
            icon: Icon(Icons.settings, color: Theme.of(context).iconTheme.color),
            onPressed: () => Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => const SettingsScreen())
            ),
          ),
        ],
      ),
      body: SafeArea(
        child: Column(
          children: [
            Expanded(
              flex: 3,
              child: GestureDetector(
                onHorizontalDragEnd: (details) => provider.addToExpression('CE', history),
                child: _buildDisplayArea(provider, context),
              ),
            ),
            _buildModeSelector(provider),
            Expanded(
              flex: 7,
              child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 12),
                child: isScientific
                    ? _buildScientificGrid(provider, context)
                    : _buildBasicGrid(provider, context),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildDisplayArea(CalculatorProvider p, BuildContext context) {
    final isDark = Theme.of(context).brightness == Brightness.dark;
    return Container(
      padding: const EdgeInsets.all(24),
      alignment: Alignment.bottomRight,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.end,
        crossAxisAlignment: CrossAxisAlignment.end,
        children: [
          Text(
              p.expression,
              style: const TextStyle(fontSize: 24, color: Colors.grey, fontFamily: 'Roboto')
          ),
          const SizedBox(height: 8),
          Text(
              p.result,
              style: TextStyle(
                  fontSize: 48,
                  fontWeight: FontWeight.bold,
                  color: isDark ? Colors.white : Colors.black,
                  fontFamily: 'Roboto'
              )
          ),
        ],
      ),
    );
  }

  Widget _buildModeSelector(CalculatorProvider p) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8.0),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          IconButton(
            icon: const Icon(Icons.calculate),
            onPressed: () => p.toggleMode(CalculatorMode.basic),
            color: p.mode == CalculatorMode.basic ? const Color(0xFF4ECDC4) : Colors.grey,
          ),
          const SizedBox(width: 20),
          IconButton(
            icon: const Icon(Icons.science),
            onPressed: () => p.toggleMode(CalculatorMode.scientific),
            color: p.mode == CalculatorMode.scientific ? const Color(0xFF4ECDC4) : Colors.grey,
          ),
        ],
      ),
    );
  }

  Widget _buildBasicGrid(CalculatorProvider p, BuildContext context) {
    final rows = [
      ['C', 'CE', '%', '÷'],
      ['7', '8', '9', '×'],
      ['4', '5', '6', '-'],
      ['1', '2', '3', '+'],
      ['±', '0', '.', '=']
    ];
    return Column(children: rows.map((r) => _buildRow(r, p, context)).toList());
  }

  Widget _buildScientificGrid(CalculatorProvider p, BuildContext context) {
    final rows = [
      ['sin', 'cos', 'tan', 'ln', 'log', '√'],
      ['(', ')', 'x²', 'x^y', 'π', 'e'],
      ['MC', '7', '8', '9', 'C', '÷'],
      ['MR', '4', '5', '6', 'CE', '×'],
      ['M+', '1', '2', '3', '%', '-'],
      ['M-', '±', '0', '.', '=', '+'],
    ];
    return Column(children: rows.map((r) => _buildRow(r, p, context)).toList());
  }

  Widget _buildRow(List<String> labels, CalculatorProvider p, BuildContext context) {
    final history = Provider.of<HistoryProvider>(context, listen: false);

    return Expanded(
      child: Row(
        children: labels.map((l) => CalculatorButton(
            label: l,
            backgroundColor: _getColor(l),
            onPressed: () => p.addToExpression(l, history)
        )).toList(),
      ),
    );
  }

  Color _getColor(String label) {
    if (RegExp(r'[0-9.πe]').hasMatch(label)) return const Color(0xFF2C2C2C);
    if (['=', '+', '-', '×', '÷'].contains(label)) return const Color(0xFF4ECDC4);
    return const Color(0xFF424242);
  }
}