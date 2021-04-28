import 'package:enum_to_string/enum_to_string.dart';
import 'package:flutter/material.dart';
import 'package:shipanther/l10n/locales/l10n.dart';

class FilterButton<T> extends StatelessWidget {
  const FilterButton({
    required this.onSelected,
    required this.activeFilter,
    required this.isActive,
    Key? key,
    required this.possibleValues,
    required this.tooltip,
  }) : super(key: key);

  final List<T> possibleValues;
  final PopupMenuItemSelected<T?> onSelected;
  final T? activeFilter;
  final bool isActive;
  final String tooltip;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final defaultStyle = theme.textTheme.bodyText2;
    final activeStyle = theme.textTheme.bodyText2!.copyWith(
      color: theme.accentColor,
    );
    final button = _Button<T?>(
      onSelected: onSelected,
      activeFilter: activeFilter,
      activeStyle: activeStyle,
      defaultStyle: defaultStyle!,
      possibleValues: possibleValues,
      tooltip: tooltip,
    );

    return AnimatedOpacity(
      opacity: isActive ? 1.0 : 0.0,
      duration: const Duration(milliseconds: 150),
      child: isActive ? button : IgnorePointer(child: button),
    );
  }
}

class _Button<T> extends StatelessWidget {
  const _Button({
    Key? key,
    required this.onSelected,
    required this.activeFilter,
    required this.activeStyle,
    required this.defaultStyle,
    required this.possibleValues,
    required this.tooltip,
  }) : super(key: key);

  final PopupMenuItemSelected<T?> onSelected;
  final T activeFilter;
  final TextStyle activeStyle;
  final TextStyle defaultStyle;
  final List<T> possibleValues;
  final String tooltip;

  @override
  Widget build(BuildContext context) {
    return PopupMenuButton<T?>(
      tooltip: tooltip,
      onSelected: onSelected,
      onCanceled: () => onSelected(null),
      itemBuilder: (BuildContext context) {
        final items = possibleValues
            .map(
              (e) => PopupMenuItem<T>(
                value: e,
                child: Text(
                  EnumToString.convertToString(e, camelCase: true),
                  style: activeFilter == e ? activeStyle : defaultStyle,
                ),
              ),
            )
            .toList();
        items.add(
          PopupMenuItem<T>(
            value: null,
            child: Text(
              ShipantherLocalizations.of(context).clear,
              style: defaultStyle,
            ),
          ),
        );
        return items;
      },
      icon: const Icon(Icons.filter_list),
    );
  }
}
