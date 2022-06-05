import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:material_design_icons_flutter/material_design_icons_flutter.dart';
import 'package:package_info_plus/package_info_plus.dart';
import 'package:shipanther/bloc/auth/auth_bloc.dart';
import 'package:shipanther/extensions/user_extension.dart';
import 'package:shipanther/l10n/locales/l10n.dart';
import 'package:shipanther/router/router.gr.dart';
import 'package:trober_sdk/trober_sdk.dart';
import 'package:url_launcher/url_launcher.dart';

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
        child: body,
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
  final router = AutoRouter.of(context);
  final localization = ShipantherLocalizations.of(context);
  widgets.add(
    _createDrawerItem(
      icon: Icons.home,
      text: localization.home,
      onTap: () => router.replace(user.homePage),
    ),
  );

  if (user.isSuperAdmin) {
    widgets.add(
      _createDrawerItem(
          icon: Icons.business,
          text: localization.tenantsTitle(2),
          onTap: () => router.replace(SuperAdminHome(user: user))),
    );
  }

  if (user.isAtleastBackOffice) {
    widgets.add(
      _createDrawerItem(
          icon: Icons.people,
          text: localization.usersTitle(2),
          onTap: () => router.replace(UserScreen(loggedInUser: user))),
    );

    widgets.add(
      _createDrawerItem(
          icon: Icons.connect_without_contact,
          text: localization.customersTitle(2),
          onTap: () => router.replace(CustomerScreen(loggedInUser: user))),
    );

    widgets.add(
      _createDrawerItem(
          icon: Icons.account_balance,
          text: localization.terminalsTitle(2),
          onTap: () => router.replace(TerminalScreen(loggedInUser: user))),
    );

    widgets.add(
      _createDrawerItem(
          icon: Icons.local_shipping,
          text: localization.carriersTitle(2),
          onTap: () => router.replace(CarrierScreen(loggedInUser: user))),
    );

    widgets.add(
      _createDrawerItem(
          icon: MdiIcons.dresser,
          text: localization.shipmentsTitle(2),
          onTap: () => router.replace(ShipmentScreen(loggedInUser: user))),
    );
  }
  if (user.role != UserRole.driver && user.role != UserRole.none) {
    widgets.add(
      _createDrawerItem(
          icon: Icons.fact_check,
          text: localization.ordersTitle(2),
          onTap: () => router.replace(OrderScreen(loggedInUser: user))),
    );
  }
  widgets.add(_createDrawerItem(
      icon: Icons.logout,
      text: localization.logout,
      onTap: () {
        context.read<AuthBloc>().add(
              const AuthLogout(),
            );
        context.replaceRoute(const SignInOrRegistrationRoute());
      }));

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
          final themeData = Theme.of(context);
          final packageInfo = await PackageInfo.fromPlatform();
          final appName = packageInfo.appName;
          final version = packageInfo.version;
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
    )
    ..add(
      _createDrawerItem(
        icon: MdiIcons.license,
        text: localization.whatsNew,
        onTap: () async {
          final scaffold = ScaffoldMessenger.of(context);
          final packageInfo = await PackageInfo.fromPlatform();
          final url = Uri.parse(
              'https://github.com/bigpanther/shipanther/releases/tag/v${packageInfo.version}');
          await canLaunchUrl(url)
              ? await launchUrl(url)
              : scaffold.showSnackBar(
                  const SnackBar(
                    content: Text('Could not launch external link'),
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
    return const SizedBox(
      height: 0,
      width: 0,
    );
  }
  return UserAccountsDrawerHeader(
    accountEmail: Text(user.email),
    onDetailsPressed: () =>
        AutoRouter.of(context).replace(ProfileRoute(user: user)),
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
