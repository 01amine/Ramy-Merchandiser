import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/svg.dart';
import 'package:ramy/features/overview/presentation/screen/overview_screen.dart';
import '../../../core/constants/images.dart';
import '../../map/presentation/bloc/map_bloc.dart';
import '../../map/presentation/screens/map_page.dart';
import '../../profile/data/data_source/data_source.dart';
import '../../profile/data/repositories/repository_impl.dart';
import '../../profile/domain/usecases/get_profile.dart';
import '../../profile/domain/usecases/update_profile.dart';
import '../../profile/presentation/bloc/profile_bloc.dart';
import '../../profile/presentation/bloc/profile_event.dart';
import '../../profile/presentation/screens/profile_settings_screen.dart';
import '../cubit/bottom_navigation_cubit.dart';

class HomeScreen extends StatelessWidget {
  final List<Widget> _pages = [
    ProgressScreen(),
    BlocProvider(
      create: (context) => MapBloc(),
      child: MapScreen(),
    ),
    Scaffold(body: Center(child: Text('Scan'))),
    BlocProvider(
      create: (_) => ProfileBloc(
        getProfile: GetProfile(ProfileRepositoryImpl(ProfileDataSourceImpl())),
        updateProfile:
            UpdateProfile(ProfileRepositoryImpl(ProfileDataSourceImpl())),
      )..add(LoadProfile()),
      child: const ProfileSettingsScreen(),
    ),
  ];

  HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: BlocBuilder<BottomNavigationCubit, int>(
        builder: (context, state) {
          return _pages[state];
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
