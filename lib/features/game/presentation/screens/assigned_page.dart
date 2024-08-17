import 'dart:math';
import 'package:flutter/material.dart';
import 'package:flutter_application_test/features/game/domain/entities/game_entity.dart';
import 'package:flutter_application_test/features/game/presentation/cubits/game_cubit.dart';
import 'package:flutter_application_test/features/game/presentation/cubits/game_state.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class AssignedPage extends StatefulWidget {
  const AssignedPage({super.key, required this.tabController});
  final TabController tabController;

  @override
  State<AssignedPage> createState() => _AssignedPageState();
}

class _AssignedPageState extends State<AssignedPage> {
  bool oTurn = true;
  List<String> gridViewList = ['', '', '', '', '', '', '', '', ''];
  int oScore = 0;
  int xScore = 0;
  int filledBoxes = 0;
  bool gameOver = false;
  GameEntity? task;

  @override
  void initState() {
    super.initState();
    _resetBoard();
  }

  String _formatTime(int seconds) {
    if (gameOver) {
      return '0:00';
    }
    int minutes = seconds ~/ 60;
    int secs = seconds % 60;
    return '$minutes:${secs.toString().padLeft(2, '0')}';
  }

  @override
  Widget build(BuildContext context) {
    if (task != null && task!.endTime.isBefore(DateTime.now())) {
      task = null;
    } else {
      task = BlocProvider.of<GameCubit>(context).assignedTask;
    }

    return BlocConsumer<GameCubit, GameState>(
      listener: (context, state) {
        if (task != null && task!.endTime.isBefore(DateTime.now())) {
          BlocProvider.of<GameCubit>(context).cloose();
          widget.tabController.animateTo(0);
        }
      },
      builder: (context, state) => state is TasksLoad && task != null
          ? Scaffold(
              backgroundColor: Colors.white,
              body: Padding(
                padding:
                    const EdgeInsets.symmetric(vertical: 20, horizontal: 20),
                child: Column(
                  children: [
                    Container(
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(12),
                        color: Colors.grey.shade300,
                      ),
                      child: Padding(
                        padding: const EdgeInsets.symmetric(
                            horizontal: 24, vertical: 15),
                        child: Row(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Text(task!.name),
                            Text(_formatTime(task!.endTime
                                    .difference(DateTime.now())
                                    .inSeconds)
                                .toString())
                          ],
                        ),
                      ),
                    ),
                    const SizedBox(height: 20),
                    Text(
                      "Player '${oTurn ? 'O' : 'X'}' Turn",
                      style: const TextStyle(
                        fontWeight: FontWeight.w600,
                        color: Colors.black,
                        fontSize: 18,
                      ),
                    ),
                    const SizedBox(height: 20),
                    Expanded(
                      flex: 4,
                      child: GridView.builder(
                        itemCount: gridViewList.length,
                        gridDelegate:
                            const SliverGridDelegateWithFixedCrossAxisCount(
                          crossAxisCount: 3,
                        ),
                        itemBuilder: (BuildContext context, int index) {
                          return GestureDetector(
                            onTap: () {
                              _tapped(index);
                            },
                            child: Container(
                              decoration: BoxDecoration(
                                border: Border.all(color: Colors.black),
                                color: Colors.white,
                              ),
                              child: Center(
                                child: Text(
                                  gridViewList[index],
                                  style: const TextStyle(
                                    color: Colors.black,
                                    fontSize: 35,
                                  ),
                                ),
                              ),
                            ),
                          );
                        },
                      ),
                    ),
                  ],
                ),
              ),
            )
          : task == null
              ? const Scaffold(
                  backgroundColor: Colors.white,
                  body: Center(
                    child: Text(
                      "no assigned task",
                    ),
                  ))
              : const Scaffold(
                  body: Center(
                  child: CircularProgressIndicator(),
                )),
    );
  }

  void _tapped(int index) {
    if (gridViewList[index] != '' || !oTurn || gameOver) {
      return;
    }

    setState(() {
      gridViewList[index] = 'O';
      filledBoxes++;
      oTurn = !oTurn;
      _checkWinner();
      if (!oTurn && !gameOver) {
        Future.delayed(const Duration(seconds: 1), _computerMove);
      }
    });
  }

  void _computerMove() {
    List<int> emptySpots = [];
    for (int i = 0; i < gridViewList.length; i++) {
      if (gridViewList[i] == '') {
        emptySpots.add(i);
      }
    }

    if (emptySpots.isNotEmpty && !gameOver) {
      int randomIndex = Random().nextInt(emptySpots.length);
      int computerMoveIndex = emptySpots[randomIndex];

      setState(() {
        gridViewList[computerMoveIndex] = 'X';
        filledBoxes++;
        oTurn = !oTurn;
        _checkWinner();
      });
    }
  }

  void _resetBoard() {
    setState(() {
      gridViewList = ['', '', '', '', '', '', '', '', ''];
      filledBoxes = 0;
      oTurn = true;
      gameOver = false;
    });
  }

  void _checkWinner() {
    List<List<int>> winningPatterns = [
      [0, 1, 2],
      [3, 4, 5],
      [6, 7, 8],
      [0, 3, 6],
      [1, 4, 7],
      [2, 5, 8],
      [0, 4, 8],
      [2, 4, 6],
    ];

    for (var pattern in winningPatterns) {
      String element1 = gridViewList[pattern[0]];
      String element2 = gridViewList[pattern[1]];
      String element3 = gridViewList[pattern[2]];

      if (element1.isNotEmpty && element1 == element2 && element1 == element3) {
        setState(() {
          gameOver = true;
        });
        _showWinDialog(element1);
        return;
      }
    }

    if (filledBoxes == 9 && !gameOver) {
      setState(() {
        gameOver = true;
      });
      _showDrawDialog();
    }
  }

  void _showWinDialog(String winner) {
    showDialog(
      context: context,
      barrierDismissible: false,
      builder: (_) => AlertDialog(
        title: Center(
          child: Text(
            "Winner is player '$winner'",
            style: const TextStyle(
              fontWeight: FontWeight.w600,
            ),
          ),
        ),
        actions: [
          Center(
            child: TextButton(
              style: ButtonStyle(
                shape:
                    MaterialStateProperty.all(const RoundedRectangleBorder()),
                backgroundColor: MaterialStateProperty.all(Colors.teal),
              ),
              onPressed: () {
                if (winner == 'X') {
                  Navigator.of(context).pop();
                  _resetBoard();
                } else {
                  BlocProvider.of<GameCubit>(context).completetask(task!);
                  BlocProvider.of<GameCubit>(context).assignedTask = null;
                  Navigator.of(context).pop();
                  widget.tabController.animateTo(0);
                }
              },
              child: const Text(
                " Ok ",
                style: TextStyle(color: Colors.white),
              ),
            ),
          ),
        ],
      ),
    );
  }

  void _showDrawDialog() {
    showDialog(
      context: context,
      builder: (_) => AlertDialog(
        title: const Text("Draw!"),
        content: const Text("The game is a draw."),
        actions: [
          TextButton(
            onPressed: () {
              Navigator.of(context).pop();
              _resetBoard();
            },
            child: const Text("Play Again"),
          ),
        ],
      ),
    );
  }
}
