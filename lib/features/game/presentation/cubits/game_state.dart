import 'package:flutter_application_test/features/game/domain/entities/game_entity.dart';

abstract class GameState {
  const GameState();
}

class TasksInitial extends GameState {}

class TasksLoad extends GameState {
  final List<GameEntity> completetasks;
  final List<GameEntity> unAssigned;
  late final GameEntity? assignedTask;

  TasksLoad({
    required this.completetasks,
    required this.unAssigned,
    this.assignedTask,
  });
}
