import '../../domain/repositories/calculator_repository.dart';

class CalculatorRepositoryImpl implements CalculatorRepository {
  @override
  String calculateExpression(String expression) {
    // Replace × with * and ÷ with / for calculation
    String input = expression.replaceAll('×', '*').replaceAll('÷', '/');

    try {
      // Simple expression evaluator
      final result = _parseExpression(input);
      
      // Format result to remove trailing zeros and decimal point if not needed
      String resultStr = result.toString();
      if (resultStr.endsWith('.0')) {
        resultStr = resultStr.substring(0, resultStr.length - 2);
      }
      
      return resultStr;
    } catch (e) {
      return 'Error';
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
}