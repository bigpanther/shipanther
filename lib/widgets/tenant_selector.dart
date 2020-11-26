import 'package:flutter/material.dart';
import 'package:flutter_typeahead/flutter_typeahead.dart';
import 'package:shipanther/data/api/api_repository.dart';
import 'package:trober_sdk/api.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

List<StatefulWidget> tenantSelector(BuildContext context, bool shouldShow,
    void Function(Tenant) onSuggestionSelected) {
  if (!shouldShow) return [];
  return [
    TypeAheadFormField<Tenant>(
      textFieldConfiguration: TextFieldConfiguration(
        decoration: InputDecoration(hintText: 'Select tenant'),
      ),
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
      onSuggestionSelected: onSuggestionSelected,
    ),
  ];
}

List<StatefulWidget> customerSelector(BuildContext context, bool shouldShow,
    void Function(Customer) onSuggestionSelected) {
  if (!shouldShow) return [];
  return [
    TypeAheadFormField<Customer>(
      textFieldConfiguration: TextFieldConfiguration(
        decoration: InputDecoration(hintText: 'Select customer'),
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
      onSuggestionSelected: onSuggestionSelected,
    ),
  ];
}
