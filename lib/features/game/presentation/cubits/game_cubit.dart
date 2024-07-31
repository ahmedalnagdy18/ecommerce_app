import 'dart:async';

import 'package:flutter_application_test/features/game/domain/entities/game_entity.dart';
import 'package:flutter_application_test/features/game/domain/usecases/game_usecase.dart';
import 'package:flutter_application_test/features/game/presentation/cubits/game_state.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class GameCubit extends Cubit<GameState> {
  final GameUsecase gameUsecase;
  GameCubit(this.gameUsecase) : super(TasksInitial());
  List<GameEntity> completetasks = [];
  List<GameEntity> gametasks = [];
  GameEntity? assignedTask;
  Timer? _timer;
  void getGameTask(int numberOfTasks, int sequenceOfTasks) {
    gametasks = gameUsecase(numberOfTasks, sequenceOfTasks);
    startTimer();
  }

  void startTimer() {
    _timer = Timer.periodic(const Duration(seconds: 1), (timer) {
      final now = DateTime.now();
      final updatedTasks =
          gametasks.where((task) => task.endTime.isAfter(now)).toList();
      emit(TasksLoad(tasks: updatedTasks));
    });
  }

  // @override
  // Future<void> close() {
  //   _timer?.cancel();
  //   assignedTask = null;
  //   return super.close();
  // }
  void cloose() {
    assignedTask = null;
  }

  completetask(GameEntity completedtasks) {
    completetasks.add(completedtasks);
    gametasks.remove(completedtasks);
  }

  void remove() {
    gametasks.clear();
    completetasks.clear();
    assignedTask = null;
  }

  bool hasAssignedTask() {
    return assignedTask != null;
  }
}
