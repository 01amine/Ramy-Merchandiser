import 'package:camera/camera.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:ramy/shared/utils/dep_inj.dart';
import 'features/home/cubit/bottom_navigation_cubit.dart';
import 'features/home/screens/home_screen.dart';

void main() async{
  DepInj.init();
  WidgetsFlutterBinding.ensureInitialized();
  final cameras = await availableCameras();
  runApp(MyApp(cameras: cameras));
}

class MyApp extends StatelessWidget {
  final List<CameraDescription> cameras;
   MyApp({super.key, required this.cameras});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: BlocProvider(
          create: (_) => BottomNavigationCubit(), child: HomeScreen(cameras: cameras)),
    );
  }
}
