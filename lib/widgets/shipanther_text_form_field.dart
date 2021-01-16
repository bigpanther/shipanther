import 'package:flutter/material.dart';
import 'package:material_design_icons_flutter/material_design_icons_flutter.dart';

TextFormField shipantherTextFormField({
  required TextEditingController controller,
  required String labelText,
  TextInputType? keyboardType,
  String? Function(String?)? validator,
  bool autocorrect = true,
  bool enableSuggestions = true,
  bool obscureText = false,
  bool isPasswordField = false,
  IconData? suffixIconData,
  void Function()? onSuffixButtonPressed,
}) {
  Widget? suffixIcon;
  if (isPasswordField) {
    suffixIcon = Padding(
        padding: const EdgeInsetsDirectional.only(start: 8.0),
        child: IconButton(
            icon: Icon(suffixIconData), onPressed: onSuffixButtonPressed));
  }
  final decoration = InputDecoration(
    border: const OutlineInputBorder(),
    contentPadding:
        const EdgeInsets.symmetric(vertical: 10.0, horizontal: 10.0),
    labelText: labelText,
    suffixIcon: suffixIcon,
  );
  return TextFormField(
      controller: controller,
      decoration: decoration,
      autocorrect: autocorrect,
      enableSuggestions: enableSuggestions,
      keyboardType: keyboardType,
      obscureText: obscureText,
      validator: validator);
}

class ShipantherPasswordFormField extends StatefulWidget {
  const ShipantherPasswordFormField(
      {required this.labelText, required this.controller, this.validator});
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
    return shipantherTextFormField(
        controller: widget.controller,
        labelText: widget.labelText,
        suffixIconData: _visible ? MdiIcons.eyeOff : MdiIcons.eye,
        onSuffixButtonPressed: () {
          setState(() {
            print(_visible);
            _visible = !_visible;
          });
        },
        isPasswordField: true,
        validator: widget.validator,
        obscureText: !_visible);
  }
}
