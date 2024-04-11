import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'package:task_manager/src/features/task_management/domain/entities/task_entity.dart';
import 'package:task_manager/src/features/task_management/presentation/bloc/task_bloc.dart';

enum NewTaskState {
  edit,
  add,
}

class NewTask extends StatefulWidget {
  final NewTaskState state;
  final TaskEntity? task;

  NewTask.add({
    Key? key,
  })  : this.state = NewTaskState.add,
        this.task = null,
        super(key: key);

  NewTask.edit({
    Key? key,
    required this.task,
  })  : this.state = NewTaskState.edit,
        super(key: key);

  @override
  _NewTaskState createState() => _NewTaskState();
}

class _NewTaskState extends State<NewTask> {
  final _nameController = TextEditingController();
  final _colorController = TextEditingController();
  final _pantoneValueController = TextEditingController();
  final _dateController = TextEditingController();
  final _formKey = GlobalKey<FormState>();
  late DateTime _pickedDate;
  File? _imageFile;
  late Directory _appLibraryDirectory;

  @override
  void initState() {
    super.initState();
    if (widget.state == NewTaskState.edit) {
      _nameController.text = widget.task!.name;
      _colorController.text = widget.task!.color;
      _pantoneValueController.text = widget.task!.pantoneValue.toString();
      _pickedDate = DateTime(widget.task!.year);
      _dateController.text = _pickedDate.toString();
    }
  }

  void _onSubmit() async {
    if (!_formKey.currentState!.validate()) {
      return;
    }

    final tBloc = context.read<TaskBloc>();
    final task = TaskEntity(
        id: widget.task?.id,
        name: _nameController.text,
        pantoneValue: _pantoneValueController.text,
        year: _pickedDate.year,
        color: _colorController.text);

    if (widget.state == NewTaskState.add) {
      tBloc.add(
        AddTask(task),
      );
    } else {
      tBloc.add(
        UpdateTask(task),
      );
    }
    Navigator.of(context).pop(task);
  }

  void _startDatePicker() {
    showDatePicker(
            context: context,
            initialDate: DateTime.now(),
            firstDate: DateTime.parse("2020-01-01 00:00:01Z"),
            lastDate: DateTime.now())
        .then((value) {
      if (value == null) {
        return;
      }
      _pickedDate = value;
      _dateController.text = _pickedDate.toString();
    });
  }

  @override
  void dispose() {
    // _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Card(
        margin: EdgeInsets.symmetric(
          horizontal: 10,
          vertical: 20,
        ),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(
            18,
          ),
        ),
        elevation: 8,
        child: Container(
          padding: EdgeInsets.only(
            top: 20,
            left: 20,
            right: 20,
            bottom: MediaQuery.of(context).viewInsets.bottom,
          ),
          child: Form(
            key: _formKey,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.end,
              children: [
                TextFormField(
                  decoration: InputDecoration(labelText: 'Name'),
                  controller: _nameController,
                  validator: (value) {
                    if (value!.isEmpty) {
                      return 'Name cannot be empty';
                    }
                    return null;
                  },
                ),
                TextFormField(
                  decoration: InputDecoration(labelText: 'Pantone Value'),
                  controller: _pantoneValueController,
                  validator: (value) {
                    if (value!.isEmpty) {
                      return 'pantoneValue cannot be empty';
                    }
                    return null;
                  },
                ),
                TextFormField(
                  decoration: InputDecoration(labelText: 'Color'),
                  controller: _colorController,
                  validator: (value) {
                    if (value!.isEmpty) {
                      return 'pantoneValue cannot be empty';
                    }
                    return null;
                  },
                ),
                TextFormField(
                  readOnly: true,
                  controller: _dateController,
                  decoration: InputDecoration(labelText: 'Date'),
                  enableInteractiveSelection: false,
                  validator: (value) {
                    if (value!.isEmpty) {
                      return 'Please pick a date';
                    }
                    return null;
                  },
                ),
                MaterialButton(
                  onPressed: _startDatePicker,
                  child: Text(
                    'Choose Date',
                    style: TextStyle(
                      color: Theme.of(context).primaryColor,
                      fontSize: 16,
                    ),
                  ),
                ),
                MaterialButton(
                  onPressed: _onSubmit,
                  child: Text(
                    widget.state == NewTaskState.add ? 'Add Task' : 'Update',
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 18,
                    ),
                  ),
                  color: Theme.of(context).primaryColor,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(18),
                  ),
                  padding: EdgeInsets.symmetric(
                    horizontal: 20,
                    vertical: 10,
                  ),
                ),
                SizedBox(
                  height: 10,
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
