import 'package:flutter/services.dart';

class CardNumberInputFormatter extends TextInputFormatter {
  @override
  TextEditingValue formatEditUpdate(
    TextEditingValue oldValue,
    TextEditingValue newValue,
  ) {
    final int newTextLength = newValue.text.length;
    int selectionIndex = newValue.selection.end;
    int usedSubstringIndex = 0;
    final StringBuffer newText = StringBuffer();

    if (newTextLength >= 5) {
      newText.write('${newValue.text.substring(0, usedSubstringIndex = 4)} ');
      if (newValue.selection.end >= 4) selectionIndex++;
    }
    if (newTextLength >= 9) {
      newText.write('${newValue.text.substring(4, usedSubstringIndex = 8)} ');
      if (newValue.selection.end >= 8) selectionIndex++;
    }
    if (newTextLength >= 13) {
      newText.write('${newValue.text.substring(8, usedSubstringIndex = 12)} ');
      if (newValue.selection.end >= 12) selectionIndex++;
    }
    if (newTextLength >= 17) {
      newText.write('${newValue.text.substring(12, usedSubstringIndex = 16)} ');
      if (newValue.selection.end >= 16) selectionIndex++;
    }

    // Dump the rest.
    if (newTextLength >= usedSubstringIndex) {
      newText.write(newValue.text.substring(usedSubstringIndex));
    }

    return TextEditingValue(
      text: newText.toString(),
      selection: TextSelection.collapsed(offset: selectionIndex),
    );
  }
}
