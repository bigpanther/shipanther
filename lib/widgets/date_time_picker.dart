import 'package:reactive_date_time_picker/reactive_date_time_picker.dart';
import 'package:flutter/material.dart';
import 'package:shipanther/l10n/locales/date_formatter.dart';

ReactiveDateTimePicker dateTimePicker(
    BuildContext context, String title, String formControlName) {
  return ReactiveDateTimePicker(
    formControlName: formControlName,
    type: ReactiveDatePickerFieldType.dateTime,
    dateFormat: dateTimeFormatter,
    firstDate: DateTime.now().subtract(const Duration(days: 7)).toUtc(),
    lastDate: DateTime(2100).toUtc(),
    decoration: const InputDecoration(icon: Icon(Icons.event)),
    // icon: ,
    fieldLabelText: title,
    helpText: title,
    fieldHintText: title,
  );
}
