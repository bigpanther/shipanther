import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'package:shipanther/bloc/user/user_bloc.dart';
import 'package:shipanther/l10n/locales/l10n.dart';
import 'package:shipanther/screens/user/list.dart';
import 'package:shipanther/widgets/loading_widget.dart';
import 'package:trober_sdk/api.dart';

class UserScreen extends StatefulWidget {
  const UserScreen(this.loggedInUser, {Key? key}) : super(key: key);

  final User loggedInUser;

  @override
  _UserScreenState createState() => _UserScreenState();
}

class _UserScreenState extends State<UserScreen> {
  late UserBloc bloc;
  @override
  void initState() {
    super.initState();
    bloc = context.read<UserBloc>();
    bloc.add(const GetUsers());
  }

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<UserBloc, UserState>(
      listener: (context, state) {
        if (state is UserFailure) {
          ScaffoldMessenger.of(context).showSnackBar(SnackBar(
            content: Text(state.message),
          ));
        }
      },
      builder: (context, state) {
        if (state is UsersLoaded) {
          return UserList(widget.loggedInUser,
              userBloc: bloc, userLoadedState: state);
        }
        return LoadingWidget(
            loggedInUser: widget.loggedInUser,
            title: ShipantherLocalizations.of(context).usersTitle(2));
      },
    );
  }
}
