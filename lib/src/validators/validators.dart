/// A set of common validators that can be used to validate form fields.
class DFValidators {
  static final RegExp _numeric = RegExp(r'^-?[0-9]+$');
  static final RegExp _email = RegExp(
    r'^(([^<>()[\]\\.,;:\s@\"]+(\.[^<>()[\]\\.,;:\s@\"]+)*)|(\".+\"))@((\[[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\])|(([a-zA-Z\-0-9]+\.)+[a-zA-Z]{2,}))$',
  );

  /// Check if a string is empty.
  static bool isNotEmpty(String? str) {
    if (str == null) return false;
    return str.isNotEmpty;
  }

  /// Check if a string is equal to other
  static bool equals(String? str, Object other) {
    return str == other.toString();
  }

  /// Check if a string contains a substring.
  static bool contains(String? str, Object substring) {
    if (str == null) return false;
    return str.contains(substring.toString());
  }

  /// Check if a string matches a pattern.
  static bool matches(String? str, String pattern) {
    if (str == null) return false;
    final re = RegExp(pattern);
    return re.hasMatch(str);
  }

  /// Check if a string is a valid number.
  static bool isNumeric(String? str) {
    if (str == null) return false;
    return _numeric.hasMatch(str);
  }

  /// Check if a string is a valid email.
  static bool isEmail(String? str) {
    if (str == null) return false;
    return _email.hasMatch(str);
  }

  /// Check if a numeric string is greater than a number.
  static bool isGreaterThan(String? str, int n) {
    if (str == null) return false;
    if (!isNumeric(str)) return false;

    final number = int.tryParse(str);
    if (number == null) return false;

    return number > n;
  }

  /// Check if a string is in lowercase.
  static bool isLowercase(String? str) {
    if (str == null) return false;
    return str == str.toLowerCase();
  }

  /// Check if a string is in uppercase.
  static bool isUppercase(String? str) {
    if (str == null) return false;
    return str == str.toUpperCase();
  }

  /// Check if a string is null or empty.
  static bool isNull(String? str) {
    return str == null || str.isEmpty;
  }

  /// Check if a string is in a list of values.
  static bool? isIn(String? str, List values) {
    if (str == null || values.isEmpty) {
      return false;
    }

    final valuesList = values.map((e) => e.toString()).toList();

    return valuesList.contains(str);
  }

  /// Check if a string length is greater than a number.
  static bool isLength(String? str, int i) {
    return str != null && str.length >= i;
  }
}
