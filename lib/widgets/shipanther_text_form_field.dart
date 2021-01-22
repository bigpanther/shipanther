import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:material_design_icons_flutter/material_design_icons_flutter.dart';

class ShipantherTextFormField extends StatelessWidget {
  const ShipantherTextFormField({
    Key? key,
    required this.controller,
    required this.labelText,
    this.keyboardType,
    this.validator,
    this.autocorrect = true,
    this.enableSuggestions = true,
    this.obscureText = false,
    this.isPasswordField = false,
    this.autovalidateMode,
    this.maxLengthEnforcement,
    this.maxLength,
    this.suffixIconData,
    this.onSuffixButtonPressed,
  }) : super(
          key: key,
        );
  final TextEditingController controller;
  final String labelText;
  final TextInputType? keyboardType;
  final String? Function(String?)? validator;
  final bool autocorrect;
  final bool enableSuggestions;
  final bool obscureText;
  final bool isPasswordField;
  final AutovalidateMode? autovalidateMode;
  final MaxLengthEnforcement? maxLengthEnforcement;
  final int? maxLength;
  final IconData? suffixIconData;
  final void Function()? onSuffixButtonPressed;

  @override
  Widget build(BuildContext context) {
    Widget? suffixIcon;
    if (isPasswordField) {
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
    );
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: TextFormField(
        controller: controller,
        decoration: decoration,
        autocorrect: autocorrect,
        enableSuggestions: enableSuggestions,
        keyboardType: keyboardType,
        obscureText: obscureText,
        autovalidateMode: autovalidateMode,
        maxLengthEnforcement: maxLengthEnforcement,
        maxLength: maxLength,
        validator: validator,
      ),
    );
  }
}

class ShipantherPasswordFormField extends StatefulWidget {
  const ShipantherPasswordFormField({
    Key? key,
    required this.labelText,
    required this.controller,
    this.validator,
  }) : super(
          key: key,
        );
  final String labelText;
  final TextEditingController controller;
  final String? Function(String?)? validator;
  @override
  ShipantherPasswordFormFieldState createState() =>
      ShipantherPasswordFormFieldState();
}

class ShipantherPasswordFormFieldState
    extends State<ShipantherPasswordFormField> {
  var _visible = false;
  @override
  Widget build(BuildContext context) {
    return ShipantherTextFormField(
      controller: widget.controller,
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
      validator: widget.validator,
      obscureText: !_visible,
    );
  }
}

class ShipantherButton extends StatelessWidget {
  const ShipantherButton({
    Key? key,
    required this.labelText,
    required this.onPressed,
  }) : super(
          key: key,
        );

  final String labelText;
  final void Function()? onPressed;

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
                  padding: const EdgeInsets.all(20),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(40.0),
                  ),
                ),
                onPressed: onPressed,
                child: Text(
                  labelText,
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
