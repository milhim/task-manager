import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:task_manager/app/theme/app_colors.dart';
import 'package:task_manager/core/common/widgets/error_view.dart';
import 'package:task_manager/core/common/widgets/loading_view.dart';
import 'package:task_manager/core/utils/managers/database/database_manager.dart';
import 'package:task_manager/features/injection.dart';
import 'package:task_manager/features/task_management/presentation/bloc/task_bloc.dart';
import 'package:task_manager/features/task_management/presentation/widgets/new_task.dart';
import 'package:task_manager/features/task_management/presentation/widgets/task_card.dart';

class HomeBody extends StatefulWidget {
  const HomeBody({super.key});

  @override
  State<HomeBody> createState() => _HomeBodyState();
}

class _HomeBodyState extends State<HomeBody> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Tasks'),
        centerTitle: true,
        elevation: 0.5,
        backgroundColor: AppColors.grey,
      ),
      body: BlocBuilder<TaskBloc, TaskState>(
        builder: (context, state) {
          if (state is TasksLoaded) {
            return Center(
              child: SizedBox(
                height: (MediaQuery.of(context).size.height),
                child: ListView.builder(
                  itemBuilder: (context, index) {
                    if (index == state.tasks.length) {
                      return SizedBox(height: 75.0);
                    }
                    if (index != 0 && index % 3 == 0 && state.tasks.length > 4) {
                      return Column(
                        children: [
                          TaskItem(taskEntity: state.tasks[index]),
                        ],
                      );
                    }
                    return TaskItem(taskEntity: state.tasks[index]);
                  },
                  itemCount: state.tasks.length + 1,
                ),
              ),
            );
          } else if (state is TaskError) {
            return ErrorView(
              error: state.errorMessage,
              onRefresh: () {},
            );
          } else if (state is TaskOperationSuccess) {
            BlocProvider.of<TaskBloc>(context).add(LoadTasks());

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
      floatingActionButton: FloatingActionButton(
        onPressed: () async {
          final editedTask = await showModalBottomSheet(
            context: context,
            builder: (_) {
              return BlocProvider(
                create: (context) => serviceLocator<TaskBloc>(),
                child: NewTask.add(),
              );
            },
            isScrollControlled: true,
          );
          if (editedTask != null) {
            log(editedTask.toString());
            BlocProvider.of<TaskBloc>(context).add(AddTask(editedTask));
          }
        },
        child: Icon(Icons.add),
      ),
    );
  }
}
