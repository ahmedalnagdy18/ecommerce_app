import 'package:flutter/material.dart';
import 'package:flutter_application_test/features/game/presentation/cubits/game_cubit.dart';
import 'package:flutter_application_test/features/game/presentation/screens/assigned_page.dart';
import 'package:flutter_application_test/features/game/presentation/screens/completed_page.dart';
import 'package:flutter_application_test/features/game/presentation/screens/unassigned_page.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class GamePage extends StatefulWidget {
  const GamePage({
    super.key,
    required this.numberOfTasks,
    required this.sequenceOfTasks,
  });
  final int numberOfTasks;
  final int sequenceOfTasks;
  @override
  State<GamePage> createState() => _TasksPageState();
}

class _TasksPageState extends State<GamePage>
    with SingleTickerProviderStateMixin {
  late final TabController tabController;
  @override
  void initState() {
    super.initState();
    tabController = TabController(length: 3, vsync: this);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          icon: const Icon(Icons.arrow_back_ios),
          onPressed: () {
            BlocProvider.of<GameCubit>(context).remove();

            Navigator.of(context).pop();
          },
        ),
        centerTitle: true,
        backgroundColor: Colors.white,
        title: const Text(
          'Tic Tac Toe',
          style: TextStyle(
            color: Colors.black,
            fontWeight: FontWeight.w600,
          ),
        ),
      ),
      backgroundColor: Colors.white,
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 20),
          child: Container(
            decoration: BoxDecoration(
              color: Colors.teal.shade400,
              borderRadius: BorderRadius.circular(12),
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                TabBar(
                  dividerColor: Colors.white,
                  dividerHeight: 4,
                  controller: tabController,
                  indicatorPadding: const EdgeInsets.all(10),
                  unselectedLabelColor: Colors.black,
                  labelColor: Colors.white,
                  indicatorColor: Colors.white,
                  tabs: const [
                    Tab(text: 'UnAssigned'),
                    Tab(text: 'Assigned'),
                    Tab(text: 'Completed'),
                  ],
                ),
                Expanded(
                  child: TabBarView(
                    controller: tabController,
                    children: [
                      UnAssignedPage(
                        tabController: tabController,
                        numberOfTasks: widget.numberOfTasks,
                        sequenceOfTasks: widget.sequenceOfTasks,
                      ),
                      AssignedPage(tabController: tabController),
                      const CompletedPage(),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
