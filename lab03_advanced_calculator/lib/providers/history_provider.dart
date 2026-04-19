import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../models/calculation_history.dart';

class HistoryProvider extends ChangeNotifier {
  List<CalculationHistory> _history = [];
  List<CalculationHistory> get history => _history;

  void addHistory(String exp, String res) {
    _history.insert(0, CalculationHistory(expression: exp, result: res, timestamp: DateTime.now()));
    if (_history.length > 50) _history.removeLast();
    notifyListeners();
  }

  void clearHistory() {
    _history.clear();
    notifyListeners();
  }
}