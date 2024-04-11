import 'dart:async';
import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:task_manager/src/app/theme/app_colors.dart';
import 'package:task_manager/src/core/common/widgets/error_view.dart';
import 'package:task_manager/src/core/common/widgets/loading_view.dart';
import 'package:task_manager/src/core/utils/managers/database/database_manager.dart';
import 'package:task_manager/src/features/injection.dart';
import 'package:task_manager/src/features/task_management/domain/entities/task_entity.dart';
import 'package:task_manager/src/features/task_management/presentation/bloc/task_bloc.dart';
import 'package:task_manager/src/features/task_management/presentation/widgets/new_task.dart';
import 'package:task_manager/src/features/task_management/presentation/widgets/task_card.dart';

class HomeBody extends StatefulWidget {
  const HomeBody({super.key});

  @override
  State<HomeBody> createState() => _HomeBodyState();
}

class _HomeBodyState extends State<HomeBody> {
  final scrollController = ScrollController();
  final totalPages = serviceLocator<DatabaseManager>().getData('TASKS_TOTAL_PAGES');

  void _setUpScrollController(BuildContext context) {
    scrollController.addListener(() {
      if (scrollController.position.atEdge) {
        if (scrollController.position.pixels != 0) {
          BlocProvider.of<TaskBloc>(context).add(LoadTasks());
        }
      }
    });
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    _setUpScrollController(context);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Tasks'),
        centerTitle: true,
        elevation: 0.5,
        backgroundColor: AppColors.grey,
      ),
      body: _tasksList(),
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

  BlocBuilder<TaskBloc, TaskState> _tasksList() {
    return BlocBuilder<TaskBloc, TaskState>(
      builder: (context, state) {
        if (state is TaskLoading && state.isFirstFetch!) {
          return Center(
            child: LoadingView(),
          );
        }
        List<TaskEntity> tasks = [];
        bool isLoading = false;
        if (state is TaskLoading) {
          tasks = state.oldTasks ?? [];
          isLoading = true;
        } else if (state is TasksLoaded) {
          tasks = state.tasks;
        } else if (state is TaskError) {
          return BlocProvider(
            create: (context) => serviceLocator<TaskBloc>(),
            child: ErrorView(
              error: state.errorMessage,
              onRefresh: () {
                BlocProvider.of<TaskBloc>(context).add(LoadTasks());
              },
            ),
          );
        } else if (state is TaskOperationSuccess) {
          BlocProvider.of<TaskBloc>(context).add(LoadTasks());
        }
        return ListView.builder(
          controller: scrollController,
          itemBuilder: (context, index) {
            if (index < tasks.length) {
              return TaskItem(taskEntity: tasks[index]);
            } else {
              Timer(Duration(milliseconds: 30), () {
                scrollController.jumpTo(scrollController.position.maxScrollExtent);
              });
              return LoadingView();
            }
          },
          itemCount: tasks.length + (isLoading ? 1 : 0),
        );
      },
    );
  }
}
