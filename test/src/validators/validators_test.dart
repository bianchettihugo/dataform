import 'package:dataform/src/validators/validators.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  group('DFValidators', () {
    test('isNotEmpty should return true for non-empty string', () {
      expect(DFValidators.isNotEmpty('hello'), isTrue);
    });

    test('isNotEmpty should return false for empty string', () {
      expect(DFValidators.isNotEmpty(''), isFalse);
    });

    test('equals should return true for equal strings', () {
      expect(DFValidators.equals('hello', 'hello'), isTrue);
    });

    test('equals should return false for different strings', () {
      expect(DFValidators.equals('hello', 'world'), isFalse);
    });

    test('contains should return true if string contains substring', () {
      expect(DFValidators.contains('hello', 'ell'), isTrue);
    });

    test('contains should return false if string does not contain substring',
        () {
      expect(DFValidators.contains('hello', 'abc'), isFalse);
    });

    test('matches should return true if string matches pattern', () {
      expect(DFValidators.matches('hello', r'^[a-z]+$'), isTrue);
    });

    test('matches should return false if string does not match pattern', () {
      expect(DFValidators.matches('hello', r'^[0-9]+$'), isFalse);
    });

    test('isNumeric should return true for numeric string', () {
      expect(DFValidators.isNumeric('123'), isTrue);
    });

    test('isNumeric should return false for non-numeric string', () {
      expect(DFValidators.isNumeric('abc'), isFalse);
    });

    test('isEmail should return true for valid email', () {
      expect(DFValidators.isEmail('test@example.com'), isTrue);
    });

    test('isEmail should return false for invalid email', () {
      expect(DFValidators.isEmail('test@example'), isFalse);
    });

    test(
        'isGreaterThan should return true if numeric string is greater'
        ' than number', () {
      expect(DFValidators.isGreaterThan('10', 5), isTrue);
    });

    test(
        'isGreaterThan should return false if numeric string is not greater'
        ' than number', () {
      expect(DFValidators.isGreaterThan('5', 10), isFalse);
    });

    test('isLowercase should return true for lowercase string', () {
      expect(DFValidators.isLowercase('hello'), isTrue);
    });

    test('isLowercase should return false for non-lowercase string', () {
      expect(DFValidators.isLowercase('Hello'), isFalse);
    });

    test('isUppercase should return true for uppercase string', () {
      expect(DFValidators.isUppercase('HELLO'), isTrue);
    });

    test('isUppercase should return false for non-uppercase string', () {
      expect(DFValidators.isUppercase('Hello'), isFalse);
    });

    test('isNull should return true for null or empty string', () {
      expect(DFValidators.isNull(null), isTrue);
      expect(DFValidators.isNull(''), isTrue);
    });

    test('isNull should return false for non-null and non-empty string', () {
      expect(DFValidators.isNull('hello'), isFalse);
    });

    test('isIn should return true if string is in list of values', () {
      expect(DFValidators.isIn('hello', ['hello', 'world']), isTrue);
    });

    test('isIn should return false if string is not in list of values', () {
      expect(DFValidators.isIn('hello', ['foo', 'bar']), isFalse);
    });

    test(
        'isLength should return true if string length is greater than or'
        ' equal to number', () {
      expect(DFValidators.isLength('hello', 3), isTrue);
    });

    test('isLength should return false if string length is less than number',
        () {
      expect(DFValidators.isLength('hello', 10), isFalse);
    });
  });

  group('DFValidators - Edge Cases', () {
    test('isNotEmpty should return false for null string', () {
      expect(DFValidators.isNotEmpty(null), isFalse);
    });

    test('equals should return false for null string', () {
      expect(DFValidators.equals(null, 'null'), isFalse);
    });

    test('contains should return false for null string', () {
      expect(DFValidators.contains(null, 'abc'), isFalse);
    });

    test('matches should return false for null string', () {
      expect(DFValidators.matches(null, r'^[a-z]+$'), isFalse);
    });

    test('isNumeric should return false for null string', () {
      expect(DFValidators.isNumeric(null), isFalse);
    });

    test('isEmail should return false for null string', () {
      expect(DFValidators.isEmail(null), isFalse);
    });

    test('isGreaterThan should return false for null string', () {
      expect(DFValidators.isGreaterThan(null, 5), isFalse);
    });

    test('isLowercase should return false for null string', () {
      expect(DFValidators.isLowercase(null), isFalse);
    });

    test('isUppercase should return false for null string', () {
      expect(DFValidators.isUppercase(null), isFalse);
    });

    test('isNull should return true for null string', () {
      expect(DFValidators.isNull(null), isTrue);
    });

    test('isIn should return false for null string', () {
      expect(DFValidators.isIn(null, ['foo', 'bar']), isFalse);
    });

    test('isLength should return false for null string', () {
      expect(DFValidators.isLength(null, 10), isFalse);
    });
  });
}
