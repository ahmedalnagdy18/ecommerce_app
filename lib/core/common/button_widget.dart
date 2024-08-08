import 'package:flutter/material.dart';

class AddToCartButton extends StatelessWidget {
  const AddToCartButton(
      {super.key, required this.onPressed, required this.buttonText});
  final void Function() onPressed;
  final String buttonText;
  @override
  Widget build(BuildContext context) {
    return MaterialButton(
      height: 40,
      //   minWidth: 120,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(25)),
      color: Colors.black,
      elevation: 0,

      onPressed: onPressed,
      child: Text(
        buttonText,
        textAlign: TextAlign.center,
        style: const TextStyle(
          color: Colors.white,
          fontSize: 14,
          fontWeight: FontWeight.w700,
        ),
      ),
    );
  }
}

class ButtonWidget extends StatelessWidget {
  const ButtonWidget(
      {super.key,
      required this.text,
      required this.onPressed,
      required this.color,
      required this.textColor});
  final String text;
  final void Function()? onPressed;
  final Color? color;
  final Color textColor;
  @override
  Widget build(BuildContext context) {
    return MaterialButton(
      onPressed: onPressed,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(6)),
      padding: const EdgeInsets.all(0.0),
      child: Ink(
        decoration:
            BoxDecoration(color: color, borderRadius: BorderRadius.circular(6)),
        child: Container(
          constraints: const BoxConstraints(
            minHeight: 61,
          ),
          alignment: Alignment.center,
          child: Text(
            text,
            textAlign: TextAlign.center,
            style: TextStyle(
              color: textColor,
              fontSize: 16,
              fontWeight: FontWeight.w700,
            ),
          ),
        ),
      ),
    );
  }
}
