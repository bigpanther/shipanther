import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:shipanther/bloc/user/user_bloc.dart';
import 'package:shipanther/l10n/shipanther_localization.dart';
import 'package:shipanther/screens/user/add_edit.dart';
import 'package:shipanther/widgets/filter_button.dart';
import 'package:shipanther/widgets/shipanther_scaffold.dart';
import 'package:trober_sdk/api.dart';

import 'package:flutter_bloc/flutter_bloc.dart';

class UserList extends StatelessWidget {
  final UserBloc userBloc;
  final UsersLoaded userLoadedState;
  final User loggedInUser;
  const UserList(this.loggedInUser,
      {Key key, @required this.userLoadedState, this.userBloc})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    final DateFormat formatter = DateFormat('dd-MM-yyyy');
    var title = ShipantherLocalizations.of(context).usersTitle;
    List<Widget> actions = [
      FilterButton<UserRole>(
        possibleValues: UserRole.values,
        isActive: true,
        activeFilter: userLoadedState.userRole,
        onSelected: (t) => context.read<UserBloc>()..add(GetUsers(t)),
        tooltip: "Filter User type",
      )
    ];

    Widget body = ListView.builder(
      itemCount: userLoadedState.users.length,
      itemBuilder: (BuildContext context, int index) {
        var t = userLoadedState.users.elementAt(index);
        return Padding(
          padding: const EdgeInsets.all(3.0),
          child: Card(
            elevation: 1,
            shape: RoundedRectangleBorder(
              borderRadius: const BorderRadius.all(
                Radius.circular(8.0),
              ),
            ),
            child: ExpansionTile(
              childrenPadding: EdgeInsets.only(left: 20, bottom: 10),
              // subtitle: Text(t.id),
              // tilePadding: EdgeInsets.all(5),
              leading: Icon((t.role == UserRole.superAdmin)
                  ? Icons.android
                  : (t.role == UserRole.admin)
                      ? Icons.person
                      : (t.role == UserRole.backOffice)
                          ? Icons.person_add
                          : (t.role == UserRole.driver)
                              ? Icons.local_shipping
                              : (t.role == UserRole.customer)
                                  ? Icons.perm_identity
                                  : Icons.not_accessible),
              trailing: IconButton(
                icon: Icon(Icons.edit),
                onPressed: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
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
                Text(
                  "Created At: ${formatter.format(t.createdAt).toString()}",
                  style: Theme.of(context).textTheme.subtitle1,
                ),
                Text(
                  "Created By: ${t.createdBy}",
                  style: Theme.of(context).textTheme.subtitle1,
                ),
                Text(
                  "Last Update: ${formatter.format(t.updatedAt).toString()}",
                  style: Theme.of(context).textTheme.subtitle1,
                ),
                Text(
                  "Tenant ID: ${t.tenantId}",
                  style: Theme.of(context).textTheme.subtitle1,
                ),
              ],
            ),
          ),
        );
      },
    );

    return ShipantherScaffold(loggedInUser,
        title: title, actions: actions, body: body, floatingActionButton: null);
  }
}
