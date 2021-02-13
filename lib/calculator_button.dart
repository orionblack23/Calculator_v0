import 'package:flutter/material.dart';

class CalculatorButton extends StatelessWidget {
  final txtColor;
  final bgColor;
  final String txt;
  final buttonTap;
  CalculatorButton({this.bgColor, this.txt, this.txtColor, this.buttonTap});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: buttonTap,
          child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: ClipRRect(
          borderRadius: BorderRadius.circular(20),
          child:Container(
              child: Center(
                child: Text(txt,
                    style: TextStyle(
                      color: txtColor,
                      fontSize: 20,
                    )),
              ),
              color: bgColor,
            ),
          ),
      ),
    );
  }
}
