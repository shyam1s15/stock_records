class RegExUtil {
  
  // Assuming isFloatingNumber function exists
  static bool isFloatingNumber(String number) {
    final regex = RegExp(r'^[+-]?([0-9]*[.])?[0-9]+$');
    return regex.hasMatch(number);
  }
}

