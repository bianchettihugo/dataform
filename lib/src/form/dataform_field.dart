import 'package:dataform/src/form/dataform_widget.dart';
import 'package:flutter/material.dart';

/// Wrap your form fields with this widget to specify its ids
/// and optionally a formatter. This widget **must** be a descendant
/// of a [DataForm] widget.
///
/// The [id] is used to identify the field in the [Map]. The [id] must be
/// unique for each field and contain "/" if you want to nest the field
/// inside the map. Example, fields with the following ids:
///
///
/// * user/name
/// * user/age
/// * user/address/street
/// * user/address/number
/// * admin
///
///
/// will result in the following map:
///
/// ```
/// {
///   "user": {
///     name: "...",
///     age: "...",
///     address: {
///       street: "...",
///       number: "...",
///     }
///   },
///  "admin": "...",
/// }
/// ```
///
/// You can optionally pass a [conditional] function to control if the
/// value should be saved or not based on the current data in the map.
class DataFormField<T> extends StatelessWidget {
  /// The id of the field that will be used to identify it in the [Map].
  final String id;

  /// The child widget that will be placed in a form.
  final Widget child;

  /// The value of the field that will be stored in the map.
  final T value;

  /// A function that will be called to check if the value should be saved
  final bool Function(Map<String, dynamic> data)? conditional;

  /// An optional function that will be called to validate the value.
  final String? Function(T?)? validator;

  /// Optional callback that formats the text to be saved in the map.
  final dynamic Function(T)? formatter;

  /// Creates a [DataFormField] widget.
  const DataFormField({
    required this.id,
    required this.value,
    required this.child,
    this.validator,
    this.conditional,
    this.formatter,
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return FormField<T>(
      validator: validator,
      onSaved: (_) {
        final dataForm = DataFormState.maybeOf(context);
        dataForm?.saveField(
          id: id,
          value: formatter?.call(value) ?? value,
          conditional: conditional,
        );
      },
      builder: (state) {
        return child;
      },
    );
  }
}
