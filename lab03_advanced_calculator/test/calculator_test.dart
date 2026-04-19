import 'package:flutter_test/flutter_test.dart';
import 'package:lab03_advanced_calculator/utils/calculator_logic.dart';

void main() {
  test('Basic operations', () {
    expect(CalculatorLogic.calculate('5+3'), '8');
    expect(CalculatorLogic.calculate('10-4'), '6');
  });
}