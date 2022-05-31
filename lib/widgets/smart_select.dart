import 'package:flutter/material.dart';
import 'package:flutter_awesome_select/flutter_awesome_select.dart';

SmartSelect<T> smartSelect<T>(
    {required BuildContext context,
    required String title,
    required void Function(S2SingleSelected<T>) onChange,
    required List<S2Choice<T>> choiceItems,
    required T value}) {
  return SmartSelect<T>.single(
    title: title,
    onChange: onChange,
    choiceItems: choiceItems,
    modalType: S2ModalType.popupDialog,
    modalStyle: S2ModalStyle(
      backgroundColor: Theme.of(context).backgroundColor,
    ),
    modalHeaderStyle: S2ModalHeaderStyle(
      backgroundColor: Theme.of(context).primaryColor,
      textStyle: Theme.of(context).primaryTextTheme.headline5,
    ),
    choiceStyle: S2ChoiceStyle(
      titleStyle: Theme.of(context).textTheme.bodyText1,
    ),
    modalHeader: true,
    tileBuilder: (context, state) {
      return S2Tile.fromState(
        state,
        trailing: const Icon(Icons.arrow_drop_down),
        isTwoLine: true,
      );
    },
    selectedValue: value,
  );
}
