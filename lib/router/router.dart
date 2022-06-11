import 'package:auto_route/auto_route.dart';
import 'package:shipanther/screens/back_office_home.dart';
import 'package:shipanther/screens/carrier/add_edit.dart';
import 'package:shipanther/screens/carrier/home.dart';
import 'package:shipanther/screens/customer/add_edit.dart';
import 'package:shipanther/screens/customer/home.dart';
import 'package:shipanther/screens/customer_home.dart';
import 'package:shipanther/screens/driver_home.dart';
import 'package:shipanther/screens/none_home.dart';
import 'package:shipanther/screens/order/add_edit.dart';
import 'package:shipanther/screens/order/home.dart';
import 'package:shipanther/screens/profile.dart';
import 'package:shipanther/screens/reset_password.dart';
import 'package:shipanther/screens/shipment/add_edit.dart';
import 'package:shipanther/screens/shipment/home.dart';
import 'package:shipanther/screens/signin_or_register_page.dart';
import 'package:shipanther/screens/super_admin_home.dart';
import 'package:shipanther/screens/tenant/add_edit.dart';
import 'package:shipanther/screens/tenant/home.dart';
import 'package:shipanther/screens/terminal/add_edit.dart';
import 'package:shipanther/screens/terminal/home.dart';
import 'package:shipanther/screens/user/add_edit.dart';
import 'package:shipanther/screens/user/home.dart';

@MaterialAutoRouter(
  replaceInRouteName: 'Page,Route',
  routes: <AutoRoute>[
    AutoRoute(path: '/login', page: SignInOrRegistrationPage, initial: true),
    //AutoRoute(path: '/', page: HomePage, children: [
    AutoRoute(page: DriverHome),
    AutoRoute(page: BackOfficeHome),
    AutoRoute(page: CustomerHome),
    AutoRoute(page: NoneHome),
    AutoRoute(page: ProfilePage),
    AutoRoute(page: ResetPassword),
    AutoRoute(page: SuperAdminHome),
    AutoRoute(page: CarrierScreen),
    AutoRoute(page: CarrierAddEdit),
    AutoRoute(page: CustomerScreen),
    AutoRoute(page: CustomerAddEdit),
    AutoRoute(page: OrderScreen),
    AutoRoute(page: OrderAddEdit),
    AutoRoute(page: ShipmentScreen),
    AutoRoute(page: ShipmentAddEdit),
    AutoRoute(page: TenantScreen),
    AutoRoute(page: TenantAddEdit),
    AutoRoute(page: TerminalScreen),
    AutoRoute(page: TerminalAddEdit),
    AutoRoute(page: UserScreen),
    AutoRoute(page: UserAddEdit),
    AutoRoute(page: ProfilePage),
    //   ]),
  ],
)
class $AppRouter {}
