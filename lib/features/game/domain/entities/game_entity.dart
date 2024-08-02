class GameEntity {
  String name;
  int duration;
  DateTime endTime;

  GameEntity({required this.name, required this.duration})
      : endTime = DateTime.now().add(Duration(seconds: duration));
}
