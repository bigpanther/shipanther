import 'package:flutter/material.dart';
import 'package:shipanther/bloc/auth/auth_bloc.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shipanther/l10n/shipanther_localization.dart';
import 'package:shipanther/screens/home.dart';
import 'package:shipanther/screens/signin_or_register_page.dart';
import 'package:shipanther/screens/terminal/terminalScreen.dart';

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
      appBar: AppBar(
        title: Text(title),
        actions: actions,
        centerTitle: true,
      ),
      body: body,
      floatingActionButton: floatingActionButton,
      drawer: Drawer(
        child: ListView(
          // Important: Remove any padding from the ListView.
          padding: EdgeInsets.zero,
          children: <Widget>[
            // _createHeader(),
            UserAccountsDrawerHeader(
              accountEmail: Padding(
                padding: const EdgeInsets.only(top: 8.0),
                child: Text(
                  'Shipanther',
                  style: TextStyle(fontSize: 22),
                ),
              ),
              accountName: Row(
                children: <Widget>[
                  Container(
                    width: 50,
                    height: 50,
                    decoration: BoxDecoration(shape: BoxShape.circle),
                    child: CircleAvatar(
                      child: Icon(Icons.person),
                    ),
                  ),
                  SizedBox(
                    width: 20,
                  ),
                  Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: <Widget>[
                      Text('User Name'),
                      Text('info@bigpanther.ca'),
                    ],
                  ),
                ],
              ),
            ),
            SizedBox(
              height: 10,
            ),
            _createDrawerItem(
              icon: Icons.business,
              text: ShipantherLocalizations.of(context).tenantsTitle,
              onTap: () => Navigator.of(context)
                  .pushReplacement(MaterialPageRoute(builder: (_) => Home())),
            ),
            Divider(),
            _createDrawerItem(
                icon: Icons.local_shipping,
                text: ShipantherLocalizations.of(context).terminalsTitle,
                onTap: () => Navigator.of(context).pushReplacement(
                    MaterialPageRoute(builder: (_) => TerminalScreen()))),
            Divider(),
            _createDrawerItem(
              icon: Icons.logout,
              text: 'Log Out',
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

Widget _createDrawerItem(
    {IconData icon, String text, GestureTapCallback onTap}) {
  return ListTile(
    title: Row(
      children: <Widget>[
        Icon(icon),
        Padding(
          padding: EdgeInsets.only(left: 8.0),
          child: Text(
            text,
            style: TextStyle(fontSize: 18),
          ),
        )
      ],
    ),
    onTap: onTap,
  );
}

Widget _createHeader() {
  return DrawerHeader(
    curve: Curves.slowMiddle,
    margin: EdgeInsets.zero,
    padding: EdgeInsets.zero,
    decoration: BoxDecoration(
      // image: DecorationImage(
      //   fit: BoxFit.fill,
      //   image: AssetImage('path/to/header_background.png'),
      // ),
      color: Colors.blue,
    ),
    child: Stack(
      children: <Widget>[
        Positioned(
          bottom: 12.0,
          left: 16.0,
          child: Text(
            "Shipanther",
            style: TextStyle(
              color: Colors.white,
              fontSize: 22.0,
              fontWeight: FontWeight.w500,
            ),
          ),
        ),
      ],
    ),
  );
}
