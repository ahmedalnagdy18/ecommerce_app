import 'dart:async';

import 'package:flutter_application_test/features/game/domain/entities/game_entity.dart';
import 'package:flutter_application_test/features/game/domain/usecases/game_usecase.dart';
import 'package:flutter_application_test/features/game/presentation/cubits/game_state.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class GameCubit extends Cubit<GameState> {
  final GameUsecase gameUsecase;
  Timer? _timer;

  GameCubit(this.gameUsecase) : super(TasksInitial());

  void getGameTask(int numberOfTasks, int sequenceOfTasks) {
    final gametasks = gameUsecase(numberOfTasks, sequenceOfTasks);
    final completetasks = <GameEntity>[];

    emit(TasksLoad(
      completetasks: completetasks,
      unAssigned: gametasks,
    ));

    startTimer();
  }

  void refresh(int numberOfTasks, int sequenceOfTasks) {
    final gametasks = gameUsecase(numberOfTasks, sequenceOfTasks);
    final currentState = state as TasksLoad;
    final completetasks = currentState.completetasks;

    emit(TasksLoad(
      completetasks: completetasks,
      unAssigned: gametasks,
    ));

    startTimer();
  }

  void startTimer() {
    _timer?.cancel();
    _timer = Timer.periodic(const Duration(seconds: 1), (timer) {
      if (state is TasksLoad) {
        final currentState = state as TasksLoad;
        final now = DateTime.now();

        final updatedTasks = currentState.unAssigned
            .where((task) => task.endTime.isAfter(now))
            .toList();

        final expiredTasks = currentState.unAssigned
            .where((task) => task.endTime.isBefore(now))
            .toList();

        for (var task in expiredTasks) {
          task.endTime = now.add(Duration(seconds: task.duration));
        }

        emit(TasksLoad(
          completetasks: currentState.completetasks,
          unAssigned: updatedTasks,
          assignedTask: currentState.assignedTask,
        ));
      }
    });
  }

  void cloose() {
    if (state is TasksLoad) {
      final currentState = state as TasksLoad;
      if (currentState.assignedTask != null) {
        final updatedAssignedTask = currentState.assignedTask!
          ..endTime = DateTime.now()
              .add(Duration(seconds: currentState.assignedTask!.duration));

        final updatedUnAssignedTasks =
            List<GameEntity>.from(currentState.unAssigned)
              ..add(updatedAssignedTask);

        emit(TasksLoad(
          completetasks: currentState.completetasks,
          unAssigned: updatedUnAssignedTasks,
        ));
      }
    }
  }

  void completetask(GameEntity completedTask) {
    if (state is TasksLoad) {
      final currentState = state as TasksLoad;

      List<GameEntity> updatedCompleteTasks =
          List.from(currentState.completetasks)..add(completedTask);

      final updatedUnAssignedTasks =
          List<GameEntity>.from(currentState.unAssigned)..remove(completedTask);

      emit(TasksLoad(
        completetasks: updatedCompleteTasks,
        unAssigned: updatedUnAssignedTasks,
        assignedTask: currentState.assignedTask,
      ));
    }
  }

  void remove() {
    _timer?.cancel();
    _timer = null;
    emit(TasksInitial());
  }

  bool hasAssignedTask() {
    if (state is TasksLoad) {
      final currentState = state as TasksLoad;
      return currentState.assignedTask != null;
    }
    return false;
  }

//! the updatedUnAssignedTasks is the new list that we remove from it the task
  void assignTask(GameEntity task) {
    if (state is TasksLoad) {
      final currentState = state as TasksLoad;
      final updatedUnAssignedTasks =
          List<GameEntity>.from(currentState.unAssigned)..remove(task);

      emit(TasksLoad(
        completetasks: currentState.completetasks,
        unAssigned: updatedUnAssignedTasks,
        assignedTask: task,
      ));
    }
  }

  void resetAssigned() {
    if (state is TasksLoad) {
      final currentState = state as TasksLoad;
      emit(TasksLoad(
        completetasks: currentState.completetasks,
        unAssigned: currentState.unAssigned,
        assignedTask: null,
      ));
    }
  }
}
