import 'package:date_time_picker/date_time_picker.dart';
import 'package:flutter/material.dart';
import 'package:shipanther/l10n/shipanther_localization.dart';

DateTimePicker dateTimePicker(
    BuildContext context, String title, TextEditingController controller) {
  return DateTimePicker(
    type: DateTimePickerType.dateTime,
    dateMask: ShipantherLocalizations.of(context)!.dateTimeFormatter.pattern,
    controller: controller,
    firstDate: DateTime.now(),
    lastDate: DateTime(2100),
    icon: const Icon(Icons.event),
    dateLabelText: title,
  );
}
