import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shipanther/bloc/auth/auth_bloc.dart';
import 'package:shipanther/bloc/user/user_bloc.dart';
import 'package:shipanther/data/auth/auth_repository.dart';
import 'package:shipanther/l10n/shipanther_localization.dart';
import 'package:shipanther/screens/container/home.dart';
import 'package:shipanther/screens/none_home.dart';
import 'package:shipanther/screens/super_admin_home.dart';
import 'package:shipanther/screens/terminal/home.dart';
import 'package:shipanther/widgets/centered_loading.dart';
import 'package:shipanther/extensions/user_extension.dart';

class ApiLogin extends StatefulWidget {
  const ApiLogin({Key key}) : super(key: key);

  @override
  _ApiLoginState createState() => _ApiLoginState();
}

class _ApiLoginState extends State<ApiLogin> {
  @override
  void initState() {
    super.initState();
    var deviceToken = context.read<AuthRepository>().deviceToken();
    context.read<UserBloc>().add(UserLogin(deviceToken));
  }

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<UserBloc, UserState>(
      listener: (context, state) async {
        if (state is UserFailure) {
          Scaffold.of(context).showSnackBar(SnackBar(
            content: Text(state.message),
          ));
        }
        if (state is UserLoggedIn) {
          Navigator.of(context).pushReplacement(
            MaterialPageRoute<void>(builder: (_) {
              if (state.user.isSuperAdmin) {
                return SuperAdminHome(state.user);
              }
              if (state.user.isAtleastTenantBackOffice) {
                return TerminalScreen(state.user);
              }
              if (state.user.isDriver) {
                return ContainerScreen(state.user);
              }
              return NoneHome(state.user);
            }),
          );
        }
      },
      builder: (context, state) {
        if (state is UserFailure) {
          return Container(
            child: Center(
                child: Column(
              children: [
                Text("An error occured during log-in. Please retry."),
                FlatButton(
                    onPressed: () => context.read<AuthBloc>().add(AuthLogout()),
                    child: Text(ShipantherLocalizations.of(context).logout)),
              ],
            )),
          );
        }
        return const CenteredLoading();
      },
    );
  }
}
