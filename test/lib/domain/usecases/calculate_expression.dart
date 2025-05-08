import '../entities/calculation.dart';
import '../repositories/calculator_repository.dart';

class CalculateExpression {
  final CalculatorRepository repository;

  CalculateExpression(this.repository);

  Calculation execute(String expression) {
    final result = repository.calculateExpression(expression);
    return Calculation(expression: expression, result: result);
  }
}