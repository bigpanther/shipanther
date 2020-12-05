import 'package:flutter/material.dart';
import 'package:flutter_typeahead/flutter_typeahead.dart';
import 'package:shipanther/data/api/api_repository.dart';
import 'package:trober_sdk/api.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shipanther/extensions/user_extension.dart';

final TextEditingController _tenantTypeAheadController =
    TextEditingController();
final TextEditingController _customerTypeAheadController =
    TextEditingController();
final TextEditingController _driverTypeAheadController =
    TextEditingController();
final TextEditingController _terminalTypeAheadController =
    TextEditingController();
final TextEditingController _orderTypeAheadController = TextEditingController();

List<Widget> tenantSelector(BuildContext context, bool shouldShow,
    void Function(Tenant) onSuggestionSelected) {
  if (!shouldShow) return [];
  return [
    TypeAheadFormField<Tenant>(
      textFieldConfiguration: TextFieldConfiguration(
          decoration: InputDecoration(hintText: 'Select tenant'),
          controller: _tenantTypeAheadController),
      suggestionsCallback: (pattern) async {
        var client = await context.read<ApiRepository>().apiClient();
        return (await client.tenantsGet())
            .where((element) => element.name.toLowerCase().startsWith(pattern));
      },
      itemBuilder: (context, Tenant tenant) {
        return ListTile(
          leading: Icon(Icons.business),
          title: Text(tenant.name),
          subtitle: Text(tenant.id),
        );
      },
      onSuggestionSelected: (suggestion) {
        _tenantTypeAheadController.text = suggestion.name;
      },
    ),
  ];
}

List<Widget> customerSelector(BuildContext context, bool shouldShow,
    void Function(Customer) onSuggestionSelected) {
  if (!shouldShow) return [];
  return [
    TypeAheadFormField<Customer>(
      textFieldConfiguration: TextFieldConfiguration(
          decoration: InputDecoration(hintText: 'Select customer'),
          controller: _customerTypeAheadController),
      suggestionsCallback: (pattern) async {
        var client = await context.read<ApiRepository>().apiClient();
        return (await client.customersGet())
            .where((element) => element.name.toLowerCase().startsWith(pattern));
      },
      itemBuilder: (context, Customer customer) {
        return ListTile(
          leading: Icon(Icons.business),
          title: Text(customer.name),
          subtitle: Text(customer.id),
        );
      },
      onSuggestionSelected: (suggestion) {
        _orderTypeAheadController.text = suggestion.name;
      },
    ),
  ];
}

List<Widget> driverSelector(BuildContext context, bool shouldShow,
    void Function(User) onSuggestionSelected) {
  if (!shouldShow) return [];
  return [
    TypeAheadFormField<User>(
      textFieldConfiguration: TextFieldConfiguration(
          decoration: InputDecoration(hintText: 'Select Driver'),
          controller: _driverTypeAheadController),
      suggestionsCallback: (pattern) async {
        var client = await context.read<ApiRepository>().apiClient();
        return (await client.usersGet()).where((element) =>
            element.isDriver && element.name.toLowerCase().startsWith(pattern));
      },
      itemBuilder: (context, User user) {
        return ListTile(
          leading: Icon(Icons.business),
          title: Text(user.name),
          subtitle: Text(user.id),
        );
      },
      onSuggestionSelected: (suggestion) {
        _orderTypeAheadController.text = suggestion.name;
      },
    ),
  ];
}

List<Widget> terminalSelector(BuildContext context, bool shouldShow,
    void Function(Terminal) onSuggestionSelected) {
  if (!shouldShow) return [];
  return [
    TypeAheadFormField<Terminal>(
      textFieldConfiguration: TextFieldConfiguration(
          decoration: InputDecoration(hintText: 'Select Terminal'),
          controller: _terminalTypeAheadController),
      suggestionsCallback: (pattern) async {
        var client = await context.read<ApiRepository>().apiClient();
        return (await client.terminalsGet())
            .where((element) => element.name.toLowerCase().startsWith(pattern));
      },
      itemBuilder: (context, Terminal terminal) {
        return ListTile(
          leading: Icon(Icons.business),
          title: Text(terminal.name),
          subtitle: Text(terminal.id),
        );
      },
      onSuggestionSelected: (suggestion) {
        _terminalTypeAheadController.text = suggestion.name;
      },
    ),
  ];
}

List<Widget> orderSelector(BuildContext context, bool shouldShow,
    void Function(Order) onSuggestionSelected) {
  if (!shouldShow) return [];
  return [
    TypeAheadFormField<Order>(
      textFieldConfiguration: TextFieldConfiguration(
          decoration: InputDecoration(hintText: 'Select Order'),
          controller: _orderTypeAheadController),
      suggestionsCallback: (pattern) async {
        var client = await context.read<ApiRepository>().apiClient();
        return (await client.ordersGet()).where((element) =>
            element.serialNumber.toLowerCase().startsWith(pattern));
      },
      itemBuilder: (context, Order order) {
        return ListTile(
          leading: Icon(Icons.business),
          title: Text(order.serialNumber),
          subtitle: Text(order.id),
        );
      },
      onSuggestionSelected: (suggestion) {
        _orderTypeAheadController.text = suggestion.serialNumber;
      },
    ),
  ];
}
