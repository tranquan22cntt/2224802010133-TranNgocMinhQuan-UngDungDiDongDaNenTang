import 'package:flutter/material.dart';

void main() {
  runApp(const CalculatorApp());
}

class CalculatorApp extends StatelessWidget {
  const CalculatorApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Calculator App',
      theme: ThemeData(
        // Cấu hình font Roboto
        fontFamily: 'Roboto',
        scaffoldBackgroundColor: const Color(0xFF171717), // Màu nền tối
      ),
      home: const CalculatorScreen(),
    );
  }
}

class CalculatorScreen extends StatefulWidget {
  const CalculatorScreen({super.key});

  @override
  State<CalculatorScreen> createState() => _CalculatorScreenState();
}

class _CalculatorScreenState extends State<CalculatorScreen> {
  // Các biến trạng thái quản lý dữ liệu
  String display = '0000';
  double? num1;
  String? operator;
  bool shouldResetDisplay = false;

  // Hàm xử lý khi nhấn nút
  void _onPressed(String btnText) {
    setState(() {
      if (btnText == 'C') {
        display = '0000';
        num1 = null;
        operator = null;
      } else if (btnText == '=') {
        if (num1 != null && operator != null) {
          double num2 = double.parse(display);
          double result = 0;
          if (operator == '+') result = num1! + num2;
          if (operator == '-') result = num1! - num2;
          if (operator == '×') result = num1! * num2;
          if (operator == '÷') result = num2 != 0 ? num1! / num2 : 0;

          display = result % 1 == 0 ? result.toInt().toString() : result.toString();
          num1 = null;
          operator = null;
          shouldResetDisplay = true;
        }
      } else if (['+', '-', '×', '÷'].contains(btnText)) {
        num1 = double.parse(display);
        operator = btnText;
        shouldResetDisplay = true;
      } else {
        if (display == '0000' || shouldResetDisplay) {
          display = btnText;
          shouldResetDisplay = false;
        } else {
          display += btnText;
        }
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(20.0),
          child: Column( // Sử dụng Column/Row
            children: [
              // Vùng hiển thị số
              Expanded(
                flex: 2,
                child: Container(
                  alignment: Alignment.bottomRight,
                  padding: const EdgeInsets.symmetric(vertical: 24),
                  child: Text(
                    display,
                    style: const TextStyle(color: Colors.white, fontSize: 80, fontWeight: FontWeight.w300),
                  ),
                ),
              ),
              // Lưới nút bấm
              Expanded(
                flex: 5,
                child: Column(
                  children: [
                    _buildRow(['C', '( )', '%', '÷']),
                    _buildRow(['7', '8', '9', '×']),
                    _buildRow(['4', '5', '6', '-']),
                    _buildRow(['1', '2', '3', '+']),
                    _buildRow(['+/-', '0', '.', '=']),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildRow(List<String> labels) {
    return Expanded(
      child: Row(
        children: labels.map((label) => _buildButton(label)).toList(),
      ),
    );
  }

  Widget _buildButton(String label) {
    Color btnColor = const Color(0xFF2C2C2E);
    if (label == 'C') btnColor = const Color(0xFF9E3C3E);
    if (label == '( )' || label == '%') btnColor = const Color(0xFF3A3A3C);
    if (['÷', '×', '-', '+'].contains(label)) btnColor = const Color(0xFF374B3E);
    if (label == '=') btnColor = const Color(0xFF006C42);
    return Expanded(
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: AspectRatio(
          aspectRatio: 1,
          child: ElevatedButton(
            onPressed: () => _onPressed(label),
            style: ElevatedButton.styleFrom(
              shape: const CircleBorder(),
              backgroundColor: btnColor,
              elevation: 0,
              padding: const EdgeInsets.all(0),
            ),
            child: Text(label, style: const TextStyle(fontSize: 24, color: Colors.white)),
          ),
        ),
      ),
    );
  }
}