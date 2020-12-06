import 'package:flutter/material.dart';
import 'package:smart_select/smart_select.dart';

SmartSelect<T> smartSelect<T>(
    {@required String title,
    @required void Function(S2SingleState<T>) onChange,
    @required List<S2Choice<T>> choiceItems,
    @required T value}) {
  return SmartSelect<T>.single(
    title: title,
    onChange: onChange,
    choiceItems: choiceItems,
    modalType: S2ModalType.popupDialog,
    modalStyle: const S2ModalStyle(
      backgroundColor: Colors.grey,
    ),
    modalHeader: true,
    tileBuilder: (context, state) {
      return S2Tile.fromState(
        state,
        trailing: const Icon(Icons.arrow_drop_down),
        isTwoLine: true,
      );
    },
    value: value,
  );
}
