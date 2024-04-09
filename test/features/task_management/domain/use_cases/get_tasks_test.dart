// import 'package:dartz/dartz.dart';
// import 'package:flutter_test/flutter_test.dart';
// import 'package:mockito/mockito.dart';
// import 'package:task_manager/features/task_management/domain/entities/task.dart';
// import 'package:task_manager/features/task_management/domain/repositories/task_repository.dart';
// import 'package:task_manager/features/task_management/domain/use_cases/get_tasks_use_case.dart';

// class MockTaskRepository extends Mock implements TaskRepository {}

// void main() {
//   GetTasksUseCase useCase;
//   MockTaskRepository mockTaskRepository;

//   mockTaskRepository = MockTaskRepository();
//   useCase = GetTasksUseCase(repository: mockTaskRepository);

//   final tTasks = [TaskEntity(id: 1, name: 'name', year: 1222, color: "#343232", pantoneValue: '332-22')];

//   test('should get tasks from repository', () async {
//     //arrange
//     when(mockTaskRepository.getTasks()).thenAnswer((_) async => Right(tTasks));
//     // act

//     final result = await useCase.execute();

//     //assert

//     expect(result, Right(tTasks));

//     verify(mockTaskRepository.getTasks());
//     verifyNoMoreInteractions(mockTaskRepository);
//   });
// }
