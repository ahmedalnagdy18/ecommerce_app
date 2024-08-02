import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_application_test/core/common/button_widget.dart';
import 'package:flutter_application_test/core/common/textfield_widget.dart';
import 'package:flutter_application_test/features/game/domain/usecases/game_usecase.dart';
import 'package:flutter_application_test/features/game/presentation/cubits/game_cubit.dart';
import 'package:flutter_application_test/features/game/presentation/screens/game_page.dart';
import 'package:flutter_application_test/features/game/presentation/widgets/appbar_widget.dart';
import 'package:flutter_application_test/injection_container.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class AddTaskGamePage extends StatelessWidget {
  const AddTaskGamePage({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => GameCubit(GameUsecase(gameRepository: sl())),
      child: const AddTaskGame(),
    );
  }
}

class AddTaskGame extends StatefulWidget {
  const AddTaskGame({super.key});

  @override
  State<AddTaskGame> createState() => _AddTaskGameState();
}

class _AddTaskGameState extends State<AddTaskGame> {
  final TextEditingController _numberOfTasks = TextEditingController();
  final TextEditingController _sequenceOfTasks = TextEditingController();
  bool _isButtonEnabled = false;
  Timer? _timer;

  @override
  void initState() {
    super.initState();
    _numberOfTasks.addListener(_isEnabled);
    _sequenceOfTasks.addListener(_isEnabled);
  }

  @override
  void dispose() {
    _numberOfTasks.removeListener(_isEnabled);
    _sequenceOfTasks.removeListener(_isEnabled);
    _numberOfTasks.dispose();
    _sequenceOfTasks.dispose();
    _timer?.cancel();
    super.dispose();
  }

  void _isEnabled() {
    setState(() {
      _isButtonEnabled =
          _numberOfTasks.text.isNotEmpty && _sequenceOfTasks.text.isNotEmpty;
    });
  }

  void _startTimer(int minutes) {
    _timer?.cancel();
    _timer = Timer(Duration(minutes: minutes), () {});
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: const AppBarWidget(),
      body: SingleChildScrollView(
        physics: const BouncingScrollPhysics(),
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
          child: Form(
            autovalidateMode: AutovalidateMode.always,
            child: Column(
              children: [
                TextFieldWidget(
                  label: const Text('Number of tasks'),
                  hintText: 'Number of tasks',
                  keyboardType: TextInputType.number,
                  mycontroller: _numberOfTasks,
                ),
                const SizedBox(height: 20),
                TextFieldWidget(
                  label: const Text('Sequence of each task'),
                  hintText: 'Sequence of each task',
                  keyboardType: TextInputType.number,
                  mycontroller: _sequenceOfTasks,
                ),
                const SizedBox(height: 20),
                ButtonWidget(
                  textColor: Colors.white,
                  color: _isButtonEnabled ? Colors.teal : Colors.grey,
                  onPressed: _isButtonEnabled
                      ? () {
                          try {
                            int numberOfTasks = int.parse(_numberOfTasks.text);
                            int minutes = int.parse(_sequenceOfTasks.text);
                            int sequenceOfTasks =
                                int.parse(_sequenceOfTasks.text);

                            _startTimer(minutes);
                            BlocProvider.of<GameCubit>(context)
                                .getGameTask(numberOfTasks, sequenceOfTasks);
                            Navigator.of(context).push(MaterialPageRoute(
                              builder: (cont) => BlocProvider.value(
                                  value: BlocProvider.of<GameCubit>(context),
                                  child: GamePage(
                                    numberOfTasks: numberOfTasks,
                                    sequenceOfTasks: sequenceOfTasks,
                                  )),
                            ));
                          } catch (e) {
                            ScaffoldMessenger.of(context).showSnackBar(
                              const SnackBar(
                                content: Text('Please enter valid numbers'),
                              ),
                            );
                          }
                        }
                      : null,
                  text: 'Go',
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
