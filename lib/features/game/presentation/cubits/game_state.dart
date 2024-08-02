import 'package:flutter_application_test/features/game/domain/entities/game_entity.dart';

abstract class GameState {
  const GameState();
}

final class TasksInitial extends GameState {}

final class TasksLoad extends GameState {
  List<GameEntity> tasks;

  TasksLoad({required this.tasks});
}
