// import 'package:flutter/material.dart';
// import 'package:shipanther/bloc/order/order_bloc.dart';
// import 'package:trober_sdk/api.dart';

// class OrderAddEdit extends StatefulWidget {
//   final Order order;
//   final OrderBloc orderBloc;
//   final bool isEdit;

//   OrderAddEdit({
//     Key key,
//     @required this.order,
//     @required this.orderBloc,
//     @required this.isEdit,
//   });
//   @override
//   _OrderAddEditState createState() => _OrderAddEditState();
// }

// class _OrderAddEditState extends State<OrderAddEdit> {
//   static final GlobalKey<FormState> formKey = GlobalKey<FormState>();

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(
//         title: Text(
//           widget.isEdit ? "Edit order" : "Add new order",
//         ),
//         centerTitle: true,
//       ),
//       body: Padding(
//         padding: EdgeInsets.all(16.0),
//         child: Form(
//           key: formKey,
//           autovalidateMode: AutovalidateMode.disabled,
//           onWillPop: () {
//             return Future(() => true);
//           },
//           child: ListView(
//               children: [
//                     TextFormField(
//                       initialValue: widget.order.customerId ?? '',
//                       autofocus: widget.isEdit ? false : true,
//                       style: Theme.of(context).textTheme.headline5,
//                       decoration: InputDecoration(hintText: 'Customer Id'),
//                       validator: (val) => val.trim().isEmpty
//                           ? "Terminal name should not be empty"
//                           : null,
//                       onSaved: (value) => _terminalName = value,
//                     ),
//                     SmartSelect<TerminalType>.single(
//                       title:
//                           "Terminal type", //ArchSampleLocalizations.of(context).fromHint,
//                       // key: ArchSampleKeys.fromField,
//                       onChange: (state) => _terminalType = state.value,
//                       choiceItems:
//                           S2Choice.listFrom<TerminalType, TerminalType>(
//                         source: TerminalType.values,
//                         value: (index, item) => item,
//                         title: (index, item) => item.toString(),
//                       ),
//                       modalType: S2ModalType.popupDialog,
//                       modalHeader: false,
//                       tileBuilder: (context, state) {
//                         return S2Tile.fromState(
//                           state,
//                           trailing: const Icon(Icons.arrow_drop_down),
//                           isTwoLine: true,
//                         );
//                       },
//                       value: widget.terminal.type ?? TerminalType.port,
//                     ),
//                     Text(widget.isEdit ? '' : 'Select a tenant'),
//                   ] +
//                   tenantSelector(context, !widget.isEdit, (Tenant suggestion) {
//                     _tenant = suggestion;
//                   })),
//         ),
//       ),
//       floatingActionButton: FloatingActionButton(
//         tooltip: widget.isEdit ? "Edit" : "Create",
//         child: Icon(widget.isEdit ? Icons.check : Icons.add),
//         onPressed: () async {
//           final form = formKey.currentState;
//           if (form.validate()) {
//             form.save();
//             widget.terminal.name = _terminalName;
//             widget.terminal.type = _terminalType;
//             if (_tenant != null) {
//               widget.terminal.tenantId = _tenant.id;
//             }
//             widget.terminal.createdBy =
//                 (await context.read<UserRepository>().self()).id;
//             if (widget.isEdit) {
//               widget.terminalBloc
//                   .add(UpdateTerminal(widget.terminal.id, widget.terminal));
//             } else {
//               widget.terminalBloc.add(CreateTerminal(widget.terminal));
//             }

//             Navigator.pop(context);
//           }
//         },
//       ),
//     );
//   }
// }

// // List<StatefulWidget> tenantSelector(BuildContext context, bool shouldShow,
// //     void Function(Tenant) onSuggestionSelected) {
// //   if (!shouldShow) return [];
// //   return [
// //     TypeAheadFormField<Tenant>(
// //       textFieldConfiguration: TextFieldConfiguration(
// //         decoration: InputDecoration(hintText: 'Select tenant'),
// //       ),
// //       suggestionsCallback: (pattern) async {
// //         var client = await context.read<ApiRepository>().apiClient();
// //         return (await client.tenantsGet())
// //             .where((element) => element.name.toLowerCase().startsWith(pattern));
// //       },
// //       itemBuilder: (context, Tenant tenant) {
// //         return ListTile(
// //           leading: Icon(Icons.business),
// //           title: Text(tenant.name),
// //           subtitle: Text(tenant.id),
// //         );
// //       },
// //       onSuggestionSelected: onSuggestionSelected,
// //       // validator: (value) {
// //       //   if (value.isEmpty) {
// //       //     return 'Please select a tenant';
// //       //   }
// //       //   return null;
// //       // },
// //     ),
// //   ];
// // }
