import "package:college/controller/auth_controller.dart";
import "package:college/loader.dart";
import "package:flutter/cupertino.dart";
import "package:flutter_riverpod/flutter_riverpod.dart";
import 'package:flutter/material.dart';
import "package:routemaster/routemaster.dart";

class LoginScreen extends ConsumerStatefulWidget {
  const LoginScreen({Key? key}) : super(key: key);

  @override
  ConsumerState<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends ConsumerState<LoginScreen> {
  final _formKey = GlobalKey<FormState>();

  final _rollNoController = TextEditingController();
  final _studentPasswordController = TextEditingController();

  final _facultyEmailController = TextEditingController();
  final _facultyPasswordController = TextEditingController();

  final _adminUsernameController = TextEditingController();
  final _adminKeyController = TextEditingController();

  String selectedPanel = 'Student Panel';
  bool isStudentPanel = false;
  bool isFacultyPanel = false;
  bool isAdminPanel = false;

  @override
  void dispose() {
    _rollNoController.dispose();
    _studentPasswordController.dispose();
    _facultyEmailController.dispose();
    _facultyPasswordController.dispose();
    _adminUsernameController.dispose();
    _adminKeyController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final isLoading = ref.watch(authControllerProvider);
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          'Login',
          style: TextStyle(
            fontWeight: FontWeight.bold,
            shadows: [
              Shadow(
                blurRadius: 3.0, // Controls the glow intensity
                color: Colors.black, // Glow color
                offset: Offset(0, 0), // No offset for pure glow
              ),
            ],
          ),
        ),
        backgroundColor: Colors.blue,
        centerTitle: true,

        leading: IconButton(
          icon: const Icon(Icons.arrow_back),
          onPressed: () {
            Routemaster.of(context).push("/HomeScreen");
          },
        ),
      ),

      body: isLoading
          ? const Loader()
          : SingleChildScrollView(
              child: Column(
                children: [
                  Image.asset(
                    'assets/images/background.jpg',
                    width: 150,
                    height: 150,
                  ),
                  SizedBox(height: 20),

                  const Text(
                    "Welcome Back",
                    style: TextStyle(
                      fontSize: 26,
                      // font size (26px)
                      fontWeight: FontWeight.bold,
                      // bold text
                      color: Colors.black87,
                      // dark grey (close to black)
                      letterSpacing: 0.5,
                      // small spacing between letters
                      height: 1.2, // line height
                    ),
                  ),

                  const Text(
                    "Login to access your college portal",
                    style: TextStyle(
                      fontSize: 14,
                      // small text (text-sm in Tailwind)
                      fontWeight: FontWeight.normal,
                      // normal weight (400)
                      color: Colors.grey,
                      // Tailwind text-gray-600
                      letterSpacing: 0.25,
                      // subtle spacing for readability
                      height: 1.4, // line height for better clarity
                    ),
                  ),

                  SizedBox(height: 20),

                  Center(
                    child: SizedBox(
                      height: 400,
                      width: 350,
                      child: Card(
                        color: Colors.white,
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(16),
                        ),
                        elevation: 10,
                        child: Form(
                          key: _formKey,
                          child: ListView(
                            children: [
                              Center(
                                child: Padding(
                                  padding: const EdgeInsets.only(top: 20),
                                ),
                              ),

                              const SizedBox(height: 10),
                              Padding(
                                padding: const EdgeInsets.symmetric(
                                  horizontal: 20,
                                ),
                                child: DropdownButtonFormField<String>(
                                  value: selectedPanel,
                                  decoration: const InputDecoration(
                                    border: OutlineInputBorder(),
                                  ),
                                  items:
                                      [
                                            'Student Panel',
                                            'Faculty Panel',
                                            'Admin Panel',
                                          ]
                                          .map(
                                            (panel) => DropdownMenuItem<String>(
                                              value: panel,
                                              child: Text(panel),
                                            ),
                                          )
                                          .toList(),
                                  onChanged: (value) {
                                    setState(() {
                                      selectedPanel = value!;
                                    });
                                  },
                                ),
                              ),
                              const SizedBox(height: 30),

                              if (selectedPanel == 'Student Panel') ...[
                                Padding(
                                  padding: const EdgeInsets.symmetric(
                                    horizontal: 20,
                                  ),
                                  child: TextFormField(
                                    controller: _rollNoController,
                                    decoration: const InputDecoration(
                                      labelText: 'Roll Number',
                                      border: OutlineInputBorder(),
                                    ),
                                    validator: (value) =>
                                        value == null || value.isEmpty
                                        ? 'Enter Roll No'
                                        : null,
                                  ),
                                ),
                                const SizedBox(height: 20),
                                Padding(
                                  padding: const EdgeInsets.symmetric(
                                    horizontal: 20,
                                  ),
                                  child: TextFormField(
                                    controller: _studentPasswordController,
                                    obscureText: true,
                                    decoration: const InputDecoration(
                                      labelText: 'Password',
                                      border: OutlineInputBorder(),
                                    ),
                                    validator: (value) =>
                                        value == null || value.length < 6
                                        ? 'Enter valid password'
                                        : null,
                                  ),
                                ),
                              ] else if (selectedPanel == 'Faculty Panel') ...[
                                Padding(
                                  padding: const EdgeInsets.symmetric(
                                    horizontal: 20,
                                  ),
                                  child: TextFormField(
                                    controller: _facultyEmailController,
                                    decoration: const InputDecoration(
                                      labelText: 'Email',
                                      border: OutlineInputBorder(),
                                    ),
                                    validator: (value) =>
                                        value == null || !value.contains('@')
                                        ? 'Enter valid email'
                                        : null,
                                  ),
                                ),
                                const SizedBox(height: 20),
                                Padding(
                                  padding: const EdgeInsets.symmetric(
                                    horizontal: 20,
                                  ),
                                  child: TextFormField(
                                    controller: _facultyPasswordController,
                                    obscureText: true,
                                    decoration: const InputDecoration(
                                      labelText: 'Password',
                                      border: OutlineInputBorder(),
                                    ),
                                    validator: (value) =>
                                        value == null || value.length < 6
                                        ? 'Enter valid password'
                                        : null,
                                  ),
                                ),
                              ] else if (selectedPanel == 'Admin Panel') ...[
                                Padding(
                                  padding: const EdgeInsets.symmetric(
                                    horizontal: 20,
                                  ),
                                  child: TextFormField(
                                    controller: _adminUsernameController,
                                    decoration: const InputDecoration(
                                      labelText: 'Admin Username',
                                      border: OutlineInputBorder(),
                                    ),
                                    validator: (value) =>
                                        value == null || value.isEmpty
                                        ? 'Enter username'
                                        : null,
                                  ),
                                ),
                                const SizedBox(height: 20),
                                Padding(
                                  padding: const EdgeInsets.symmetric(
                                    horizontal: 20,
                                  ),
                                  child: TextFormField(
                                    controller: _adminKeyController,
                                    obscureText: true,
                                    decoration: const InputDecoration(
                                      labelText: 'Admin Key',
                                      border: OutlineInputBorder(),
                                    ),
                                    validator: (value) =>
                                        value == null || value.length < 6
                                        ? 'Enter valid admin key'
                                        : null,
                                  ),
                                ),
                              ],

                              SizedBox(height: 30),

                              Padding(
                                padding: const EdgeInsets.symmetric(
                                  horizontal: 20,
                                ),
                                child: ElevatedButton(
                                  onPressed: () {
                                    if (selectedPanel == 'Student Panel') {
                                      ref
                                          .watch(
                                            authControllerProvider.notifier,
                                          )
                                          .signInAsStudent(
                                            context,
                                            rollNo: _rollNoController.text
                                                .trim(),
                                            Password: _studentPasswordController
                                                .text
                                                .trim(),
                                          );
                                    }

                                    if (selectedPanel == 'Faculty Panel') {
                                      ref
                                          .watch(
                                            authControllerProvider.notifier,
                                          )
                                          .signInasFaculty(
                                            context,
                                            email: _facultyEmailController.text
                                                .trim(),
                                            password: _facultyPasswordController
                                                .text
                                                .trim(),
                                          );
                                    }

                                    if (selectedPanel == 'Admin Panel') {
                                      ref
                                          .watch(
                                            authControllerProvider.notifier,
                                          )
                                          .signInAsAdmin(
                                            context,
                                            email: _adminUsernameController.text
                                                .trim(),
                                            password: _adminKeyController.text
                                                .trim(),
                                          );
                                    }
                                  },
                                  style: ElevatedButton.styleFrom(
                                    backgroundColor: Colors.indigo,
                                    // bg-indigo-600
                                    foregroundColor: Colors.white,
                                    // text-white
                                    padding: const EdgeInsets.symmetric(
                                      vertical: 14,
                                      horizontal: 16,
                                    ),
                                    // py-3 px-4
                                    shape: RoundedRectangleBorder(
                                      borderRadius: BorderRadius.circular(
                                        12,
                                      ), // rounded-lg
                                    ),
                                    elevation: 3,
                                    // shadow-sm
                                    textStyle: const TextStyle(
                                      fontSize: 14, // text-sm
                                      fontWeight:
                                          FontWeight.w600, // font-medium
                                      letterSpacing: 0.5,
                                    ),
                                  ),
                                  child: Text('Login', style: TextStyle()),
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                    ),
                  ),

                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      const Text(
                        "Don't have an account?",
                        style: TextStyle(
                          fontSize: 14, // text-sm
                          fontWeight: FontWeight.normal,
                          color: Colors.grey, // text-gray-500
                          height: 1.4, // line spacing
                        ),
                      ),
                      TextButton(
                        onPressed: () {
                          Routemaster.of(context).push("/signUpScreen");
                        },
                        style: TextButton.styleFrom(
                          foregroundColor: Colors.indigo, // text-indigo-600
                          textStyle: const TextStyle(
                            fontSize: 14,
                            fontWeight: FontWeight.w500, // font-medium
                          ),
                        ),
                        child: const Text("Sign up"),
                      ),
                    ],
                  ),
                ],
              ),
            ),
    );
  }
}
