import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:material_design_icons_flutter/material_design_icons_flutter.dart';
import 'package:reactive_forms/reactive_forms.dart';

class ShipantherTextFormField<T> extends StatelessWidget {
  const ShipantherTextFormField({
    Key? key,
    this.formControlName,
    required this.labelText,
    this.keyboardType,
    this.validationMessages = const {},
    this.autocorrect = false,
    this.enableSuggestions = true,
    this.obscureText = false,
    this.isPasswordField = false,
    this.autovalidateMode,
    this.maxLengthEnforcement,
    this.maxLength,
    this.suffixIconData,
    this.onSuffixButtonPressed,
    this.formControl,
  }) : super(
          key: key,
        );
  final String? formControlName;
  final String labelText;
  final TextInputType? keyboardType;
  final Map<String, String> validationMessages;
  final bool autocorrect;
  final bool enableSuggestions;
  final bool obscureText;
  final bool isPasswordField;
  final AutovalidateMode? autovalidateMode;
  final MaxLengthEnforcement? maxLengthEnforcement;
  final int? maxLength;
  final IconData? suffixIconData;
  final void Function()? onSuffixButtonPressed;
  final FormControl<T>? formControl;

  @override
  Widget build(BuildContext context) {
    Widget? suffixIcon;
    if (suffixIconData != null) {
      suffixIcon = Padding(
        padding: const EdgeInsetsDirectional.only(
          start: 8.0,
        ),
        child: IconButton(
          icon: Icon(suffixIconData),
          onPressed: onSuffixButtonPressed,
        ),
      );
    }
    final decoration = InputDecoration(
      border: const OutlineInputBorder(),
      contentPadding: const EdgeInsets.symmetric(
        vertical: 10.0,
        horizontal: 10.0,
      ),
      labelText: labelText,
      suffixIcon: suffixIcon,
      counterText: '',
    );
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: ReactiveTextField<T>(
        formControlName: formControlName,
        formControl: formControl,
        validationMessages: (control) => validationMessages,
        decoration: decoration,
        maxLength: maxLength,
        maxLengthEnforcement: maxLengthEnforcement,
        autocorrect: autocorrect,
        enableSuggestions: enableSuggestions,
        keyboardType: keyboardType,
        obscureText: obscureText,
      ),
    );
  }
}

class ShipantherPasswordFormField extends StatefulWidget {
  const ShipantherPasswordFormField({
    Key? key,
    required this.labelText,
    required this.formControlName,
    this.validationMessages = const {},
  }) : super(
          key: key,
        );
  final String labelText;
  final String formControlName;
  final Map<String, String> validationMessages;
  @override
  ShipantherPasswordFormFieldState createState() =>
      ShipantherPasswordFormFieldState();
}

class ShipantherPasswordFormFieldState
    extends State<ShipantherPasswordFormField> {
  var _visible = false;
  @override
  Widget build(BuildContext context) {
    return ShipantherTextFormField<String>(
      formControlName: widget.formControlName,
      validationMessages: widget.validationMessages,
      labelText: widget.labelText,
      suffixIconData: _visible ? MdiIcons.eyeOff : MdiIcons.eye,
      onSuffixButtonPressed: () {
        setState(() {
          _visible = !_visible;
        });
      },
      isPasswordField: true,
      enableSuggestions: false,
      autocorrect: false,
      obscureText: !_visible,
    );
  }
}

class ShipantherButton extends StatelessWidget {
  const ShipantherButton({
    Key? key,
    required this.labelText,
    required this.onPressed,
    this.secondary = false,
  }) : super(
          key: key,
        );

  final String labelText;
  final void Function()? onPressed;
  final bool secondary;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Expanded(
            child: SizedBox(
              child: ElevatedButton(
                style: ElevatedButton.styleFrom(
                  primary: secondary
                      ? Theme.of(context).scaffoldBackgroundColor
                      : Theme.of(context).primaryColor,
                  padding: const EdgeInsets.all(20),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(40.0),
                  ),
                ),
                onPressed: onPressed,
                child: Text(
                  labelText,
                  style: TextStyle(
                    color: secondary
                        ? Theme.of(context).primaryColor
                        : Theme.of(context).scaffoldBackgroundColor,
                  ),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
