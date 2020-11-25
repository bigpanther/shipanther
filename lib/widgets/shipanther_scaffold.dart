import 'package:flutter/material.dart';
import 'package:shipanther/bloc/auth/auth_bloc.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shipanther/l10n/shipanther_localization.dart';
import 'package:shipanther/screens/carrier/home.dart';
import 'package:shipanther/screens/container/home.dart';
import 'package:shipanther/screens/customer/home.dart';
import 'package:shipanther/screens/super_admin_home.dart';
import 'package:shipanther/screens/signin_or_register_page.dart';
import 'package:shipanther/screens/terminal/home.dart';
import 'package:trober_sdk/api.dart' as api;

class ShipantherScaffold extends StatelessWidget {
  const ShipantherScaffold(this.user,
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
  final api.User user;

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
                          Text(user.name),
                          Text(user.email),
                        ],
                      ),
                    ],
                  ),
                ),
                SizedBox(
                  height: 10,
                ),
              ] +
              drawerItemsFor(context, user),
        ),
      ),
    );
  }
}

List<Widget> drawerItemsFor(BuildContext context, api.User user) {
  List<Widget> widgets = [];
  widgets.add(
    _createDrawerItem(
      icon: Icons.home,
      text: ShipantherLocalizations.of(context).home,
      onTap: () => print("Home"),
    ),
  );

  if (user.role == api.UserRole.superAdmin) {
    widgets.add(
      _createDrawerItem(
        icon: Icons.business,
        text: ShipantherLocalizations.of(context).tenantsTitle,
        onTap: () => Navigator.of(context).pushReplacement(
          MaterialPageRoute(
            builder: (_) => SuperAdminHome(user),
          ),
        ),
      ),
    );
  }

  if (user.role == api.UserRole.superAdmin || user.role == api.UserRole.admin) {
    widgets.add(
      _createDrawerItem(
        icon: Icons.verified_user,
        text: ShipantherLocalizations.of(context).usersTitle,
        onTap: () => print("Users"),
      ),
    );
  }

  if (user.role != api.UserRole.driver && user.role != api.UserRole.none) {
    widgets.add(
      _createDrawerItem(
        icon: Icons.people,
        text: ShipantherLocalizations.of(context).customersTitle,
        onTap: () => Navigator.of(context).pushReplacement(
          MaterialPageRoute(
            builder: (_) => CustomerHome(user),
          ),
        ),
      ),
    );

    widgets.add(
      _createDrawerItem(
        icon: Icons.local_shipping,
        text: ShipantherLocalizations.of(context).terminalsTitle,
        onTap: () => Navigator.of(context).pushReplacement(
          MaterialPageRoute(
            builder: (_) => TerminalScreen(user),
          ),
        ),
      ),
    );

    widgets.add(
      _createDrawerItem(
        icon: Icons.verified_user,
        text: ShipantherLocalizations.of(context).ordersTitle,
        onTap: () => print("Orders"),
      ),
    );

    widgets.add(
      _createDrawerItem(
        icon: Icons.verified_user,
        text: ShipantherLocalizations.of(context).carriersTitle,
        onTap: () => Navigator.of(context).pushReplacement(
          MaterialPageRoute(
            builder: (_) => CarrierScreen(user),
          ),
        ),
      ),
    );

    widgets.add(
      _createDrawerItem(
        icon: Icons.connect_without_contact,
        text: ShipantherLocalizations.of(context).containersTitle,
        onTap: () => Navigator.of(context).pushReplacement(
          MaterialPageRoute(
            builder: (_) => ContainerScreen(user),
          ),
        ),
      ),
    );
  }
  widgets.add(
    _createDrawerItem(
      icon: Icons.settings,
      text: ShipantherLocalizations.of(context).settings,
      onTap: () => print("Settings"),
    ),
  );

  widgets.add(
    _createDrawerItem(
      icon: Icons.logout,
      text: ShipantherLocalizations.of(context).logout,
      onTap: () {
        context.read<AuthBloc>().add(AuthLogout());
        Navigator.of(context).pushReplacement(
            MaterialPageRoute(builder: (_) => SignInOrRegistrationPage()));
      },
    ),
  );
  return widgets;
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
