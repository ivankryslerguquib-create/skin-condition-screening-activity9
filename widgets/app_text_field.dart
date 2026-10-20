import 'package:flutter/material.dart';

class AppTextField extends StatelessWidget {
  const AppTextField({
    super.key,
    required this.controller,
    required this.label,
    required this.hint,
    this.validator,
    this.maxLines = 1,
    this.prefixIcon,
    this.keyboardType,
  });

  final TextEditingController controller;
  final String label;
  final String hint;
  final String? Function(String?)? validator;
  final int maxLines;
  final IconData? prefixIcon;
  final TextInputType? keyboardType;

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      controller: controller,
      validator: validator,
      maxLines: maxLines,
      keyboardType: keyboardType,
      decoration: InputDecoration(
        labelText: label,
        hintText: hint,
        prefixIcon:
            prefixIcon == null ? null : Icon(prefixIcon),
        filled: true,
        fillColor: Colors.white,
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(12),
        ),
      ),
    );
  }
}