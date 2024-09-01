
import 'package:stock_records/utils/RegExUtil.dart';

class ObjectUtil {
  static double? optDouble(Object? object) {
    String number = optString(object);
    if (RegExUtil.isFloatingNumber(number)) {
      return double.tryParse(number);
    }
    return null;
  }

  static double optDoubleWithDefault(Object? object, double defaultValue) {
    double? dVal = optDouble(object);
    return dVal ?? defaultValue;
  }

  // Assuming optString function exists
  static String optString(Object? object) {
    return object?.toString() ?? '';
  }


}