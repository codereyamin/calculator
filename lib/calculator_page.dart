import 'package:flutter/material.dart';
import 'package:math_expressions/math_expressions.dart';

class Calculator extends StatefulWidget {
  const Calculator({super.key});

  @override
  State<Calculator> createState() => _CalculatorState();
}

class _CalculatorState extends State<Calculator> {
  String equation = "0";
  String result = "0";
  String expression = "";
  double equationFontSize = 38.0;
  double resultFontSize = 48.0;
  buttonPressed(String buttonText) {
    setState(() {
      if (buttonText == "C") {
        equation = "0";
        result = "0";
        equationFontSize = 38.0;
        resultFontSize = 48.0;
      } else if (buttonText == "⌫") {
        equationFontSize = 48.0;
        resultFontSize = 38.0;
        equation = equation.substring(0, equation.length - 1);
        if (equation == "") {
          equation = "0";
        }
      } else if (buttonText == "=") {
        equationFontSize = 38.0;
        resultFontSize = 48.0;
        expression = equation;
        expression = expression.replaceAll('×', '*');
        expression = expression.replaceAll('÷', '/');
        try {
          Parser p = Parser();
          Expression exp = p.parse(expression);
          ContextModel cm = ContextModel();
          result = "${exp.evaluate(EvaluationType.REAL, cm)}";
          result = result.substring(0, result.length - 2);
        } catch (e) {
          result = "Error";
        }
      } else {
        equationFontSize = 48.0;
        resultFontSize = 38.0;
        if (equation == "0") {
          equation = buttonText;
        } else {
          equation = equation + buttonText;
        }
      }
    });
  }

  Widget buildButton(
      String buttonText, double buttonHeight, Color buttonColor) {
    return Container(
      margin: const EdgeInsets.all(2),
      height: MediaQuery.of(context).size.height * 0.1 * buttonHeight,
      color: buttonColor,
      child: ElevatedButton(
        style: ElevatedButton.styleFrom(
          // ignore: deprecated_member_use
          primary: buttonColor,
        ),
        onPressed: () => buttonPressed(buttonText),
        child: Text(
          buttonText,
          style: const TextStyle(
              fontSize: 30, fontWeight: FontWeight.normal, color: Colors.white),
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey[300],
      appBar: AppBar(
        title: const Text("Calculator"),
        centerTitle: true,
      ),
      body: Column(children: [
        Container(
          alignment: Alignment.centerRight,
          child: Text(
            equation,
            style: TextStyle(fontSize: equationFontSize),
          ),
        ),
        Container(
          alignment: Alignment.centerRight,
          child: Text(
            result,
            style: TextStyle(fontSize: resultFontSize),
          ),
        ),
        const Expanded(child: Divider()),
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            SizedBox(
              width: MediaQuery.of(context).size.width * 0.75,
              child: Table(
                children: [
                  TableRow(children: [
                    buildButton("C", 1, Colors.redAccent),
                    buildButton("⌫", 1, Colors.redAccent),
                    buildButton("÷", 1, Colors.blue),
                  ]),
                  TableRow(children: [
                    buildButton("7", 1, Colors.black87),
                    buildButton("8", 1, Colors.black87),
                    buildButton("9", 1, Colors.black87),
                  ]),
                  TableRow(children: [
                    buildButton("4", 1, Colors.black87),
                    buildButton("5", 1, Colors.black87),
                    buildButton("6", 1, Colors.black87),
                  ]),
                  TableRow(children: [
                    buildButton("1", 1, Colors.black87),
                    buildButton("2", 1, Colors.black87),
                    buildButton("3", 1, Colors.black87),
                  ]),
                  TableRow(children: [
                    buildButton(".", 1, Colors.black87),
                    buildButton("0", 1, Colors.black87),
                    buildButton("00", 1, Colors.black87),
                  ]),
                ],
              ),
            ),
            SizedBox(
              width: MediaQuery.of(context).size.width * 0.25,
              child: Table(children: [
                TableRow(children: [
                  buildButton("×", 1, Colors.blue),
                ]),
                TableRow(children: [
                  buildButton("-", 1, Colors.blue),
                ]),
                TableRow(children: [
                  buildButton("+", 1, Colors.blue),
                ]),
                TableRow(children: [
                  buildButton("=", 2, Colors.redAccent),
                ]),
              ]),
            )
          ],
        )
      ]),
    );
  }
}
