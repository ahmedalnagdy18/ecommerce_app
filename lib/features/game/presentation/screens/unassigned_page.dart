import 'package:flutter/material.dart';
import 'package:flutter_application_test/features/game/presentation/cubits/game_cubit.dart';
import 'package:flutter_application_test/features/game/presentation/cubits/game_state.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class UnAssignedPage extends StatefulWidget {
  const UnAssignedPage({super.key, required this.tabController});
  final TabController tabController;
  @override
  State<UnAssignedPage> createState() => _UnAssignedPageState();
}

class _UnAssignedPageState extends State<UnAssignedPage> {
  String _formatTime(int seconds) {
    int minutes = seconds ~/ 60;
    int secs = seconds % 60;
    return '$minutes:${secs.toString().padLeft(2, '0')}';
  }

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<GameCubit, GameState>(
      listener: (context, state) {},
      builder: (context, state) => state is TasksLoad
          ? Scaffold(
              backgroundColor: Colors.white,
              body: Padding(
                padding: const EdgeInsets.symmetric(vertical: 20),
                child: ListView.separated(
                  scrollDirection: Axis.vertical,
                  physics: const BouncingScrollPhysics(),
                  separatorBuilder: (context, index) =>
                      const SizedBox(height: 10),
                  itemCount: state.tasks.length,
                  itemBuilder: (context, index) {
                    final task = state.tasks[index];
                    final timeRemaining = _formatTime(
                        task.endTime.difference(DateTime.now()).inSeconds);
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
                        child: InkWell(
                          onTap: () {
                            BlocProvider.of<GameCubit>(context).assignedTask =
                                task;
                            widget.tabController.animateTo(1);
                          },
                          child: Row(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Text(task.name),
                              Text('$timeRemaining '),
                            ],
                          ),
                        ),
                      ),
                    );
                  },
                ),
              ),
            )
          : const Scaffold(
              backgroundColor: Colors.white,
              body: Center(child: CircularProgressIndicator()),
            ),
    );
  }
}
