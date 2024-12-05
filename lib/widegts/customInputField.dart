import 'package:flutter/material.dart';

class CustomInputField extends StatelessWidget {
  final String labelText;
  final IconData? iconData;
  final bool isPasswordField;
  final TextInputType keyboardType;
  final TextEditingController? controller;
  final TextInputAction? textInputAction;


  const CustomInputField({
    super.key,
    required this.labelText,
    this.iconData,
    this.isPasswordField = false,
    this.keyboardType = TextInputType.text,
    this.textInputAction,
    this.controller,

  });

  @override
  Widget build(BuildContext context) {
    return TextField(
      controller: controller,
      obscureText: isPasswordField,
      keyboardType: keyboardType,
      cursorColor: const Color(0xFF024F31),
      style: const TextStyle(
        fontFamily: 'Inter',
        fontSize: 16,
        fontWeight: FontWeight.w600,
        color: Colors.black,
      ),
      decoration: InputDecoration(
        labelText: labelText,
        labelStyle: const TextStyle(color: Color(0xFF024F31),fontFamily: 'Inter',fontWeight: FontWeight.w600,fontSize: 16),
        prefixIcon: iconData != null ? Icon(iconData, color: const Color(0xFF024F31),) : null,
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(10),
        ),
        focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(10),
          borderSide: const BorderSide(
            color: Color(0xFF024F31), // Dark green focus border
            width: 2.0, // Thickness of the focus border
          ),
        ),
        enabledBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(10),
          borderSide: const BorderSide(
            color: Color(0xFF024F31), // darkgreen border when not focused
            width: 1.0,
          ),
        ),
      ),
    );
  }
}

