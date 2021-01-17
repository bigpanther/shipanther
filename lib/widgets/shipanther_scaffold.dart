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
    this.actions = const [],
    required this.body,
    this.floatingActionButton,
    this.bottomNavigationBar,
  }) : super(key: key);

  final String title;
  final List<Widget> actions;
  final Widget body;
  final Widget? floatingActionButton;
  final User? user;
  final Widget? bottomNavigationBar;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          title,
        ),
        actions: actions,
        centerTitle: true,
      ),
      body: SafeArea(
        child: SingleChildScrollView(
          child: body,
        ),
      ),
      floatingActionButton: floatingActionButton,
      drawer: (user == null)
          ? null
          : Drawer(
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

List<Widget> drawerItemsFor(BuildContext context, User? user) {
  final widgets = <Widget>[];
  if (user == null) {
    return widgets;
  }
  final navigation = Navigator.of(context);
  final localization = ShipantherLocalizations.of(context)!;
  widgets.add(
    _createDrawerItem(
      icon: Icons.home,
      text: localization.home,
      onTap: () => navigation.pushReplacement(
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
        text: localization.tenantsTitle(2),
        onTap: () => navigation.pushReplacement(
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
        text: localization.usersTitle(2),
        onTap: () => navigation.pushReplacement(
          MaterialPageRoute<UserScreen>(
            builder: (_) => UserScreen(user),
          ),
        ),
      ),
    );

    widgets.add(
      _createDrawerItem(
        icon: Icons.connect_without_contact,
        text: localization.customersTitle(2),
        onTap: () => navigation.pushReplacement(
          MaterialPageRoute<CustomerHome>(
            builder: (_) => CustomerHome(user),
          ),
        ),
      ),
    );

    widgets.add(
      _createDrawerItem(
        icon: Icons.account_balance,
        text: localization.terminalsTitle(2),
        onTap: () => navigation.pushReplacement(
          MaterialPageRoute<TerminalScreen>(
            builder: (_) => TerminalScreen(user),
          ),
        ),
      ),
    );

    widgets.add(
      _createDrawerItem(
        icon: Icons.local_shipping,
        text: localization.carriersTitle(2),
        onTap: () => navigation.pushReplacement(
          MaterialPageRoute<CarrierScreen>(
            builder: (_) => CarrierScreen(user),
          ),
        ),
      ),
    );

    widgets.add(
      _createDrawerItem(
        icon: MdiIcons.dresser,
        text: localization.shipmentsTitle(2),
        onTap: () => navigation.pushReplacement(
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
        text: localization.ordersTitle(2),
        onTap: () => navigation.pushReplacement(
          MaterialPageRoute<OrderScreen>(
            builder: (_) => OrderScreen(user),
          ),
        ),
      ),
    );
  }
  widgets.add(
    _createDrawerItem(
      icon: Icons.logout,
      text: localization.logout,
      onTap: () {
        context.read<AuthBloc>().add(
              const AuthLogout(),
            );
        navigation.pushReplacement(
          MaterialPageRoute<SignInOrRegistrationPage>(
            builder: (_) => SignInOrRegistrationPage(),
          ),
        );
      },
    ),
  );

  widgets
    ..add(
      const Divider(
        height: 50,
      ),
    )
    ..add(
      _createDrawerItem(
        icon: MdiIcons.license,
        text: localization.aboutUs,
        onTap: () async {
          final packageInfo = await PackageInfo.fromPlatform();
          final appName = packageInfo.appName;
          final version = packageInfo.version;
          final themeData = Theme.of(context);
          final msgStyle = themeData.textTheme.bodyText1;
          final linkStyle = msgStyle!.copyWith(color: themeData.primaryColor);
          showAboutDialog(
            context: context,
            applicationIcon: const Image(
              image: AssetImage(
                'assets/images/shipanther_logo.png',
              ),
              width: 48.0,
              height: 48.0,
            ),
            applicationName: appName,
            applicationVersion: version,
            applicationLegalese: localization.applicationLegalese,
            children: <Widget>[
              Padding(
                padding: const EdgeInsets.only(top: 15),
                child: RichText(
                  textAlign: TextAlign.center,
                  text: TextSpan(
                    children: <TextSpan>[
                      TextSpan(
                        style: msgStyle,
                        text: localization.reachUsAt,
                      ),
                      TextSpan(
                        style: linkStyle,
                        text: ' info@bigpanther.ca',
                      ),
                      const TextSpan(
                        text: '\n',
                      ),
                      TextSpan(
                        style: themeData.textTheme.caption,
                        text: localization.madeWithLove,
                      ),
                    ],
                  ),
                ),
              ),
            ],
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
          padding: const EdgeInsets.only(
            left: 8.0,
          ),
          child: Text(
            text,
            style: const TextStyle(
              fontSize: 18,
            ),
          ),
        )
      ],
    ),
    onTap: onTap,
  );
}

Widget _createHeader(BuildContext context, User? user) {
  if (user == null) {
    return Container(
      height: 0,
      width: 0,
    );
  }
  return UserAccountsDrawerHeader(
    accountEmail: Text(user.email),
    onDetailsPressed: () => Navigator.of(context).pushReplacement(
      MaterialPageRoute<ProfilePage>(
        builder: (_) => ProfilePage(user),
      ),
    ),
    currentAccountPicture: Column(
      mainAxisAlignment: MainAxisAlignment.center,
      crossAxisAlignment: CrossAxisAlignment.center,
      children: const [
        CircleAvatar(
          child: Icon(
            Icons.person,
          ),
        ),
      ],
    ),
    accountName: Column(
      mainAxisAlignment: MainAxisAlignment.center,
      crossAxisAlignment: CrossAxisAlignment.center,
      children: <Widget>[
        Text(
          user.name,
        ),
      ],
    ),
  );
}
