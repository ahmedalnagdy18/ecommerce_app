import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_application_test/features/game/presentation/cubits/game_cubit.dart';
import 'package:flutter_application_test/features/game/presentation/cubits/game_state.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class UnAssignedPage extends StatefulWidget {
  const UnAssignedPage(
      {super.key,
      required this.tabController,
      required this.numberOfTasks,
      required this.sequenceOfTasks});
  final TabController tabController;
  final int numberOfTasks;
  final int sequenceOfTasks;
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
              body: Column(
                children: [
                  state.tasks.isEmpty
                      ? Center(
                          child: IconButton(
                              onPressed: () {
                                BlocProvider.of<GameCubit>(context).getGameTask(
                                    widget.numberOfTasks,
                                    widget.sequenceOfTasks);
                              },
                              icon: const Icon(Icons.refresh)),
                        )
                      : Expanded(
                          child: Padding(
                            padding: const EdgeInsets.symmetric(vertical: 20),
                            child: ListView.separated(
                              scrollDirection: Axis.vertical,
                              shrinkWrap: true,
                              physics: const BouncingScrollPhysics(),
                              separatorBuilder: (context, index) =>
                                  const SizedBox(height: 10),
                              itemCount: BlocProvider.of<GameCubit>(context)
                                  .gametasks
                                  .length,
                              //state.tasks.length,
                              itemBuilder: (context, index) {
                                final task = BlocProvider.of<GameCubit>(context)
                                    .gametasks[index];
                                //  final task = state.tasks[index];
                                final timeRemaining = _formatTime(task.endTime
                                    .difference(DateTime.now())
                                    .inSeconds);
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
                                        if (!BlocProvider.of<GameCubit>(context)
                                            .hasAssignedTask()) {
                                          BlocProvider.of<GameCubit>(context)
                                              .assignedTask = task;

                                          BlocProvider.of<GameCubit>(context)
                                              .gametasks
                                              .remove(task);

                                          widget.tabController.animateTo(1);
                                        } else {
                                          ScaffoldMessenger.of(context)
                                              .showSnackBar(const SnackBar(
                                            backgroundColor: Colors.red,
                                            content: Text(
                                                '''The last Game does'n finsh '''),
                                          ));
                                        }
                                      },
                                      child: Row(
                                        crossAxisAlignment:
                                            CrossAxisAlignment.start,
                                        mainAxisAlignment:
                                            MainAxisAlignment.spaceBetween,
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
                        ),
                ],
              ),
            )
          : const Scaffold(
              backgroundColor: Colors.white,
              body: Center(
                child: CupertinoActivityIndicator(color: Colors.black),
              ),
            ),
    );
  }
}
