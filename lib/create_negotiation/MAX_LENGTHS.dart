
// This is a list of the maximum characters in each text input
import 'package:flutter/services.dart';

final int MAX_TITLE_LENGTH = 39;
final int MAX_SUMMARY_LENGTH = 255;
final int MAX_ISSUE_NAME = 27;

// Because the max points is 100, any number entered by user can be at most 3 digits

final List<TextInputFormatter> INTEGER_INPUTS = [
  FilteringTextInputFormatter.allow(RegExp("[0-9]")),
  LengthLimitingTextInputFormatter(2)
];