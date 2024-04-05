import 'package:flutter/material.dart';

class ButtonWidget extends StatelessWidget {
  final String text;
  VoidCallback onPressed;

  ButtonWidget({super.key, required this.text, required this.onPressed});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(left: 5),
      child: MaterialButton(
        onPressed: onPressed,
        color: Colors.white,
        textColor: Colors.black, // Set text color
        elevation: 5, // Set elevation
        shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(10)), // Set button shape
        padding: const EdgeInsets.symmetric(vertical: 12, horizontal: 24),

        child: Text(text), // Set padding
      ),
    );
  }
}
