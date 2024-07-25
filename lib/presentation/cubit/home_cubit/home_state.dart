import 'package:flutter_application_test/domain/entities/card_info_entity.dart';

abstract class HomeState {
  const HomeState();
}

class PostsInitial extends HomeState {}

class PostsLoading extends HomeState {}

class PostsLoaded extends HomeState {
  final List<CardInfoEntity> posts;

  const PostsLoaded(this.posts);
}

class PostsError extends HomeState {
  final String message;

  const PostsError(this.message);
}
