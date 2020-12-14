import 'package:flutter/material.dart';
import 'package:flutter_typeahead/flutter_typeahead.dart';
import 'package:shipanther/data/api/api_repository.dart';
import 'package:trober_sdk/api.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shipanther/extensions/user_extension.dart';

List<Widget> tenantSelector(
    BuildContext context,
    bool shouldShow,
    void Function(Tenant) onSuggestionSelected,
    TextEditingController textEditingController) {
  if (!shouldShow) {
    return [];
  }
  return [
    TypeAheadFormField<Tenant>(
      textFieldConfiguration: TextFieldConfiguration<Tenant>(
          decoration: const InputDecoration(
            labelText: 'Select tenant',
          ),
          controller: textEditingController,
          onTap: () {
            textEditingController.text = '';
          }),
      suggestionsCallback: (pattern) async {
        final client = await context.read<ApiRepository>().apiClient();
        return (await client.tenantsGet()).where(
          (element) => element.name.toLowerCase().startsWith(pattern),
        );
      },
      itemBuilder: (context, Tenant tenant) {
        return ListTile(
          leading: const Icon(Icons.business),
          title: Text(tenant.name),
          subtitle: Text(tenant.id),
        );
      },
      onSuggestionSelected: (suggestion) {
        onSuggestionSelected(suggestion);
        textEditingController.text = suggestion.name;
      },
    ),
  ];
}

List<Widget> customerSelector(
    BuildContext context,
    bool shouldShow,
    void Function(Customer) onSuggestionSelected,
    TextEditingController textEditingController) {
  if (!shouldShow) {
    return [];
  }
  return [
    TypeAheadFormField<Customer>(
      textFieldConfiguration: TextFieldConfiguration<Customer>(
        decoration: const InputDecoration(labelText: 'Select customer'),
        controller: textEditingController,
        onTap: () {
          textEditingController.text = '';
        },
      ),
      suggestionsCallback: (pattern) async {
        final client = await context.read<ApiRepository>().apiClient();
        return (await client.customersGet()).where(
          (element) => element.name.toLowerCase().startsWith(pattern),
        );
      },
      itemBuilder: (context, Customer customer) {
        return ListTile(
          leading: const Icon(Icons.business),
          title: Text(customer.name),
          subtitle: Text(customer.id),
        );
      },
      onSuggestionSelected: (suggestion) {
        onSuggestionSelected(suggestion);
        textEditingController.text = suggestion.name;
      },
    ),
  ];
}

List<Widget> driverSelector(
    BuildContext context,
    bool shouldShow,
    void Function(User) onSuggestionSelected,
    TextEditingController textEditingController) {
  if (!shouldShow) {
    return [];
  }
  return [
    TypeAheadFormField<User>(
      textFieldConfiguration: TextFieldConfiguration<User>(
          decoration: const InputDecoration(labelText: 'Select Driver'),
          controller: textEditingController,
          onTap: () {
            textEditingController.text = '';
          }),
      suggestionsCallback: (pattern) async {
        final client = await context.read<ApiRepository>().apiClient();
        return (await client.usersGet()).where(
          (element) =>
              element.isDriver &&
              element.name.toLowerCase().startsWith(pattern),
        );
      },
      itemBuilder: (context, User user) {
        return ListTile(
          leading: const Icon(Icons.business),
          title: Text(user.name),
          subtitle: Text(user.id),
        );
      },
      onSuggestionSelected: (suggestion) {
        onSuggestionSelected(suggestion);
        textEditingController.text = suggestion.name;
      },
    ),
  ];
}

List<Widget> terminalSelector(
    BuildContext context,
    bool shouldShow,
    void Function(Terminal) onSuggestionSelected,
    TextEditingController textEditingController) {
  if (!shouldShow) {
    return [];
  }
  return [
    TypeAheadFormField<Terminal>(
      textFieldConfiguration: TextFieldConfiguration<Terminal>(
        decoration: const InputDecoration(labelText: 'Select Terminal'),
        controller: textEditingController,
        onTap: () {
          textEditingController.text = '';
        },
      ),
      suggestionsCallback: (pattern) async {
        final client = await context.read<ApiRepository>().apiClient();
        return (await client.terminalsGet()).where(
          (element) => element.name.toLowerCase().startsWith(pattern),
        );
      },
      itemBuilder: (context, Terminal terminal) {
        return ListTile(
          leading: const Icon(Icons.business),
          title: Text(terminal.name),
          subtitle: Text(terminal.id),
        );
      },
      onSuggestionSelected: (suggestion) {
        onSuggestionSelected(suggestion);
        textEditingController.text = suggestion.name;
      },
    ),
  ];
}

List<Widget> carrierSelector(
    BuildContext context,
    bool shouldShow,
    void Function(Carrier) onSuggestionSelected,
    TextEditingController textEditingController) {
  if (!shouldShow) {
    return [];
  }
  return [
    TypeAheadFormField<Carrier>(
      textFieldConfiguration: TextFieldConfiguration<Carrier>(
        decoration: const InputDecoration(labelText: 'Select Carrier'),
        controller: textEditingController,
        onTap: () {
          textEditingController.text = '';
        },
      ),
      suggestionsCallback: (pattern) async {
        final client = await context.read<ApiRepository>().apiClient();
        return (await client.carriersGet()).where(
          (element) => element.name.toLowerCase().startsWith(pattern),
        );
      },
      itemBuilder: (context, Carrier carrier) {
        return ListTile(
          leading: const Icon(Icons.business),
          title: Text(carrier.name),
          subtitle: Text(carrier.id),
        );
      },
      onSuggestionSelected: (suggestion) {
        onSuggestionSelected(suggestion);
        textEditingController.text = suggestion.name;
      },
    ),
  ];
}

List<Widget> orderSelector(
    BuildContext context,
    bool shouldShow,
    void Function(Order) onSuggestionSelected,
    TextEditingController textEditingController) {
  if (!shouldShow) {
    return [];
  }
  return [
    TypeAheadFormField<Order>(
      textFieldConfiguration: TextFieldConfiguration<Order>(
        decoration: const InputDecoration(labelText: 'Select Order'),
        controller: textEditingController,
        onTap: () {
          textEditingController.text = '';
        },
      ),
      suggestionsCallback: (pattern) async {
        final client = await context.read<ApiRepository>().apiClient();
        return (await client.ordersGet()).where(
          (element) => element.serialNumber.toLowerCase().startsWith(pattern),
        );
      },
      itemBuilder: (context, Order order) {
        return ListTile(
          leading: const Icon(Icons.business),
          title: Text(order.serialNumber),
          subtitle: Text(order.id),
        );
      },
      onSuggestionSelected: (suggestion) {
        onSuggestionSelected(suggestion);
        textEditingController.text = suggestion.serialNumber;
      },
    ),
  ];
}
