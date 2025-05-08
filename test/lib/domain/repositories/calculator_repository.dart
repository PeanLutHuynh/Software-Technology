import '../entities/calculation.dart';

abstract class CalculatorRepository {
  String calculateExpression(String expression);
}