import 'package:flutter/material.dart';

import 'package:shipanther/bloc/user/user_bloc.dart';
import 'package:shipanther/helper/colon.dart';
import 'package:shipanther/l10n/shipanther_localization.dart';
import 'package:shipanther/screens/user/add_edit.dart';
import 'package:shipanther/widgets/filter_button.dart';
import 'package:shipanther/widgets/shipanther_scaffold.dart';
import 'package:trober_sdk/api.dart';
import 'package:shipanther/extensions/user_extension.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

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
      FilterButton<UserRole>(
        possibleValues: UserRole.values,
        isActive: true,
        activeFilter: userLoadedState.userRole,
        onSelected: (t) => context.read<UserBloc>().add(
              GetUsers(t),
            ),
        tooltip: ShipantherLocalizations.of(context).userTypeFilter,
      )
    ];

    final Widget body = ListView.builder(
      itemCount: userLoadedState.users.length,
      itemBuilder: (BuildContext context, int index) {
        final t = userLoadedState.users.elementAt(index);
        return Padding(
          padding: const EdgeInsets.all(3.0),
          child: Card(
            elevation: 1,
            shape: const RoundedRectangleBorder(
              borderRadius: BorderRadius.all(
                Radius.circular(8.0),
              ),
            ),
            child: ExpansionTile(
              childrenPadding: const EdgeInsets.only(left: 20, bottom: 10),
              leading: Icon(t.role.icon),
              trailing: IconButton(
                icon: const Icon(Icons.edit),
                onPressed: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute<Widget>(
                      builder: (_) => UserAddEdit(
                        loggedInUser,
                        isEdit: true,
                        userBloc: userBloc,
                        user: t,
                      ),
                    ),
                  );
                },
              ),
              expandedCrossAxisAlignment: CrossAxisAlignment.stretch,
              title: Text(
                t.name,
                style: Theme.of(context).textTheme.headline6,
              ),
              children: [
                displaySubtitle(
                    ShipantherLocalizations.of(context).email, t.email),
                displaySubtitle(
                    ShipantherLocalizations.of(context).role, t.role.text),
                displaySubtitle(
                    ShipantherLocalizations.of(context).createdAt,
                    ShipantherLocalizations.of(context)
                        .dateFormatter
                        .format(t.createdAt)),
                displaySubtitle(
                    ShipantherLocalizations.of(context).lastUpdate,
                    ShipantherLocalizations.of(context)
                        .dateFormatter
                        .format(t.updatedAt)),
                if (loggedInUser.isSuperAdmin)
                  displaySubtitle(
                      ShipantherLocalizations.of(context).tenantId, t.tenantId)
                else
                  const Text(''),
              ],
            ),
          ),
        );
      },
    );

    return ShipantherScaffold(loggedInUser,
        bottomNavigationBar: null,
        title: title,
        actions: actions,
        body: body,
        floatingActionButton: null);
  }
}
