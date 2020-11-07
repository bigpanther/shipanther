// Copyright 2018 The Flutter Architecture Sample Authors. All rights reserved.
// Use of this source code is governed by the MIT license that can be found
// in the LICENSE file.

import 'dart:async';

import 'package:flutter/material.dart';
import 'package:shipanther/blocs/models/task.dart';
import 'package:shipanther/tasks_app_core/keys.dart';
import 'package:shipanther/tasks_app_core/localization.dart';
import 'package:smart_select/smart_select.dart';

List<String> locations = [
  'Delta Port',
  'Vancouver Port',
  'Tssawassen',
  'Delta Yard 1',
  'Delta Yard 2',
  'Delta Yard 3',
  'Can Rail Terminal',
  '7510 HOPCOTT',
];

class AddEditScreen extends StatefulWidget {
  final Task task;
  final Function(Task) addTask;
  final Function(Task) updateTask;

  AddEditScreen({
    Key key,
    this.task,
    this.addTask,
    this.updateTask,
  }) : super(key: key ?? ArchSampleKeys.addTaskScreen);

  @override
  _AddEditScreenState createState() => _AddEditScreenState();
}

class _AddEditScreenState extends State<AddEditScreen> {
  static final GlobalKey<FormState> formKey = GlobalKey<FormState>();

  String _containerName;
  String _from;
  String _to;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          isEditing
              ? ArchSampleLocalizations.of(context).editTask
              : ArchSampleLocalizations.of(context).addTask,
        ),
      ),
      body: Padding(
        padding: EdgeInsets.all(16.0),
        child: Form(
          key: formKey,
          autovalidate: false,
          onWillPop: () {
            return Future(() => true);
          },
          child: ListView(
            children: [
              TextFormField(
                initialValue:
                    widget.task != null ? widget.task.containerName : '',
                key: ArchSampleKeys.containerNameField,
                autofocus: isEditing ? false : true,
                style: Theme.of(context).textTheme.headline,
                decoration: InputDecoration(
                  hintText:
                      ArchSampleLocalizations.of(context).containerNameHint,
                ),
                validator: (val) => val.trim().isEmpty
                    ? ArchSampleLocalizations.of(context).emptyTaskError
                    : null,
                onSaved: (value) => _containerName = value,
              ),
              SmartSelect<String>.single(
                title: ArchSampleLocalizations.of(context).fromHint,
                key: ArchSampleKeys.fromField,
                onChange: (state) => _from = state.value,
                choiceItems: S2Choice.listFrom<String, String>(
                  source: locations,
                  value: (index, item) => item,
                  title: (index, item) => item,
                ),
                modalType: S2ModalType.popupDialog,
                modalHeader: false,
                tileBuilder: (context, state) {
                  return S2Tile.fromState(
                    state,
                    trailing: const Icon(Icons.arrow_drop_down),
                    isTwoLine: true,
                  );
                },
              ),
              SmartSelect<String>.single(
                title: ArchSampleLocalizations.of(context).toHint,
                key: ArchSampleKeys.toField,
                onChange: (state) => _to = state.value,
                choiceItems: S2Choice.listFrom<String, String>(
                  source: locations,
                  value: (index, item) => item,
                  title: (index, item) => item,
                ),
                modalType: S2ModalType.popupDialog,
                modalHeader: false,
                tileBuilder: (context, state) {
                  return S2Tile.fromState(
                    state,
                    trailing: const Icon(Icons.arrow_drop_down),
                    isTwoLine: true,
                  );
                },
              ),
              // TextFormField(
              //   initialValue: widget.task != null ? widget.task.to : '',
              //   key: ArchSampleKeys.toField,
              //   maxLines: 10,
              //   style: Theme.of(context).textTheme.subhead,
              //   decoration: InputDecoration(
              //     hintText: ArchSampleLocalizations.of(context).toHint,
              //   ),
              //   onSaved: (value) => _to = value,
              // )
            ],
          ),
        ),
      ),
      floatingActionButton: FloatingActionButton(
        key:
            isEditing ? ArchSampleKeys.saveTaskFab : ArchSampleKeys.saveNewTask,
        tooltip: isEditing
            ? ArchSampleLocalizations.of(context).saveChanges
            : ArchSampleLocalizations.of(context).addTask,
        child: Icon(isEditing ? Icons.check : Icons.add),
        onPressed: () {
          final form = formKey.currentState;
          if (form.validate() && (_from != _to)) {
            form.save();

            if (isEditing) {
              widget.updateTask(widget.task.copyWith(
                  containerName: _containerName, from: _from, to: _to));
            } else {
              widget.addTask(Task(
                _containerName,
                DateTime.now(),
                from: _from,
                to: _to,
              ));
            }

            Navigator.pop(context);
          }
        },
      ),
    );
  }

  bool get isEditing => widget.task != null;
}
