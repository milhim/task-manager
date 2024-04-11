import 'package:dartz/dartz.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/mockito.dart';
import 'package:task_manager/src/features/task_management/domain/entities/task_entity.dart';
import 'package:task_manager/src/features/task_management/domain/repositories/task_repository.dart';
import 'package:task_manager/src/features/task_management/domain/use_cases/get_task_use_case.dart';

class MockTaskRepository extends Mock implements TaskRepository {}

void main() {
  late GetTaskUseCase useCase;
  late MockTaskRepository mockTaskRepository;

  setUp(() {
    mockTaskRepository = MockTaskRepository();
    useCase = GetTaskUseCase(repository: mockTaskRepository);
  });

  final tId = 1;
  final tTask = TaskEntity(id: 1, name: 'name', year: 1222, color: "#343232", pantoneValue: '332-22');

  test('should get task from repository', () async {
    when(mockTaskRepository.getTask(any)).thenAnswer((realInvocation) async => Right(tTask));
    // act
    final result = await useCase(Params(id: tId));

    //assert
    expect(result, Right(tTask));
    verify(mockTaskRepository.getTask(tId));
    verifyNoMoreInteractions(mockTaskRepository);
  });
}
