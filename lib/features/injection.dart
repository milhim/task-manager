import 'package:get_it/get_it.dart';
import 'package:task_manager/app/logic/app_settings.dart';
import 'package:task_manager/core/utils/managers/database/database_manager.dart';
import 'package:task_manager/core/utils/managers/database/hive_service.dart';
import 'package:task_manager/features/auth/data/data_source/remote_data_source.dart';
import 'package:task_manager/features/auth/data/repositories/login_repository_impl.dart';
import 'package:task_manager/features/auth/domain/repositories/login_repository.dart';
import 'package:task_manager/features/auth/domain/use_cases/login_use_case.dart';
import 'package:task_manager/features/auth/presentation/bloc/login_bloc.dart';
import 'package:task_manager/features/task_management/data/data_source/remote_data_source.dart';
import 'package:task_manager/features/task_management/data/repositories/task_repository_impl.dart';
import 'package:task_manager/features/task_management/domain/repositories/task_repository.dart';
import 'package:task_manager/features/task_management/domain/use_cases/create_task_use_case.dart';
import 'package:task_manager/features/task_management/domain/use_cases/delete_task_use_case.dart';
import 'package:task_manager/features/task_management/domain/use_cases/get_task_use_case.dart';
import 'package:task_manager/features/task_management/domain/use_cases/get_tasks_use_case.dart';
import 'package:task_manager/features/task_management/domain/use_cases/update_task_use_case.dart';
import 'package:task_manager/features/task_management/presentation/bloc/task_bloc.dart';

final serviceLocator = GetIt.instance;

Future<void> init() async {
  initInjections(serviceLocator);
  serviceLocator.allowReassignment = true;
}

void initInjections(GetIt serviceLocator) {
  serviceLocator.registerLazySingleton<AppSettings>(
    () => AppSettings(databaseManager: serviceLocator()),
  );
  //* Network

  //* Database
  serviceLocator.registerLazySingleton<DatabaseManager>(
    () => DatabaseManagerImpl(),
  );
  serviceLocator.registerLazySingleton<HiveService>(
    () => HiveService(),
  );
//repos
  serviceLocator.registerFactory<LoginRepository>(
    () => LoginRepositoryImpl(
      loginDataSource: serviceLocator(),
    ),
  );
  serviceLocator.registerFactory<TaskRepository>(
    () => TaskRepositoryImpl(
      taskDataSource: serviceLocator(),
    ),
  );

  //data source
  serviceLocator.registerFactory<LoginDataSource>(
    () => LoginDataSourceImpl(),
  );
  serviceLocator.registerFactory<TaskDataSource>(
    () => TaskDataSourceImpl(),
  );

  //use cases

  serviceLocator.registerFactory<LoginUseCase>(
    () => LoginUseCase(repository: serviceLocator()),
  );
  serviceLocator.registerFactory<GetTasksUseCase>(
    () => GetTasksUseCase(repository: serviceLocator()),
  );
  serviceLocator.registerFactory<GetTaskUseCase>(
    () => GetTaskUseCase(repository: serviceLocator()),
  );
  serviceLocator.registerFactory<UpdateTaskUseCase>(
    () => UpdateTaskUseCase(repository: serviceLocator()),
  );
  serviceLocator.registerFactory<CreateTaskUseCase>(
    () => CreateTaskUseCase(repository: serviceLocator()),
  );
  serviceLocator.registerFactory<DeleteTaskUseCase>(
    () => DeleteTaskUseCase(repository: serviceLocator()),
  );

  //bloc
  serviceLocator.registerFactory<LoginBloc>(
    () => LoginBloc(
      loginUseCase: serviceLocator(),
    ),
  );
  serviceLocator.registerFactory<TaskBloc>(
    () => TaskBloc(
      getTasksUseCase: serviceLocator(),
      getTaskUseCase: serviceLocator(),
      updateTaskUseCase: serviceLocator(),
      createTaskUseCase: serviceLocator(),
      deleteTaskUseCase: serviceLocator(),
    ),
  );
}
