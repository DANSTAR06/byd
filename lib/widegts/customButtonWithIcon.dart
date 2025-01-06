import 'package:flutter/material.dart';

class CustomButtonWithIcon extends StatelessWidget {
  final String text;
  final String iconPath; // Path to the icon image asset
  final VoidCallback onPressed;
  final Color backgroundColor;
  final Color borderColor;
  final Color textColor;
  final double borderRadius;
  final double paddingVertical;
  final Icon? icon;

  const CustomButtonWithIcon({
    super.key,
    required this.text,
    required this.iconPath,
    required this.onPressed,
    this.backgroundColor = const Color(0xFF024F31),
    this.borderColor = Colors.white,
    this.textColor = Colors.white,
    this.borderRadius = 10,
    this.paddingVertical = 12,
    this.icon,
  });

  @override
  Widget build(BuildContext context) {
    return ElevatedButton.icon(
      onPressed: onPressed,
      icon: Image.asset(
        iconPath,
        width: 32,
        height: 30,
      ),
      label: Text(
        text,
        style: TextStyle(
          fontFamily: 'Inter',
          fontSize: 16,
          fontWeight: FontWeight.w600,
          color: textColor,
        ),
      ),

      style: ElevatedButton.styleFrom(
        backgroundColor: backgroundColor,
        minimumSize: const Size(double.infinity, 50),
        //padding: EdgeInsets.symmetric(vertical: paddingVertical),
        side: BorderSide(color: borderColor),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(borderRadius),
        ),
        elevation: 2,
      ),
    );
  }
}
