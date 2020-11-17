import 'package:flutter/material.dart';
import 'package:shipanther/bloc/auth/auth_bloc.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shipanther/screens/signin_or_register_page.dart';

class ShipantherScaffold extends StatelessWidget {
  const ShipantherScaffold(
      {Key key,
      @required this.title,
      @required this.actions,
      @required this.body,
      @required this.floatingActionButton})
      : super(key: key);

  final String title;
  final List<Widget> actions;
  final Widget body;
  final Widget floatingActionButton;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text(title), actions: actions),
      body: body,
      floatingActionButton: floatingActionButton,
      drawer: Drawer(
        // Add a ListView to the drawer. This ensures the user can scroll
        // through the options in the drawer if there isn't enough vertical
        // space to fit everything.
        child: ListView(
          // Important: Remove any padding from the ListView.
          padding: EdgeInsets.zero,
          children: <Widget>[
            DrawerHeader(
              child: Text('Shipanther'),
              decoration: BoxDecoration(
                color: Colors.blue,
              ),
            ),
            ListTile(
              title: Text('Logout'),
              onTap: () {
                context.read<AuthBloc>().add(AuthLogout());
                Navigator.of(context).pushReplacement(MaterialPageRoute(
                    builder: (_) => SignInOrRegistrationPage()));
              },
            ),
          ],
        ),
      ),
    );
  }
}
