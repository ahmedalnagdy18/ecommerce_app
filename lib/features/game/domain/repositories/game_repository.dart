import 'package:flutter_application_test/features/game/domain/entities/game_entity.dart';

abstract class GameRepository {
  List<GameEntity> addTask(int numberOfTasks, int sequenceOfTasks);
}
