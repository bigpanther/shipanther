import 'package:flutter/material.dart';
import 'package:material_design_icons_flutter/material_design_icons_flutter.dart';
import 'package:package_info/package_info.dart';
import 'package:shipanther/bloc/auth/auth_bloc.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shipanther/l10n/shipanther_localization.dart';

import 'package:shipanther/screens/carrier/home.dart';
import 'package:shipanther/screens/shipment/home.dart';
import 'package:shipanther/screens/customer/home.dart';
import 'package:shipanther/screens/order/home.dart';
import 'package:shipanther/screens/profile.dart';
import 'package:shipanther/screens/super_admin_home.dart';
import 'package:shipanther/screens/signin_or_register_page.dart';
import 'package:shipanther/screens/terminal/home.dart';
import 'package:shipanther/screens/user/home.dart';
import 'package:trober_sdk/api.dart';
import 'package:shipanther/extensions/user_extension.dart';

class ShipantherScaffold extends StatelessWidget {
  const ShipantherScaffold(
    this.user, {
    Key? key,
    required this.title,
    required this.actions,
    required this.body,
    required this.floatingActionButton,
    required this.bottomNavigationBar,
  }) : super(key: key);

  final String title;
  final List<Widget> actions;
  final Widget body;
  final Widget? floatingActionButton;
  final User user;
  final Widget? bottomNavigationBar;

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
                _createHeader(context, user),
                const SizedBox(
                  height: 10,
                ),
              ] +
              drawerItemsFor(context, user),
        ),
      ),
      bottomNavigationBar: bottomNavigationBar,
    );
  }
}

List<Widget> drawerItemsFor(BuildContext context, User user) {
  final widgets = <Widget>[];
  widgets.add(
    _createDrawerItem(
      icon: Icons.home,
      text: ShipantherLocalizations.of(context)!.home,
      onTap: () => Navigator.of(context).pushReplacement(
        MaterialPageRoute<Widget>(
          builder: (_) => user.homePage,
        ),
      ),
    ),
  );

  if (user.isSuperAdmin) {
    widgets.add(
      _createDrawerItem(
        icon: Icons.business,
        text: ShipantherLocalizations.of(context)!.tenantsTitle(2),
        onTap: () => Navigator.of(context).pushReplacement(
          MaterialPageRoute<SuperAdminHome>(
            builder: (_) => SuperAdminHome(user),
          ),
        ),
      ),
    );
  }

  if (user.isAtleastBackOffice) {
    widgets.add(
      _createDrawerItem(
        icon: Icons.people,
        text: ShipantherLocalizations.of(context)!.usersTitle(2),
        onTap: () => Navigator.of(context).pushReplacement(
          MaterialPageRoute<UserScreen>(
            builder: (_) => UserScreen(user),
          ),
        ),
      ),
    );

    widgets.add(
      _createDrawerItem(
        icon: Icons.connect_without_contact,
        text: ShipantherLocalizations.of(context)!.customersTitle(2),
        onTap: () => Navigator.of(context).pushReplacement(
          MaterialPageRoute<CustomerHome>(
            builder: (_) => CustomerHome(user),
          ),
        ),
      ),
    );

    widgets.add(
      _createDrawerItem(
        icon: Icons.account_balance,
        text: ShipantherLocalizations.of(context)!.terminalsTitle(2),
        onTap: () => Navigator.of(context).pushReplacement(
          MaterialPageRoute<TerminalScreen>(
            builder: (_) => TerminalScreen(user),
          ),
        ),
      ),
    );

    widgets.add(
      _createDrawerItem(
        icon: Icons.local_shipping,
        text: ShipantherLocalizations.of(context)!.carriersTitle(2),
        onTap: () => Navigator.of(context).pushReplacement(
          MaterialPageRoute<CarrierScreen>(
            builder: (_) => CarrierScreen(user),
          ),
        ),
      ),
    );

    widgets.add(
      _createDrawerItem(
        icon: MdiIcons.dresser,
        text: ShipantherLocalizations.of(context)!.shipmentsTitle(2),
        onTap: () => Navigator.of(context).pushReplacement(
          MaterialPageRoute<ShipmentScreen>(
            builder: (_) => ShipmentScreen(user),
          ),
        ),
      ),
    );
  }
  if (user.role != UserRole.driver && user.role != UserRole.none) {
    widgets.add(
      _createDrawerItem(
        icon: Icons.fact_check,
        text: ShipantherLocalizations.of(context)!.ordersTitle(2),
        onTap: () => Navigator.of(context).pushReplacement(
          MaterialPageRoute<OrderScreen>(
            builder: (_) => OrderScreen(user),
          ),
        ),
      ),
    );
  }

  widgets.add(
    _createDrawerItem(
      icon: MdiIcons.license,
      text: ShipantherLocalizations.of(context)!.aboutUs,
      onTap: () async {
        final packageInfo = await PackageInfo.fromPlatform();
        final appName = packageInfo.appName;
        final version = packageInfo.version;
        showAboutDialog(
          context: context,
          applicationIcon: const Image(
            image: AssetImage('assets/images/shipanther_logo.png'),
            width: 48.0,
            height: 48.0,
          ),
          applicationName: appName,
          applicationVersion: version,
          applicationLegalese:
              ShipantherLocalizations.of(context)!.applicationLegalese,
          children: <Widget>[
            Padding(
                padding: const EdgeInsets.only(top: 15),
                child: Center(
                  child: Column(
                    children: [
                      Text(ShipantherLocalizations.of(context)!.aboutOne),
                      Text(ShipantherLocalizations.of(context)!.aboutTwo),
                    ],
                  ),
                ))
          ],
        );
      },
    ),
  );

  widgets.add(
    _createDrawerItem(
      icon: Icons.logout,
      text: ShipantherLocalizations.of(context)!.logout,
      onTap: () {
        context.read<AuthBloc>().add(
              const AuthLogout(),
            );
        Navigator.of(context).pushReplacement(
          MaterialPageRoute<SignInOrRegistrationPage>(
            builder: (_) => SignInOrRegistrationPage(),
          ),
        );
      },
    ),
  );
  return widgets;
}

Widget _createDrawerItem(
    {required IconData icon,
    required String text,
    required GestureTapCallback onTap}) {
  return ListTile(
    title: Row(
      children: <Widget>[
        Icon(icon),
        Padding(
          padding: const EdgeInsets.only(left: 8.0),
          child: Text(
            text,
            style: const TextStyle(fontSize: 18),
          ),
        )
      ],
    ),
    onTap: onTap,
  );
}

Widget _createHeader(BuildContext context, User user) {
  return UserAccountsDrawerHeader(
    accountEmail: Padding(
      padding: const EdgeInsets.only(top: 8.0),
      child: Text(
        ShipantherLocalizations.of(context)!.shipantherTitle,
        style: const TextStyle(fontSize: 22),
      ),
    ),
    onDetailsPressed: () => Navigator.of(context).pushReplacement(
      MaterialPageRoute<ProfilePage>(
        builder: (_) => ProfilePage(user),
      ),
    ),
    accountName: Row(
      children: <Widget>[
        Container(
          width: 50,
          height: 50,
          decoration: const BoxDecoration(shape: BoxShape.circle),
          child: const CircleAvatar(
            child: Icon(Icons.person),
          ),
        ),
        const SizedBox(
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
  );
}
