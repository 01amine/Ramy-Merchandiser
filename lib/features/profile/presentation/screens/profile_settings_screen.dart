import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../bloc/profile_bloc.dart';
import '../bloc/profile_state.dart';
import '../../domain/entities/profile.dart';

class ProfileSettingsScreen extends StatelessWidget {
  final Profile profile;
  final void Function(Profile) onProfileUpdate;

  const ProfileSettingsScreen({
    super.key,
    required this.profile,
    required this.onProfileUpdate,
  });

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: BlocBuilder<ProfileBloc, ProfileState>(
        builder: (context, state) {
          if (state is ProfileLoaded) {
            return _buildProfileForm(context, state.profile);
          } else if (state is ProfileError) {
            return Center(child: Text(state.message));
          }
          return Container();
        },
      ),
    );
  }

  Widget _buildProfileForm(BuildContext context, Profile profile) {
    final nameController = TextEditingController(text: profile.name);
    final emailController = TextEditingController(text: profile.email);

    return Padding(
      padding: const EdgeInsets.all(16.0),
      child: ListView(
        children: [
          Center(
            child: CircleAvatar(
              radius: 50,
              backgroundImage: NetworkImage(profile.profilePictureUrl),
            ),
          ),
          const SizedBox(height: 20),
          TextField(
            controller: nameController,
            decoration: const InputDecoration(
              labelText: 'Name',
              border: OutlineInputBorder(),
            ),
          ),
          const SizedBox(height: 20),
          TextField(
            controller: emailController,
            decoration: const InputDecoration(
              labelText: 'Email',
              border: OutlineInputBorder(),
            ),
          ),
          const SizedBox(height: 20),
          ElevatedButton(
            onPressed: () {
              final updatedProfile = profile.copyWith(
                name: nameController.text,
                email: emailController.text,
              );
              onProfileUpdate(updatedProfile);
            },
            child: const Text('Save Changes'),
          ),
        ],
      ),
    );
  }
}
