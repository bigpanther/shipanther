import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shipanther/bloc/user/user_bloc.dart';
import 'package:shipanther/l10n/locales/l10n.dart';
import 'package:shipanther/router/router.gr.dart';
import 'package:trober_sdk/trober_sdk.dart';
import 'package:shipanther/extensions/user_extension.dart';
import 'package:shipanther/helper/colon.dart';
import 'package:shipanther/l10n/locales/date_formatter.dart';

class UserSearchDelegate extends SearchDelegate<User?> {
  final UserBloc bloc;
  final User loggedInUser;

  UserSearchDelegate(
    this.loggedInUser,
    this.bloc,
  );
  @override
  List<Widget>? buildActions(BuildContext context) {
    return [
      IconButton(
        icon: const Icon(Icons.clear),
        onPressed: () {
          query = '';
        },
      ),
    ];
  }

  @override
  Widget? buildLeading(BuildContext context) {
    return IconButton(
      icon: const Icon(Icons.arrow_back),
      onPressed: () {
        close(context, null);
      },
    );
  }

  @override
  Widget buildResults(BuildContext context) {
    if (query.length < 3) {
      return Container();
    }
    bloc.add(SearchUser(query));
    return BlocBuilder(
      bloc: bloc,
      builder: (BuildContext context, UserState state) {
        if (state is UserLoading) {
          return const Center(
            child: CircularProgressIndicator(),
          );
        }
        if (state is UserFailure) {
          return Center(
            child: Text(state.message),
          );
        }
        if (state is UsersLoaded) {
          return listbody(context, loggedInUser, bloc, state);
        }
        if (state is UserNotFound) {
          return notFoundBody(context);
        }
        return Container();
      },
    );
  }

  @override
  Widget buildSuggestions(BuildContext context) {
    return Container();
  }
}

Widget notFoundBody(BuildContext context) {
  return Center(
    child: Text(ShipantherLocalizations.of(context).notFound),
  );
}

Widget listbody(
    BuildContext context, User loggedInUser, UserBloc bloc, UsersLoaded state) {
  return GridView.builder(
    gridDelegate: const SliverGridDelegateWithMaxCrossAxisExtent(
      maxCrossAxisExtent: 500,
    ),
    itemCount: state.users.length,
    itemBuilder: (BuildContext context, int index) {
      final t = state.users.elementAt(index);
      return Padding(
        padding: const EdgeInsets.all(3.0),
        child: Card(
          elevation: 3,
          shape: const RoundedRectangleBorder(
            borderRadius: BorderRadius.all(
              Radius.circular(8.0),
            ),
          ),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              ListTile(
                leading: Icon(t.role.icon),
                trailing: IconButton(
                  icon: const Icon(Icons.edit),
                  onPressed: () {
                    context.pushRoute(
                      UserAddEdit(
                        loggedInUser: loggedInUser,
                        isEdit: true,
                        userBloc: bloc,
                        user: t,
                      ),
                    );
                  },
                ),
                title: Text(
                  t.name,
                  style: Theme.of(context).textTheme.headline6,
                ),
              ),
              Column(
                mainAxisSize: MainAxisSize.min,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  displayProperty(context,
                      ShipantherLocalizations.of(context).email, t.email),
                  displayProperty(context,
                      ShipantherLocalizations.of(context).role, t.role.name),
                  displayProperty(
                      context,
                      ShipantherLocalizations.of(context).createdAt,
                      t.createdAt.toLocal(),
                      formatter: dateTimeFormatter),
                  displayProperty(
                      context,
                      ShipantherLocalizations.of(context).lastUpdate,
                      t.updatedAt.toLocal(),
                      formatter: dateTimeFormatter),
                ],
              ),
            ],
          ),
        ),
      );
    },
  );
}
