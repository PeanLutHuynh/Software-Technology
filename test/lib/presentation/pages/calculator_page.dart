import 'package:flutter/material.dart';
import '../../data/repositories/calculator_repository_impl.dart';
import '../../domain/usecases/calculate_expression.dart';
import '../widgets/calculator_button.dart';
import '../widgets/calculator_display.dart';

class CalculatorPage extends StatefulWidget {
  const CalculatorPage({super.key});

  @override
  State<CalculatorPage> createState() => _CalculatorPageState();
}

class _CalculatorPageState extends State<CalculatorPage> {
  final CalculateExpression _calculateExpression = 
      CalculateExpression(CalculatorRepositoryImpl());
  
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
          final calculation = _calculateExpression.execute(_input);
          _result = calculation.result;
          _clearInput = true;
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
            child: CalculatorDisplay(
              input: _input,
              result: _result,
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
                        CalculatorButton(
                          text: 'C',
                          onPressed: () => _onButtonPressed('C'),
                          color: const Color.fromARGB(255, 255, 0, 0),
                        ),
                        CalculatorButton(
                          text: '⌫',
                          onPressed: () => _onButtonPressed('⌫'),
                        ),
                        CalculatorButton(
                          text: '%',
                          onPressed: () => _onButtonPressed('%'),
                        ),
                        CalculatorButton(
                          text: '÷',
                          onPressed: () => _onButtonPressed('÷'),
                        ),
                      ],
                    ),
                  ),
                  Expanded(
                    child: Row(
                      crossAxisAlignment: CrossAxisAlignment.stretch,
                      children: [
                        CalculatorButton(
                          text: '7',
                          onPressed: () => _onButtonPressed('7'),
                        ),
                        CalculatorButton(
                          text: '8',
                          onPressed: () => _onButtonPressed('8'),
                        ),
                        CalculatorButton(
                          text: '9',
                          onPressed: () => _onButtonPressed('9'),
                        ),
                        CalculatorButton(
                          text: '×',
                          onPressed: () => _onButtonPressed('×'),
                        ),
                      ],
                    ),
                  ),
                  Expanded(
                    child: Row(
                      crossAxisAlignment: CrossAxisAlignment.stretch,
                      children: [
                        CalculatorButton(
                          text: '4',
                          onPressed: () => _onButtonPressed('4'),
                        ),
                        CalculatorButton(
                          text: '5',
                          onPressed: () => _onButtonPressed('5'),
                        ),
                        CalculatorButton(
                          text: '6',
                          onPressed: () => _onButtonPressed('6'),
                        ),
                        CalculatorButton(
                          text: '-',
                          onPressed: () => _onButtonPressed('-'),
                        ),
                      ],
                    ),
                  ),
                  Expanded(
                    child: Row(
                      crossAxisAlignment: CrossAxisAlignment.stretch,
                      children: [
                        CalculatorButton(
                          text: '1',
                          onPressed: () => _onButtonPressed('1'),
                        ),
                        CalculatorButton(
                          text: '2',
                          onPressed: () => _onButtonPressed('2'),
                        ),
                        CalculatorButton(
                          text: '3',
                          onPressed: () => _onButtonPressed('3'),
                        ),
                        CalculatorButton(
                          text: '+',
                          onPressed: () => _onButtonPressed('+'),
                        ),
                      ],
                    ),
                  ),
                  Expanded(
                    child: Row(
                      crossAxisAlignment: CrossAxisAlignment.stretch,
                      children: [
                        CalculatorButton(
                          text: '0',
                          onPressed: () => _onButtonPressed('0'),
                          flex: 2,
                        ),
                        CalculatorButton(
                          text: '.',
                          onPressed: () => _onButtonPressed('.'),
                        ),
                        CalculatorButton(
                          text: '=',
                          onPressed: () => _onButtonPressed('='),
                          color: const Color.fromARGB(255, 87, 84, 84),
                        ),
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