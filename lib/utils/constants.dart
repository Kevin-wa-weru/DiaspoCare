import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

const primaryColor = Colors.blue;
const secondaryColor = Color(0xFF4472C4);
const textFieldBorder = Color(0xFF84C2B6);
const loadingButtonColor = Color(0xBF4472C4);

class UpperCaseTextFormatter extends TextInputFormatter {
  @override
  TextEditingValue formatEditUpdate(
      TextEditingValue oldValue, TextEditingValue newValue) {
    return TextEditingValue(
      text: newValue.text.toUpperCase(),
      selection: newValue.selection,
    );
  }
}
