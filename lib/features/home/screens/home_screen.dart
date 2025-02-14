import 'package:camera/camera.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/svg.dart';
import 'package:ramy/features/scan/presentation/screens/scan_screen.dart';
import '../../../core/constants/images.dart';
import '../../map/presentation/screens/map_page.dart';
import '../../overview/presentation/screen/dashboard_screen.dart';
import '../../profile/data/data_source/data_source.dart';
import '../../profile/data/repositories/repository_impl.dart';
import '../../profile/domain/usecases/get_profile.dart';
import '../../profile/domain/usecases/update_profile.dart';
import '../../profile/presentation/bloc/profile_bloc.dart';
import '../../profile/presentation/bloc/profile_event.dart';
import '../../profile/presentation/screens/profile_settings_screen.dart';
import '../cubit/bottom_navigation_cubit.dart';

class HomeScreen extends StatelessWidget {
  final List<CameraDescription> cameras;

  const HomeScreen({super.key, required this.cameras});

  @override
  Widget build(BuildContext context) {
    final pages = [
      DashboardScreen(cameras: cameras),
      MapScreen(),
      ScanScreen(cameras: cameras),
      BlocProvider(
        create: (_) => ProfileBloc(
          getProfile:
              GetProfile(ProfileRepositoryImpl(ProfileDataSourceImpl())),
          updateProfile:
              UpdateProfile(ProfileRepositoryImpl(ProfileDataSourceImpl())),
        )..add(LoadProfile()),
        child: const ProfileSettingsScreen(),
      ),
    ];

    return Scaffold(
      body: BlocBuilder<BottomNavigationCubit, int>(
        builder: (context, state) {
          return pages[state];
        },
      ),
      bottomNavigationBar: BlocBuilder<BottomNavigationCubit, int>(
        builder: (context, state) {
          return BottomNavigationBar(
            type: BottomNavigationBarType.fixed,
            currentIndex: state,
            onTap: (index) {
              context.read<BottomNavigationCubit>().changeTab(index);
            },
            selectedItemColor: Colors.orangeAccent,
            unselectedItemColor: Colors.grey,
            items: [
              BottomNavigationBarItem(
                icon: SvgPicture.asset(
                  Images.home,
                  color: state == 0 ? Colors.orangeAccent : Colors.grey,
                ),
                label: 'Home',
              ),
              BottomNavigationBarItem(
                icon: SvgPicture.asset(
                  Images.route,
                  color: state == 1 ? Colors.orangeAccent : Colors.grey,
                ),
                label: 'Route',
              ),
              BottomNavigationBarItem(
                icon: SvgPicture.asset(
                  Images.scan,
                  color: state == 2 ? Colors.orangeAccent : Colors.grey,
                  height: 30,
                ),
                label: 'Scan',
              ),
              BottomNavigationBarItem(
                icon: SvgPicture.asset(
                  Images.profile,
                  color: state == 3 ? Colors.orangeAccent : Colors.grey,
                ),
                label: 'Profile',
              ),
            ],
          );
        },
      ),
    );
  }
}
