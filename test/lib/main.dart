import 'package:flutter/material.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Flutter Calculator',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(
          seedColor: const Color.fromARGB(255, 0, 0, 0),
          primary: const Color.fromARGB(255, 255, 255, 255),
          primaryContainer: const Color.fromARGB(255, 1, 1, 1),
          inversePrimary: const Color.fromARGB(255, 0, 0, 0),
        ),
        useMaterial3: true,
      ),
      home: const CalculatorApp(),
    );
  }
}

class CalculatorApp extends StatefulWidget {
  const CalculatorApp({super.key});

  @override
  State<CalculatorApp> createState() => _CalculatorAppState();
}

class _CalculatorAppState extends State<CalculatorApp> {
  String _input = '';
  String _result = '0';
  bool _clearInput = false;

  void _onButtonPressed(String buttonText) {
    setState(() {
      if (buttonText == 'C') {
        _input = '';
        _result = '0';
      } else if (buttonText == '=') {
        try {
          _calculateResult();
          _clearInput = false;
        } catch (e) {
          _result = 'Error';
        }
      } else if (buttonText == '⌫') {
        if (_input.isNotEmpty) {
          _input = _input.substring(0, _input.length - 1);
        }
      } else {
        if (_clearInput) {
          _input = buttonText;
          _clearInput = false;
        } else {
          _input += buttonText;
        }
      }
    });
  }

  void _calculateResult() {
    // Replace × with * and ÷ with / for calculation
    String input = _input.replaceAll('×', '*').replaceAll('÷', '/');

    // Simple expression evaluator
    final expression = _parseExpression(input);
    _result = expression.toString();

    // Format result to remove trailing zeros and decimal point if not needed
    if (_result.endsWith('.0')) {
      _result = _result.substring(0, _result.length - 2);
    }
  }

  double _parseExpression(String input) {
    // First handle addition and subtraction
    List<String> addSubParts = input.split(RegExp(r'(?<=[^e])[+\-]'));
    if (addSubParts.length > 1) {
      // Find all operators in the expression
      List<String> operators = [];
      for (int i = 0; i < input.length; i++) {
        if ((input[i] == '+' || input[i] == '-') &&
            (i == 0 || input[i - 1] != 'e')) {
          operators.add(input[i]);
        }
      }

      double result = _parseMultiplyDivide(addSubParts[0]);
      for (int i = 0; i < operators.length; i++) {
        if (operators[i] == '+') {
          result += _parseMultiplyDivide(addSubParts[i + 1]);
        } else {
          result -= _parseMultiplyDivide(addSubParts[i + 1]);
        }
      }
      return result;
    } else {
      return _parseMultiplyDivide(input);
    }
  }

  double _parseMultiplyDivide(String input) {
    // Handle multiplication and division
    List<String> parts = input.split(RegExp(r'[*/]'));
    if (parts.length > 1) {
      // Find all operators in the expression
      List<String> operators = [];
      for (int i = 0; i < input.length; i++) {
        if (input[i] == '*' || input[i] == '/') {
          operators.add(input[i]);
        }
      }

      double result = double.parse(parts[0]);
      for (int i = 0; i < operators.length; i++) {
        if (operators[i] == '*') {
          result *= double.parse(parts[i + 1]);
        } else if (operators[i] == '/') {
          result /= double.parse(parts[i + 1]);
        }
      }
      return result;
    } else {
      return double.parse(input);
    }
  }

  Widget _buildButton(String buttonText, {Color? color, int flex = 1}) {
    return Expanded(
      flex: flex,
      child: Padding(
        padding: const EdgeInsets.all(4.0),
        child: ElevatedButton(
          style: ElevatedButton.styleFrom(
            backgroundColor:
                color ?? Theme.of(context).colorScheme.primaryContainer,
            padding: const EdgeInsets.all(20),
          ),
          onPressed: () => _onButtonPressed(buttonText),
          child: Text(buttonText, style: const TextStyle(fontSize: 24)),
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Theme.of(context).colorScheme.inversePrimary,
        title: const Text('Calculator'),
        foregroundColor: const Color.fromARGB(255, 255, 255, 255),
      ),
      body: Column(
        children: [
          // Display
          Expanded(
            flex: 2,
            child: Container(
              color: const Color.fromARGB(255, 0, 0, 0),
              padding: const EdgeInsets.all(16),
              alignment: Alignment.bottomRight,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.end,
                mainAxisAlignment: MainAxisAlignment.end,
                children: [
                  Text(
                    _input,
                    style: TextStyle(
                      fontSize: 24,
                      color: const Color.fromARGB(255, 255, 255, 255),
                    ),
                  ),
                  const SizedBox(height: 8),
                  Text(
                    _result,
                    style: const TextStyle(
                      fontSize: 48,
                      fontWeight: FontWeight.bold,
                      color: Color.fromARGB(255, 255, 255, 255),
                    ),
                  ),
                ],
              ),
            ),
          ),

          // Buttons
          Expanded(
            flex: 5,
            child: Container(
              padding: const EdgeInsets.all(8),
              color: const Color.fromARGB(255, 29, 28, 28),
              child: Column(
                children: [
                  Expanded(
                    child: Row(
                      crossAxisAlignment: CrossAxisAlignment.stretch,
                      children: [
                        _buildButton('C', color: const Color.fromARGB(255, 255, 0, 0)),
                        _buildButton('⌫'),
                        _buildButton('%'),
                        _buildButton('÷'),
                      ],
                    ),
                  ),
                  Expanded(
                    child: Row(
                      crossAxisAlignment: CrossAxisAlignment.stretch,
                      children: [
                        _buildButton('7'),
                        _buildButton('8'),
                        _buildButton('9'),
                        _buildButton('×'),
                      ],
                    ),
                  ),
                  Expanded(
                    child: Row(
                      crossAxisAlignment: CrossAxisAlignment.stretch,
                      children: [
                        _buildButton('4'),
                        _buildButton('5'),
                        _buildButton('6'),
                        _buildButton('-'),
                      ],
                    ),
                  ),
                  Expanded(
                    child: Row(
                      crossAxisAlignment: CrossAxisAlignment.stretch,
                      children: [
                        _buildButton('1'),
                        _buildButton('2'),
                        _buildButton('3'),
                        _buildButton('+'),
                      ],
                    ),
                  ),
                  Expanded(
                    child: Row(
                      crossAxisAlignment: CrossAxisAlignment.stretch,
                      children: [
                        _buildButton('0', flex: 2),
                        _buildButton('.'),
                        _buildButton('=', color: const Color.fromARGB(255, 87, 84, 84)),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
