import 'package:flutter_application_test/features/game/domain/entities/game_entity.dart';
import 'package:flutter_application_test/features/game/domain/repositories/game_repository.dart';

class GameUsecase {
  final GameRepository gameRepository;

  GameUsecase({required this.gameRepository});
  List<GameEntity> call(int numberOfTasks, int sequenceOfTasks) {
    return gameRepository.addTask(numberOfTasks, sequenceOfTasks);
  }
}
