import 'package:flutter_application_test/features/home/domain/entities/card_info_entity.dart';

abstract class ExploreState {
  const ExploreState();
}

class ExplorePostsInitial extends ExploreState {}

class ExplorePostsLoading extends ExploreState {}

class ExplorePostsLoaded extends ExploreState {
  final List<CardInfoEntity> posts;

  const ExplorePostsLoaded(this.posts);
}

class ExplorePostsError extends ExploreState {
  final String message;

  const ExplorePostsError(this.message);
}
