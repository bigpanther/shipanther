import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:reactive_flutter_typeahead/reactive_flutter_typeahead.dart';
import 'package:shipanther/data/auth/auth_repository.dart';
import 'package:shipanther/l10n/locales/l10n.dart';
import 'package:trober_sdk/trober_sdk.dart';

ReactiveTypeAhead<Tenant, Tenant> tenantSelector(
  BuildContext context,
  String formControlName,
  bool readonly,
) {
  return ReactiveTypeAhead<Tenant, Tenant>(
    formControlName: formControlName,
    stringify: (tenant) => tenant.name,
    autoFlipDirection: true,
    textFieldConfiguration: TextFieldConfiguration(
      decoration: InputDecoration(
        labelText: ShipantherLocalizations.of(context)
            .selectParam(ShipantherLocalizations.of(context).tenantsTitle(1)),
      ),
    ),
    readOnly: readonly,
    suggestionsCallback: (pattern) async {
      try {
        final client = await context.read<AuthRepository>().apiClient();
        return (await client.tenantsGet(name: pattern)).data!.asList();
      } catch (e) {
        return [];
      }
    },
    itemBuilder: (context, Tenant tenant) {
      return ListTile(
        leading: const Icon(Icons.business),
        title: Text(tenant.name),
        subtitle: Text(tenant.id),
      );
    },
  );
}

List<Widget> customerSelector(BuildContext context, String formControlName,
    bool readonly, Map<String, String> validationMessages) {
  if (readonly) {
    return [];
  }
  return [
    ReactiveTypeAhead<Customer, Customer>(
      formControlName: formControlName,
      stringify: (customer) => customer.name,
      autoFlipDirection: true,
      textFieldConfiguration: TextFieldConfiguration(
        decoration: InputDecoration(
            labelText: ShipantherLocalizations.of(context).selectParam(
                ShipantherLocalizations.of(context).customersTitle(1))),
      ),
      readOnly: readonly,
      validationMessages: (control) => validationMessages,
      suggestionsCallback: (pattern) async {
        final client = await context.read<AuthRepository>().apiClient();
        return (await client.customersGet(name: pattern)).data!.asList();
      },
      itemBuilder: (context, Customer customer) {
        return ListTile(
          leading: const Icon(Icons.business),
          title: Text(customer.name),
          subtitle: Text(customer.id),
        );
      },
    ),
  ];
}

List<Widget> driverSelector(
  BuildContext context,
  String formControlName,
  bool readonly,
) {
  if (readonly) {
    return [];
  }
  return [
    ReactiveTypeAhead<User, User>(
      formControlName: formControlName,
      stringify: (user) => user.name,
      autoFlipDirection: true,
      textFieldConfiguration: TextFieldConfiguration(
        decoration: InputDecoration(
            labelText: ShipantherLocalizations.of(context)
                .selectParam(ShipantherLocalizations.of(context).driver)),
      ),
      suggestionsCallback: (pattern) async {
        final client = await context.read<AuthRepository>().apiClient();
        return (await client.usersGet(name: pattern, role: UserRole.driver))
            .data!
            .asList();
      },
      itemBuilder: (context, User user) {
        return ListTile(
          leading: const Icon(Icons.business),
          title: Text(user.name),
          subtitle: Text(user.id),
        );
      },
    ),
  ];
}

List<Widget> terminalSelector(
  BuildContext context,
  String formControlName,
  bool readonly,
) {
  if (readonly) {
    return [];
  }
  return [
    ReactiveTypeAhead<Terminal, Terminal>(
      formControlName: formControlName,
      stringify: (terminal) => terminal.name ?? 'noname',
      autoFlipDirection: true,
      textFieldConfiguration: TextFieldConfiguration(
        decoration: InputDecoration(
            labelText: ShipantherLocalizations.of(context).selectParam(
                ShipantherLocalizations.of(context).terminalsTitle(1))),
      ),
      suggestionsCallback: (pattern) async {
        final client = await context.read<AuthRepository>().apiClient();
        return (await client.terminalsGet(name: pattern)).data!.asList();
      },
      itemBuilder: (context, Terminal terminal) {
        return ListTile(
          leading: const Icon(Icons.business),
          title: Text(terminal.name!),
          subtitle: Text(terminal.id!),
        );
      },
    ),
  ];
}

List<Widget> carrierSelector(
  BuildContext context,
  String formControlName,
  bool readonly,
) {
  if (readonly) {
    return [];
  }
  return [
    ReactiveTypeAhead<Carrier, Carrier>(
      formControlName: formControlName,
      stringify: (carrier) => carrier.name,
      autoFlipDirection: true,
      textFieldConfiguration: TextFieldConfiguration(
        decoration: InputDecoration(
            labelText: ShipantherLocalizations.of(context).selectParam(
                ShipantherLocalizations.of(context).carriersTitle(1))),
      ),
      suggestionsCallback: (pattern) async {
        final client = await context.read<AuthRepository>().apiClient();
        return (await client.carriersGet(name: pattern)).data!.asList();
      },
      itemBuilder: (context, Carrier carrier) {
        return ListTile(
          leading: const Icon(Icons.business),
          title: Text(carrier.name),
          subtitle: Text(carrier.id),
        );
      },
    ),
  ];
}

List<Widget> orderSelector(
  BuildContext context,
  String formControlName,
  bool readonly,
) {
  if (readonly) {
    return [];
  }
  return [
    ReactiveTypeAhead<Order, Order>(
      formControlName: formControlName,
      stringify: (order) => order.serialNumber,
      autoFlipDirection: true,
      textFieldConfiguration: TextFieldConfiguration(
        decoration: InputDecoration(
            labelText: ShipantherLocalizations.of(context).selectParam(
                ShipantherLocalizations.of(context).ordersTitle(1))),
      ),
      suggestionsCallback: (pattern) async {
        final client = await context.read<AuthRepository>().apiClient();
        return (await client.ordersGet(serialNumber: pattern)).data!.asList();
      },
      itemBuilder: (context, Order order) {
        return ListTile(
          leading: const Icon(Icons.business),
          title: Text(order.serialNumber),
          subtitle: Text(order.id),
        );
      },
    ),
  ];
}
