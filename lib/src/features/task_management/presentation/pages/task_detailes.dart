import 'dart:developer';
import 'dart:io';
import 'dart:ui';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:task_manager/src/core/common/widgets/error_view.dart';
import 'package:task_manager/src/core/common/widgets/loading_view.dart';
import 'package:task_manager/src/features/injection.dart';
import 'package:task_manager/src/features/task_management/domain/entities/task_entity.dart';
import 'package:task_manager/src/features/task_management/presentation/bloc/task_bloc.dart';
import 'package:task_manager/src/features/task_management/presentation/widgets/new_task.dart';

class DetailsPage extends StatefulWidget {
  final TaskEntity taskEntity;
  const DetailsPage({Key? key, required this.taskEntity}) : super(key: key);

  @override
  State<DetailsPage> createState() => _DetailsPageState();
}

class _DetailsPageState extends State<DetailsPage> {
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    BlocProvider.of<TaskBloc>(context).add(LoadTask(taskId: widget.taskEntity.id.toString()));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Details'),
      ),
      body: Center(
        child: BlocBuilder<TaskBloc, TaskState>(
          builder: (context, state) {
            if (state is TaskLoaded) {
              final task = state.task;
              return Padding(
                padding: const EdgeInsets.fromLTRB(16.0, 16.0, 16.0, 54.0),
                child: Column(
                  mainAxisSize: MainAxisSize.max,
                  children: [
                    DetailsRow(title: 'ID:', content: task.id.toString()),
                    DetailsRow(title: 'Name:', content: task.name),
                    DetailsRow(title: 'Color:', content: task.color),
                    DetailsRow(title: 'Pantone Value:', content: task.pantoneValue),
                    DetailsRow(title: 'Added:', content: task.year.toString()),
                  ],
                ),
              );
            } else if (state is TaskError) {
              return ErrorView(
                error: state.errorMessage,
                onRefresh: () {},
              );
            } else if (state is TaskOperationSuccess) {
              BlocProvider.of<TaskBloc>(context).add(LoadTask(taskId: widget.taskEntity.id.toString()));

              // Navigator.pushReplacement(
              //   context,
              //   MaterialPageRoute(
              //     builder: (context) => DetailsPage(taskEntity: widget.taskEntity),
              //   ),
              // );
            }
            return Center(
              child: LoadingView(),
            );
          },
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () async {
          final editedTask = await showModalBottomSheet(
            context: context,
            builder: (_) {
              return BlocProvider(
                create: (context) => serviceLocator<TaskBloc>(),
                child: NewTask.edit(
                  task: widget.taskEntity,
                ),
              );
            },
            isScrollControlled: true,
          );
          if (editedTask != null) {
            BlocProvider.of<TaskBloc>(context).add(UpdateTask(editedTask));
          }
        },
        child: Icon(Icons.edit),
      ),
    );
  }
}

class DetailsRow extends StatelessWidget {
  final String title;
  final String content;

  const DetailsRow({
    Key? key,
    required this.title,
    required this.content,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.symmetric(vertical: 16.0),
      child: Center(
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Expanded(
              child: Text(
                title,
                style: TextStyle(color: Theme.of(context).primaryColorDark, fontSize: 18.0, fontWeight: FontWeight.bold),
              ),
            ),
            Text(
              content,
              style: TextStyle(
                fontSize: 16.0,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
