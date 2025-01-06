import 'package:flutter/material.dart';

class PasswordField extends StatefulWidget {
  final String labelText;
  final IconData iconData;
  final bool isPasswordField;
  final TextInputType keyboardType;
  final TextInputAction? textInputAction;
  final TextEditingController? controller;
  final FormFieldValidator<String>? validator;
  final FormFieldSetter<String>? onSaved;

  const PasswordField({
    super.key,
    required this.labelText,
    required this.iconData,
    this.isPasswordField = true,
    this.keyboardType = TextInputType.visiblePassword,
    this.textInputAction,
    this.controller,
    this.validator,
    this.onSaved,
  });

  @override
  State<PasswordField> createState() => _PasswordFieldState();
}

class _PasswordFieldState extends State<PasswordField> {
  bool isPasswordVisible = false;

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      obscureText: widget.isPasswordField && !isPasswordVisible,
      keyboardType: widget.keyboardType,
      textInputAction: widget.textInputAction,
      controller: widget.controller,
      validator: widget.validator,
      onSaved: widget.onSaved,
      decoration: InputDecoration(
        labelText: widget.labelText,
        labelStyle: const TextStyle(
          color: Color(0xFF024F31),
          fontFamily: 'Inter',
          fontSize: 16,
          fontWeight: FontWeight.w600,
        ),
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
            color: Color(0xFF024F31), // Grey border when not focused
            width: 1.0,
          ),
        ),
        prefixIcon: Icon(
          widget.iconData,
          color: const Color(0xFF024F31),
        ),
        suffixIcon: widget.isPasswordField
            ? IconButton(
          icon: Icon(
            isPasswordVisible
                ? Icons.visibility
                : Icons.visibility_off,
            color: const Color(0xFF024F31),
          ),
          onPressed: () {
            setState(() {
              isPasswordVisible = !isPasswordVisible;
            });
          },
        )
            : null,
      ),
      style: const TextStyle(
        fontFamily: 'Inter',
        fontSize: 16,
        fontWeight: FontWeight.w600,
        color: Colors.black,
      ),
    );
  }
}
