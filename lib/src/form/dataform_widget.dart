import 'package:flutter/material.dart';

/// A widget that manages a [Map] of data that will be used to store
/// the data of the form fields.
///
/// Wrap your form widgets with this widget and call the builder function
/// in the end of the form to get the data according to the form fields. Use
/// [DataFormState.maybeOf] or [DataFormState.of] to get the instance of
// ignore: comment_references
/// [DataFormState] to call [fetchData] or [saveField].
///
/// You can optionally pass a [Map<String, dynamic>] to the constructor to
/// control the data from outside the widget tree.
class DataForm extends StatefulWidget {
  /// The builder function that should be called when the form is submitted.
  final Widget Function(
    BuildContext context,
  ) builder;

  /// You can optionally pass a [Map<String, dynamic>] to the constructor to
  /// control the data from outside the widget tree.
  final Map<String, dynamic>? data;

  /// If set to true, the data will be reset when the fetchData
  /// function is called.
  final bool resetData;

  /// Creates a [DataForm] widget.
  const DataForm({
    required this.builder,
    this.resetData = true,
    this.data,
    super.key,
  });

  @override
  State<DataForm> createState() => DataFormState();
}

/// Use [DataFormState.maybeOf] or [DataFormState.of] to get the state
/// of current [DataForm]. With this state you can call [fetchData] to
/// get the form data as a [Map<String, dynamic>] or [saveField] to
/// save a value in the form data.
class DataFormState extends State<DataForm> {
  final _formKey = GlobalKey<FormState>();
  late Map<String, dynamic> _data;
  late List<String>? _validationFieldsId;

  @override
  void initState() {
    super.initState();
    _data = widget.data ?? {};
  }

  /// Check if the field with the given id should be validated.
  /// If the [id] is not in the list of fields to be validated, it will
  /// return false. But if the list is null, it will return true.
  ///
  /// This method is used internally by the form fields to check if they
  /// should be validated or not when [validateFields] method is called.
  bool checkFieldId(String id) {
    return _validationFieldsId?.contains(id) ?? true;
  }

  /// Call this method to validate specific fields in the form by their ids.
  /// The [ids] is a list of strings that represents the ids of the fields
  /// that should be validated.
  ///
  /// This is very useful when you want to build a form with multiple steps
  /// and you want to validate only the fields of the current step.
  ///
  /// Returns a Map with the fields ids and values if all the fields are valid,
  /// otherwise returns null.
  Map<String, dynamic>? validateFields(List<String> ids) {
    _validationFieldsId = ids;
    if (_formKey.currentState?.validate() ?? false) {
      _formKey.currentState?.save();
      return _data;
    }

    return null;
  }

  /// Call this method to get the form data as a [Map<String, dynamic>] if
  /// all the fields are valid.
  ///
  /// The content of the map is based on the ids specified in the
  /// form fields widgets.
  ///
  /// Before returning the data, the form will
  /// validate all the fields and if any of them is invalid, this
  /// method will return null.
  Map<String, dynamic>? fetchData() {
    _validationFieldsId = null;
    if (widget.resetData) _data.clear();
    if (_formKey.currentState?.validate() ?? false) {
      _formKey.currentState?.save();
      return _data;
    }

    return null;
  }

  /// Call this method to save a value in the form data.
  ///
  /// The [value] is the value that will be saved in the [Map]. It can be
  /// any type.
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
  void saveField({
    dynamic value,
    String? id,
    bool Function(Map<String, dynamic> data)? conditional,
  }) {
    if (id != null && (conditional == null || conditional(_data))) {
      var currentMap = _data;

      final tokens = id.split('/');
      for (var i = 0; i < tokens.length; i++) {
        if (i != tokens.length - 1) {
          currentMap = currentMap[tokens[i]] ??= <String, dynamic>{};
        }
        if (i == tokens.length - 1) {
          currentMap[tokens[i]] = value;
        }
      }
    }
  }

  /// Returns the [DataFormState] of the closest [DataForm]
  /// widget which encloses the given context, or null if none is found.
  static DataFormState? maybeOf(BuildContext context) {
    final scope = _DataFormBase.maybeOf(context);
    return scope?.formState;
  }

  /// Returns the [DataFormState] of the closest [DataForm]
  /// widget which encloses the given context. Throws a error if none is found.
  static DataFormState of(BuildContext context) {
    final scope = _DataFormBase.of(context);
    return scope.formState;
  }

  @override
  Widget build(BuildContext context) {
    return Form(
      key: _formKey,
      child: _DataFormBase(
        formState: this,
        child: Builder(
          builder: (context) {
            return widget.builder(context);
          },
        ),
      ),
    );
  }
}

class _DataFormBase extends InheritedWidget {
  const _DataFormBase({
    required this.formState,
    required super.child,
  });

  final DataFormState formState;

  static _DataFormBase? maybeOf(BuildContext context) {
    return context.dependOnInheritedWidgetOfExactType<_DataFormBase>();
  }

  static _DataFormBase of(BuildContext context) {
    final result = maybeOf(context);
    assert(result != null, 'No DataForm found in context');
    return result!;
  }

  // coverage:ignore-start
  @override
  bool updateShouldNotify(_DataFormBase oldWidget) => false;
  // coverage:ignore-end
}
