import "package:college/constants/constants.dart";
import "package:college/drawer/profile_drawer.dart";
import "package:flutter/material.dart";
import "package:flutter_riverpod/flutter_riverpod.dart";
import "package:routemaster/routemaster.dart";
import "package:url_launcher/url_launcher.dart";

import "../controller/auth_controller.dart";
import "../posts/Feed_Screen.dart";
import "links_Screen.dart";
import "posts_screen.dart"; // <-- import your posts screen

class HomeScreen extends ConsumerStatefulWidget {
  const HomeScreen({super.key});

  @override
  ConsumerState<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends ConsumerState<HomeScreen> {
  int _page = 0;

  final List<Widget> _pages = [
    const HomeContent(), // extracted Home body
    const PostsScreen(), // your Posts screen
  ];

  Future<void> launchURL(String url) async {
    final Uri uri = Uri.parse(url);
    if (!await launchUrl(uri, mode: LaunchMode.externalApplication)) {
      throw 'Could not launch $url';
    }
  }

  void onPageChanged(int page) {
    setState(() {
      _page = page;
    });
  }

  @override
  Widget build(BuildContext context) {
    final userModel = ref.watch(userProvider);
    final facultyModel = ref.watch(facultyProvider);
    final adminPanel = ref.watch(adminProvider);

    final bool isLoggedIn =
        userModel != null || facultyModel != null || adminPanel != null;

    return Scaffold(
      backgroundColor: Colors.grey.shade100,
      appBar: AppBar(
        leading: Builder(
          builder: (context) {
            return IconButton(
              onPressed: () {
                Scaffold.of(context).openDrawer();
              },
              icon: isLoggedIn ? const Icon(Icons.menu) : const SizedBox(),
            );
          },
        ),
        title: const Text(
          "SSCE",
          style: TextStyle(fontWeight: FontWeight.bold),
        ),
        actions: [
          isLoggedIn
              ? const Padding(
            padding: EdgeInsets.only(right: 20),
            child: CircleAvatar(
              backgroundColor: Colors.white,
              radius: 20,
              child: Icon(Icons.person, size: 28),
            ),
          )
              : TextButton(
            onPressed: () {
              Routemaster.of(context).push("/signUpScreen");
            },
            child: const Text(
              "Signup",
              style: TextStyle(
                color: Colors.white,
                fontWeight: FontWeight.bold,
              ),
            ),
          ),
          isLoggedIn
              ? const SizedBox()
              : TextButton(
            onPressed: () {
              Routemaster.of(context).push("/LoginScreen");
            },
            child: const Text(
              "Login",
              style: TextStyle(
                color: Colors.white,
                fontWeight: FontWeight.bold,
              ),
            ),
          ),
        ],
      ),
      drawer: const ProfileDrawer(),
      body: _pages[_page], // <-- Switches between Home and Posts
      bottomNavigationBar: BottomNavigationBar(
        currentIndex: _page,
        onTap: onPageChanged,
        selectedItemColor: Colors.blue,
        unselectedItemColor: Colors.grey,
        items: const [
          BottomNavigationBarItem(icon: Icon(Icons.home), label: "Home"),
          BottomNavigationBarItem(icon: Icon(Icons.article), label: "Posts"),
        ],
      ),
    );
  }
}

/// Separated out Home body into its own widget
class HomeContent extends StatelessWidget {
  const HomeContent({super.key});

  void navigateToMaterialsScreen(BuildContext context) {
    Routemaster.of(context).push("/DepartmentScreen");
  }

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Column(
        children: [
          const Padding(
            padding: EdgeInsets.only(top: 30),
            child: links(),
          ),
          Padding(
            padding: const EdgeInsets.all(16.0),
            child: GridView.count(
              crossAxisCount: 3,
              mainAxisSpacing: 8,
              crossAxisSpacing: 8,
              shrinkWrap: true,
              physics: const NeverScrollableScrollPhysics(),
              childAspectRatio: 0.7,
              children: [
                HomeCardItem(
                  title: "Time Table",
                  icon: Icons.schedule,
                  color: Colors.blue,
                  onTap: () {},
                ),
                HomeCardItem(
                  title: "Materials",
                  icon: Icons.menu_book,
                  color: Colors.green,
                  onTap: () {
                    navigateToMaterialsScreen(context);
                  },
                ),
                HomeCardItem(
                  title: "Assignments",
                  icon: Icons.assignment,
                  color: Colors.amber,
                  onTap: () {},
                ),
                HomeCardItem(
                  title: "Fee Payment",
                  icon: Icons.payment,
                  color: Colors.red,
                  onTap: () {
                    Routemaster.of(context).push("/feesScreen");
                  },
                ),
                HomeCardItem(
                  title: "About",
                  icon: Icons.info,
                  color: Colors.indigo,
                  onTap: () {},
                ),
                HomeCardItem(
                  title: "Complaint Box",
                  icon: Icons.report_problem,
                  color: Colors.purple,
                  onTap: () {},
                ),
                HomeCardItem(
                  title: "Events",
                  icon: Icons.event,
                  color: Colors.teal,
                  onTap: () {
                    Routemaster.of(context).push("/uploadScreen");
                  },
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

/// Reusable widget for each card
class HomeCardItem extends StatelessWidget {
  final String title;
  final IconData icon;
  final Color color;
  final VoidCallback onTap;

  const HomeCardItem({
    super.key,
    required this.title,
    required this.icon,
    required this.color,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return Card(
      color: Colors.white,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
      elevation: 5,
      child: InkWell(
        borderRadius: BorderRadius.circular(12),
        onTap: onTap,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            CircleAvatar(
              radius: 32,
              backgroundColor: color.withOpacity(0.1),
              child: Icon(icon, color: color, size: 28),
            ),
            const SizedBox(height: 8),
            Flexible(
              child: Text(
                title,
                textAlign: TextAlign.center,
                style: const TextStyle(
                  fontWeight: FontWeight.bold,
                  fontSize: 15,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
