import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../providers/calculator_provider.dart';
import '../models/calculator_mode.dart';
import '../widgets/calculator_button.dart';
import 'settings_screen.dart';

class CalculatorScreen extends StatelessWidget {
  const CalculatorScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final provider = Provider.of<CalculatorProvider>(context);
    final isScientific = provider.mode == CalculatorMode.scientific;

    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
        actions: [
          IconButton(
            icon: const Icon(Icons.settings),
            onPressed: () => Navigator.push(context, MaterialPageRoute(builder: (context) => const SettingsScreen())),
          ),
        ],
      ),
      body: SafeArea(
        child: Column(
          children: [
            Expanded(flex: 3, child: _buildDisplayArea(provider)),
            _buildModeSelector(provider),
            Expanded(
              flex: 7,
              child: isScientific ? _buildScientificGrid(provider) : _buildBasicGrid(provider),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildDisplayArea(CalculatorProvider p) {
    return Container(
      padding: const EdgeInsets.all(24),
      alignment: Alignment.bottomRight,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.end,
        crossAxisAlignment: CrossAxisAlignment.end,
        children: [
          Text(p.expression, style: const TextStyle(fontSize: 24, color: Colors.grey)),
          Text(p.result, style: const TextStyle(fontSize: 48, fontWeight: FontWeight.bold)),
        ],
      ),
    );
  }

  Widget _buildModeSelector(CalculatorProvider p) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        IconButton(
          icon: const Icon(Icons.calculate),
          onPressed: () => p.toggleMode(CalculatorMode.basic),
          color: p.mode == CalculatorMode.basic ? Colors.teal : Colors.grey,
        ),
        IconButton(
          icon: const Icon(Icons.science),
          onPressed: () => p.toggleMode(CalculatorMode.scientific),
          color: p.mode == CalculatorMode.scientific ? Colors.teal : Colors.grey,
        ),
      ],
    );
  }

  Widget _buildBasicGrid(CalculatorProvider p) {
    final rows = [['C', 'CE', '%', '÷'], ['7', '8', '9', '×'], ['4', '5', '6', '-'], ['1', '2', '3', '+'], ['±', '0', '.', '=']];
    return Column(children: rows.map((r) => _buildRow(r, p)).toList());
  }

  Widget _buildScientificGrid(CalculatorProvider provider) {
    final rows = [
      ['sin', 'cos', 'tan', 'ln', 'log', '√'],
      ['(', ')', 'x²', 'x^y', 'π', 'e'],
      ['MC', '7', '8', '9', 'C', '÷'],
      ['MR', '4', '5', '6', 'CE', '×'],
      ['M+', '1', '2', '3', '%', '-'],
      ['M-', '±', '0', '.', '=', '+'],
    ];
    return Column(
      children: rows.map((r) => _buildRow(r, provider)).toList(),
    );
  }

  Widget _buildRow(List<String> labels, CalculatorProvider p) {
    return Expanded(child: Row(children: labels.map((l) => CalculatorButton(label: l, backgroundColor: _getColor(l), onPressed: () => p.addToExpression(l))).toList()));
  }

  Color _getColor(String label) {
    if (RegExp(r'[0-9.]').hasMatch(label)) return const Color(0xFF2C2C2C);
    if (['=', '+', '-', '×', '÷'].contains(label)) return const Color(0xFF4ECDC4);
    return const Color(0xFF424242);
  }
}