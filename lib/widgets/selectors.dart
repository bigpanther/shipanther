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
    TextEditingController _tenantTypeAheadController) {
  if (!shouldShow) return [];
  return [
    TypeAheadFormField<Tenant>(
      textFieldConfiguration: TextFieldConfiguration(
          decoration: InputDecoration(hintText: 'Select tenant'),
          controller: _tenantTypeAheadController,
          onTap: () {
            _tenantTypeAheadController.text = '';
          }),
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
        onSuggestionSelected(suggestion);
        _tenantTypeAheadController.text = suggestion.name;
      },
    ),
  ];
}

List<Widget> customerSelector(
    BuildContext context,
    bool shouldShow,
    void Function(Customer) onSuggestionSelected,
    TextEditingController _customerTypeAheadController) {
  if (!shouldShow) return [];
  return [
    TypeAheadFormField<Customer>(
      textFieldConfiguration: TextFieldConfiguration(
        decoration: InputDecoration(hintText: 'Select customer'),
        controller: _customerTypeAheadController,
        onTap: () {
          _customerTypeAheadController.text = '';
        },
      ),
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
        onSuggestionSelected(suggestion);
        _customerTypeAheadController.text = suggestion.name;
      },
    ),
  ];
}

List<Widget> driverSelector(
    BuildContext context,
    bool shouldShow,
    void Function(User) onSuggestionSelected,
    TextEditingController _driverTypeAheadController) {
  if (!shouldShow) return [];
  return [
    TypeAheadFormField<User>(
      textFieldConfiguration: TextFieldConfiguration(
          decoration: InputDecoration(hintText: 'Select Driver'),
          controller: _driverTypeAheadController,
          onTap: () {
            _driverTypeAheadController.text = '';
          }),
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
        onSuggestionSelected(suggestion);
        _driverTypeAheadController.text = suggestion.name;
      },
    ),
  ];
}

List<Widget> terminalSelector(
    BuildContext context,
    bool shouldShow,
    void Function(Terminal) onSuggestionSelected,
    TextEditingController _terminalTypeAheadController) {
  if (!shouldShow) return [];
  return [
    TypeAheadFormField<Terminal>(
      textFieldConfiguration: TextFieldConfiguration(
        decoration: InputDecoration(hintText: 'Select Terminal'),
        controller: _terminalTypeAheadController,
        onTap: () {
          _terminalTypeAheadController.text = '';
        },
      ),
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
        onSuggestionSelected(suggestion);
        _terminalTypeAheadController.text = suggestion.name;
      },
    ),
  ];
}

List<Widget> orderSelector(
    BuildContext context,
    bool shouldShow,
    void Function(Order) onSuggestionSelected,
    TextEditingController _orderTypeAheadController) {
  if (!shouldShow) return [];
  return [
    TypeAheadFormField<Order>(
      textFieldConfiguration: TextFieldConfiguration(
        decoration: InputDecoration(hintText: 'Select Order'),
        controller: _orderTypeAheadController,
        onTap: () {
          _orderTypeAheadController.text = '';
        },
      ),
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
        onSuggestionSelected(suggestion);
        _orderTypeAheadController.text = suggestion.serialNumber;
      },
    ),
  ];
}
