import 'package:flutter/material.dart';
import 'package:flutter_application_test/features/home/presentation/cubit/add_to_card_cubit/add_to_cart_cubit.dart';
import 'package:flutter_application_test/features/home/presentation/screens/main_home_page.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'injection_container.dart' as di;

void main() async {
  await di.init();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => di.sl<AddToCartCubit>(),
      child: const MaterialApp(
        debugShowCheckedModeBanner: false,
        home: MainPage(),
      ),
    );
  }
}
