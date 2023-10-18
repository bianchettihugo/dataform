import 'package:dataform/src/form/dataform_widget.dart';
import 'package:flutter/material.dart';

/// Specifies the position of the checkbox in the [DataformCheckbox] widget
enum CheckboxPosition {
  /// The checkbox is on the left side of the content
  left,

  /// The checkbox is on the right side of the content
  right
}

/// A widget that displays a checkbox with a text and a description
///
/// Can be used inside a [DataForm] widget and have an id to save the value
/// on a data map
class DataformCheckbox extends StatefulWidget {
  /// The text to display
  final String text;

  /// The optional description to display below the text
  final String? description;

  /// The style of the text
  final TextStyle? style;

  /// The style of the description
  final TextStyle? descriptionStyle;

  /// Whether to use the Material 3 design
  final bool useMaterial3;

  /// Whether the checkbox is active or not
  final bool active;

  /// The function to call when the checkbox is changed
  // ignore: avoid_positional_boolean_parameters
  final Function(bool)? onChanged;

  /// The color of the border
  final Color? borderColor;

  /// The id to save the value on a data map
  final String? id;

  /// Whether to use a background color
  final bool background;

  /// A function to call before changing the value. If the function returns
  /// true, the value will be changed, otherwise it will not
  final Future<bool> Function()? conditional;

  /// The color scheme to use on the checkbox
  final ColorScheme? colorScheme;

  /// Whether to unfocus the scope when the value is changed
  final bool unfocusOnChange;

  /// The decoration of the widget
  final BoxDecoration? decoration;

  /// The position of the checkbox
  final CheckboxPosition checkboxPosition;

  /// Creates a new switch option
  const DataformCheckbox({
    required this.text,
    this.description,
    this.style,
    this.descriptionStyle,
    this.active = false,
    this.onChanged,
    this.borderColor,
    this.id,
    this.background = false,
    this.conditional,
    this.useMaterial3 = false,
    this.unfocusOnChange = false,
    this.colorScheme,
    this.decoration,
    this.checkboxPosition = CheckboxPosition.right,
    super.key,
  });

  @override
  State<DataformCheckbox> createState() => _DataformCheckboxState();
}

class _DataformCheckboxState extends State<DataformCheckbox> {
  late bool active;

  @override
  void initState() {
    active = widget.active;
    super.initState();
  }

  Future<void> _onChange([bool? value]) async {
    if (widget.unfocusOnChange) FocusScope.of(context).unfocus();
    if (widget.conditional != null) {
      if (!await widget.conditional!()) return;
    }

    setState(() {
      active = value ?? !active;
    });

    if (widget.onChanged != null) {
      widget.onChanged?.call(value ?? active);
    }
  }

  Widget checkboxWidget(BuildContext context) {
    return FormField<bool>(
      onSaved: (value) {
        final dataForm = DataFormState.maybeOf(context);
        dataForm?.saveField(
          id: widget.id,
          value: value ?? false,
        );
      },
      builder: (state) => Checkbox(
        value: active,
        activeColor: Theme.of(context).primaryColor,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(4),
        ),
        side: BorderSide(
          width: 2,
          color: widget.borderColor ?? Theme.of(context).hintColor,
        ),
        onChanged: _onChange,
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Theme(
      data: Theme.of(context).copyWith(
        useMaterial3: widget.useMaterial3,
        colorScheme: widget.colorScheme,
      ),
      child: InkWell(
        onTap: _onChange,
        child: Container(
          padding: EdgeInsets.symmetric(
            horizontal: widget.background ? 12 : 0,
            vertical: 8,
          ),
          decoration: widget.decoration,
          child: Row(
            children: [
              if (widget.checkboxPosition == CheckboxPosition.left) ...[
                checkboxWidget(context),
                const SizedBox(width: 10),
              ],
              Expanded(
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      widget.text,
                      textAlign: TextAlign.start,
                      style: widget.style,
                    ),
                    if (widget.description != null) ...[
                      const SizedBox(height: 5),
                      Text(
                        widget.description!,
                        style: widget.descriptionStyle,
                      ),
                    ],
                  ],
                ),
              ),
              if (widget.checkboxPosition == CheckboxPosition.right) ...[
                const SizedBox(width: 10),
                checkboxWidget(context),
              ],
            ],
          ),
        ),
      ),
    );
  }
}
