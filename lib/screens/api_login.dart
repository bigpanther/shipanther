import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shipanther/bloc/auth/auth_bloc.dart';
import 'package:shipanther/bloc/user/user_bloc.dart';
import 'package:shipanther/data/auth/auth_repository.dart';
import 'package:shipanther/l10n/shipanther_localization.dart';
import 'package:shipanther/widgets/centered_loading.dart';
import 'package:shipanther/extensions/user_extension.dart';

class ApiLogin extends StatefulWidget {
  const ApiLogin({Key? key}) : super(key: key);

  @override
  _ApiLoginState createState() => _ApiLoginState();
}

class _ApiLoginState extends State<ApiLogin> {
  @override
  void initState() {
    super.initState();
    final deviceToken = context.read<AuthRepository>().deviceToken();
    context.read<UserBloc>().add(UserLogin(deviceToken));
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
        if (state is UserLoggedIn) {
          Navigator.of(context).pushReplacement(
            MaterialPageRoute<Widget>(builder: (_) {
              return state.user.homePage;
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
                  Text(ShipantherLocalizations.of(context).loginError),
                  FlatButton(
                    onPressed: () => context.read<AuthBloc>().add(
                          const AuthLogout(),
                        ),
                    child: Text(ShipantherLocalizations.of(context).logout),
                  ),
                ],
              ),
            ),
          );
        }
        return const CenteredLoading();
      },
    );
  }
}
