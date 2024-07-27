import 'package:flutter/material.dart';

class ButtonWiget extends StatelessWidget {
  const ButtonWiget(
      {super.key, required this.onPressed, required this.buttonText});
  final void Function() onPressed;
  final String buttonText;
  @override
  Widget build(BuildContext context) {
    return MaterialButton(
      height: 40,
      //   minWidth: 120,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(25)),
      color: Colors.yellow.shade700,
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
