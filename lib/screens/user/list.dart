import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shipanther/bloc/user/user_bloc.dart';
import 'package:shipanther/l10n/locales/l10n.dart';
import 'package:shipanther/screens/user/user_search_delegate.dart';
import 'package:shipanther/widgets/filter_button.dart';
import 'package:shipanther/widgets/shipanther_scaffold.dart';
import 'package:trober_sdk/trober_sdk.dart';

class UserList extends StatelessWidget {
  const UserList(this.loggedInUser,
      {Key? key, required this.userLoadedState, required this.userBloc})
      : super(key: key);

  final UserBloc userBloc;
  final UsersLoaded userLoadedState;
  final User loggedInUser;

  @override
  Widget build(BuildContext context) {
    final title = ShipantherLocalizations.of(context).usersTitle(2);
    final actions = <Widget>[
      IconButton(
        onPressed: () {
          showSearch(
            context: context,
            delegate: UserSearchDelegate(
              loggedInUser,
              context.read<UserBloc>(),
            ),
          );
        },
        icon: const Icon(Icons.search),
      ),
      FilterButton<UserRole>(
        possibleValues: UserRole.values.toList(),
        isActive: true,
        activeFilter: userLoadedState.userRole,
        onSelected: (t) => context.read<UserBloc>().add(
              GetUsers(userRole: t),
            ),
        tooltip: ShipantherLocalizations.of(context).userTypeFilter,
      )
    ];
    final body = listbody(context, loggedInUser, userBloc, userLoadedState);

    return ShipantherScaffold(loggedInUser,
        title: title, actions: actions, body: body, floatingActionButton: null);
  }
}
