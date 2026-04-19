import 'package:math_expressions/math_expressions.dart';

class CalculatorLogic {
  static String calculate(String expression) {
    try {
      String expStr = expression.replaceAll('×', '*').replaceAll('÷', '/');
      Parser p = Parser();
      Expression exp = p.parse(expStr);
      double eval = exp.evaluate(EvaluationType.REAL, ContextModel());
      return eval.toStringAsFixed(eval == eval.toInt() ? 0 : 2);
    } catch (e) {
      return "Error";
    }
  }
}