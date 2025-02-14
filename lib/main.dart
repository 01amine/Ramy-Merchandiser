import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:ramy/shared/utils/dep_inj.dart';
import 'features/home/cubit/bottom_navigation_cubit.dart';
import 'features/home/screens/home_screen.dart';

void main() {
  DepInj.init();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: BlocProvider(
          create: (_) => BottomNavigationCubit(), child: HomeScreen()),
    );
  }
}
