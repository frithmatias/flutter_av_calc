import 'package:get/get.dart';

class CalculatorController extends GetxController {
  // podría definir el tipo RxString, pero es mejor poner simplemente var para que Dart lo infiera
  var firstNumber = '10'.obs;
  var secondNumber = '20'.obs;
  var operation = '+'.obs;
  var mathResult = '.'.obs;

  resetOperation() {
    // esto es como hacer sink.add() es decir añadir un valor al stream
    this.firstNumber.value = '0';
    // o también se puede hacer de varias formas, por ejemplo:
    // this.firstNumber = '0'.obs;
    // this.firstNumber.update((val) { })
    this.secondNumber.value = '0';
    this.operation.value = '+';
    this.mathResult.value = '0';
  }

  addNumber(String number) {
    if (mathResult.value == '0') return mathResult.value = number;
    if (mathResult.value == '-0') return mathResult.value = '-' + number;
    mathResult.value = mathResult.value + number;
  }

  changePositiveNegative() {
    if (mathResult.value.startsWith('-')) {
      mathResult.value = mathResult.value.replaceFirst('-', '');
    } else {
      mathResult.value = '-' + mathResult.value;
    }
  }

  addDecimalPoint() {
    if (mathResult.contains('.')) return;
    if (mathResult.startsWith('0')) return mathResult.value = '0.';
    mathResult.value = mathResult.value + '.';
  }

  setOperation(String newOperation) {
    firstNumber.value = mathResult.value;
    secondNumber.value = '?';
    operation.value = newOperation;
    mathResult.value = '0';
  }

  deleteEntry() {
    if (mathResult.value.replaceAll('-', '').length > 1)
      return mathResult.value =
          mathResult.value.substring(0, mathResult.value.length - 1);
    mathResult.value = '0';
  }

  executeOperation() {
    double num1 = double.parse(firstNumber.value);
    double num2 = double.parse(mathResult.value);

    secondNumber.value = mathResult.value;

    switch (operation.value) {
      case '+':
        mathResult.value = '${num1 + num2}';
        break;

      case '-':
        mathResult.value = '${num1 - num2}';
        break;

      case '/':
        mathResult.value = '${num1 / num2}';
        break;

      case '*':
        mathResult.value = '${num1 * num2}';
        break;
    }

    if(mathResult.value.endsWith('.0')){
      mathResult.value = mathResult.value.substring(0, mathResult.value.length-2);
    }
  }
}
