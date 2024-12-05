import 'package:flutter/material.dart';

class CustomButton extends StatelessWidget {
  final String label;
  final VoidCallback onPressed;
  final Color backgroundColor;
  final double elevation;
  final TextStyle textStyle;
  final double borderRadius;

  // Constructor to initialize the values
  const CustomButton({
    super.key,
    required this.label,
    required this.onPressed,
    this.backgroundColor = const Color(0xFF024F31), // Default color
    this.elevation = 1.0, // Default elevation
    this.textStyle = const TextStyle(
      fontFamily: "Inter",
      fontSize: 16,
      fontWeight: FontWeight.w600,
      color: Colors.white,
    ), // Default text style
    this.borderRadius = 2.0, // Default border radius
  });

  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
      onPressed: onPressed,
      style: ElevatedButton.styleFrom(
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(borderRadius),
        ),
        elevation: elevation,
        backgroundColor: backgroundColor,
      ),
      child: Text(label, style: textStyle),
    );
  }
}
