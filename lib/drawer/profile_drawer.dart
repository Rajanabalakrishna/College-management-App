import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:routemaster/routemaster.dart';

import '../Pallete.dart';
import '../controller/auth_controller.dart';

class ProfileDrawer extends ConsumerWidget {
  const ProfileDrawer({super.key});

  // void logOut(WidgetRef ref) {
  //   ref.read(authControllerProvider.notifier).logout();
  // }

  void navigateToUserProfile(BuildContext context) {
    Routemaster.of(context).push("/dashboard");
  }

  // void toggleTheme(WidgetRef ref) {
  //   ref.read(themeNotifierProvider.notifier).toggleTheme();
  // }

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final user = ref.watch(userProvider);

    final faculty = ref.watch(facultyProvider);
    final admin = ref.watch(adminProvider);

    // Determine who is logged in
    final bool isUser = user != null;
    final bool isFaculty = faculty != null;
    final bool isAdmin = admin != null;

    // Safely assign name and profilePic
    String name = 'Guest';
    String profilePic =
        'https://avatars.githubusercontent.com/u/91388754?v=4'; // Default fallback image

    if (isFaculty) {
      name = faculty.name;
      profilePic = faculty.profilePic ?? profilePic;
    } else if (isUser) {
      name = user.name;
      profilePic = user.profilePic ?? profilePic;
    } else if (isAdmin) {
      name = admin.adminName;
      profilePic =
          'https://static.thenounproject.com/png/5034901-200.png'; // Admin fallback avatar
    }

    return SizedBox(
      width: MediaQuery.of(context).size.width * 0.7,
      child: Drawer(
        child: Container(
          decoration: const BoxDecoration(
            gradient: LinearGradient(
              begin: Alignment.topCenter,
              end: Alignment.bottomCenter,
              colors: [
                Color(0xFF4A5FD3), // Blue-violet
                Color(0xFFB56FC6), // Purple-pink
              ],
            ),
          ),
          child: SafeArea(
            child: Column(
              children: [
                SizedBox(height: 50),
                CircleAvatar(
                  backgroundImage: NetworkImage(profilePic),
                  radius: 50,
                ),
                // const SizedBox(height: 10),
                Padding(
                  padding: const EdgeInsets.only(top: 18),
                  child: Text(
                    name,
                    style: const TextStyle(
                      fontSize: 24,
                      fontWeight: FontWeight.bold,
                      color: Colors.white,
                    ),
                  ),
                ),
                const SizedBox(height: 50),

                Padding(
                  padding: const EdgeInsets.only(left: 10),
                  child: ListTile(
                    title: const Text('My Profile'),
                    leading: const Icon(Icons.person, color: Colors.white),
                    onTap: () {
                      Routemaster.of(context).push("/dashboard");
                    },
                  ),
                ),

                Padding(
                  padding: const EdgeInsets.only(left: 10),
                  child: ListTile(
                    title: const Text('Settings'),
                    leading: Icon(Icons.settings, color: Colors.white),
                    onTap: () {},
                  ),
                ),

                Padding(
                  padding: const EdgeInsets.only(left: 10),
                  child: ListTile(
                    title: const Text('Details'),
                    leading: Icon(Icons.info, color: Colors.white),
                    onTap: () {},
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.only(left: 10),
                  child: ListTile(
                    title: const Text('Log Out'),
                    leading: Icon(Icons.logout, color: Pallete.redColor),
                    onTap: () {
                      ref
                          .watch(authControllerProvider.notifier)
                          .logout(context);

                      Routemaster.of(context).push("/HomeScreen");
                    },
                  ),
                ),

                // Switch.adaptive(
                //   value: ref.watch(themeNotifierProvider.notifier).mode == ThemeMode.dark,
                //   onChanged: (val) {},
                // ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
