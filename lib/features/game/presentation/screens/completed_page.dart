import 'package:flutter/material.dart';
import 'package:flutter_application_test/features/game/domain/entities/game_entity.dart';
import 'package:flutter_application_test/features/game/presentation/cubits/game_cubit.dart';
import 'package:flutter_application_test/features/game/presentation/cubits/game_state.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class CompletedPage extends StatefulWidget {
  const CompletedPage({super.key});

  @override
  State<CompletedPage> createState() => _CompletedPageState();
}

class _CompletedPageState extends State<CompletedPage> {
  List<GameEntity> tasks = [];
  @override
  Widget build(BuildContext context) {
    tasks = BlocProvider.of<GameCubit>(context).completetasks;
    return BlocBuilder<GameCubit, GameState>(
        builder: (context, state) => Scaffold(
              backgroundColor: Colors.white,
              body: Padding(
                padding: const EdgeInsets.symmetric(vertical: 20),
                child: ListView.separated(
                  scrollDirection: Axis.vertical,
                  physics: const BouncingScrollPhysics(),
                  separatorBuilder: (context, index) =>
                      const SizedBox(height: 10),
                  itemCount: tasks.length,
                  itemBuilder: (context, index) {
                    final task = tasks[index];

                    return Container(
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(12),
                        color: Colors.grey.shade300,
                      ),
                      child: Padding(
                        padding: const EdgeInsets.symmetric(
                          horizontal: 24,
                          vertical: 15,
                        ),
                        child: Row(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Text(task.name),
                          ],
                        ),
                      ),
                    );
                  },
                ),
              ),
            ));
  }
}
