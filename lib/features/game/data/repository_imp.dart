import 'package:flutter_application_test/features/game/domain/entities/game_entity.dart';
import 'package:flutter_application_test/features/game/domain/repositories/game_repository.dart';

class GameReposiatoryImp implements GameRepository {
  @override
  List<GameEntity> addTask(int numberOfTasks, int sequenceOfTasks) {
    List<GameEntity> allgametask = [];

    for (var i = 0; i < numberOfTasks; i++) {
      allgametask.add(GameEntity(
        name: 'Game ${i + 1}',
        duration: (sequenceOfTasks * 60) * (i + 1),
      ));
    }
    return allgametask;
  }
}
