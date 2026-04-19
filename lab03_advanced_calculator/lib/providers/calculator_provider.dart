import 'package:flutter/material.dart';
import '../models/calculator_mode.dart';
import '../utils/calculator_logic.dart';

class CalculatorProvider extends ChangeNotifier {
  String _expression = '';
  String _result = '0';
  CalculatorMode _mode = CalculatorMode.basic;

  String get expression => _expression;
  String get result => _result;
  CalculatorMode get mode => _mode;

  void addToExpression(String value) {
    if (value == '=') {
      calculate();
    } else if (value == 'C') {
      _expression = '';
      _result = '0';
    } else if (value == 'CE') {
      clearEntry();
    } else {
      _expression += value;
    }
    notifyListeners();
  }

  void calculate() {
    if (_expression.isEmpty) return;
    _result = CalculatorLogic.calculate(_expression);
    notifyListeners();
  }

  void clearEntry() {
    if (_expression.isNotEmpty) {
      _expression = _expression.substring(0, _expression.length - 1);
      notifyListeners();
    }
  }

  void toggleMode(CalculatorMode newMode) {
    _mode = newMode;
    notifyListeners();
  }
}