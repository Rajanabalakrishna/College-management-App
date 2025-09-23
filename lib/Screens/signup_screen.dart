import 'dart:io';
import 'dart:math';

import 'package:college/constants/constants.dart';
import 'package:college/controller/auth_controller.dart';
import 'package:college/loader.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:image_picker/image_picker.dart';
import 'package:permission_handler/permission_handler.dart';

import 'materials_Screen.dart';

class SignupPage extends ConsumerStatefulWidget {
  const SignupPage({Key? key}) : super(key: key);

  @override
  ConsumerState<SignupPage> createState() => _SignupPageState();
}

class _SignupPageState extends ConsumerState<SignupPage> {
  final _formkey = GlobalKey<FormState>();

  final _nameController = TextEditingController();
  final _rollController = TextEditingController();
  final _emailController = TextEditingController();
  final _passwordController = TextEditingController();
  bool _obscurePassword = true;

  File? _profileImage;
  ImagePicker _picker = ImagePicker();

  Future<void> pickImage() async {
    final status = await Permission.photos.request();
    if (!status.isGranted) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text("Gallery Permission denied")),
      );
      return;
    }
    final pickedFile = await _picker.pickImage(source: ImageSource.gallery);
    if (pickedFile == null) return;
    setState(() {
      _profileImage = File(pickedFile.path);
    });
  }

  void submit() {
    if (!_formkey.currentState!.validate()) return;

    final name = _nameController.text.trim();
    final rollNo = _rollController.text.trim();
    final email = _emailController.text.trim();
    final password = _passwordController.text.trim();
    //ou can make a phone field if needed

    ref.watch(authControllerProvider.notifier).signUpUser(name: name,
        rollNo: rollNo,
        email: email,
        password: password,
        profileImage: _profileImage,
        context: context);
  }

  @override
  void dispose() {
    _nameController.dispose();
    _rollController.dispose();
    _emailController.dispose();
    _passwordController.dispose();
    super.dispose();
  }


  @override
  Widget build(BuildContext context) {
    final isLoading = ref.watch(authControllerProvider);
    return Scaffold(
      backgroundColor: Colors.grey[100],
      appBar: AppBar(
        title: Text("Sign Up"),
        centerTitle: true,
        backgroundColor: Colors.blue,
      ),

      body: isLoading?const Loader():Center(
        child: Padding(
          padding: const EdgeInsets.only(bottom: 60, left: 20, right: 20),
          child: SingleChildScrollView(
            child: SizedBox(
              width: 350,
              height: 700,
              child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 10),
                child: Container(
                  width: double.infinity,
                  padding: const EdgeInsets.all(24),
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(24),
                    boxShadow: [
                      BoxShadow(
                        color: Colors.black.withOpacity(0.1),
                        blurRadius: 8,
                        offset: const Offset(0, 4),
                      ),
                    ],
                  ),

                  child: Form(
                    key: _formkey,
                    child: Column(
                      children: [
                        Padding(
                          padding: const EdgeInsets.only(top: 20),
                          child: Text(
                            "Create Account",
                            style: TextStyle(
                              fontSize: 32,
                              fontWeight: FontWeight.bold,
                              shadows: [
                                Shadow(
                                  blurRadius: 5.0, // Controls the glow intensity
                                  color: Colors.black, // Glow color
                                  offset: Offset(0, 0), // No offset for pure glow
                                ),
                              ],
                            ),
                          ),
                        ),

                        SizedBox(height: 50),

                        GestureDetector(
                          onTap: () {
                            pickImage();
                          },
                          child: CircleAvatar(
                            radius: 48,
                            backgroundColor: Colors.grey[300],
                            backgroundImage: _profileImage != null
                                ? FileImage(_profileImage!)
                                : NetworkImage("https://lh3.googleusercontent.com/aida-public/AB6AXuD627ESk5F8DJmRJ-lJlDnyAZ68iN4aryI7WI8UfHbl69fy3hMnIe-Vj80c810OCu8-xQMzHZHVWfIp4KbUe8O9fs9sktDGFA9PO0dKH4zTBn98cP5qW8GozHBq4IzVwlJeCymbJ5z4bzUqeETns0ExO6_WWijStOGRQxTwXwmxKvV7B-IksyesTwataFggBB7Zqyk_dgLIGNKp-WU-hg4BpjRuIl13sZOOcKdsHGb45siCyaauJ-jbAH-srrz-Mqlzw26Zr2rRUNs",)
                            as ImageProvider,
                          ),
                        ),

                        SizedBox(height: 20),

                        Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 20),
                          child: TextFormField(
                            controller: _nameController,
                            decoration: InputDecoration(
                              labelText: "Full name",
                              border: OutlineInputBorder(),
                            ),

                            validator: (value) =>
                            value == null || value
                                .trim()
                                .isEmpty
                                ? "Name is required"
                                : null,
                          ),
                        ),

                        const SizedBox(height: 24),

                        Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 20),
                          child: TextFormField(
                            controller: _rollController,
                            decoration: InputDecoration(
                              labelText: "Roll No",
                              border: OutlineInputBorder(),
                            ),

                            validator: (value) =>
                            value == null || value
                                .trim()
                                .isEmpty
                                ? "Roll no is required"
                                : null,
                          ),
                        ),

                        const SizedBox(height: 24),

                        Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 20),
                          child: TextFormField(
                            controller: _emailController,
                            decoration: InputDecoration(
                              labelText: "E-mail",
                              border: OutlineInputBorder(),
                            ),

                            validator: (value) {
                              if (value == null || value
                                  .trim()
                                  .isEmpty)
                                return "Email is required";
                              final emailRegex = RegExp(
                                r'^[\w-\.]+@([\w-]+\.)+[\w-]{2,4}$',
                              );
                              if (!emailRegex.hasMatch(value))
                                return "Enter a valid email";
                              return null;
                            },
                          ),
                        ),
                        const SizedBox(height: 24),

                        Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 20),
                          child: TextFormField(
                            controller: _passwordController,
                            obscureText: _obscurePassword,
                            decoration: InputDecoration(
                              labelText: "Password (min 8 chars)",
                              border: OutlineInputBorder(),
                              suffixIcon: IconButton(
                                onPressed: () {
                                  setState(() {
                                    _obscurePassword = !_obscurePassword;
                                  });
                                },
                                icon: Icon(
                                  _obscurePassword
                                      ? Icons.visibility_off
                                      : Icons.visibility,
                                ),
                              ),
                            ),
                            validator: (value) {
                              if (value == null || value.isEmpty)
                                return "Password is required";
                              if (value.length < 8)
                                return "Password must be at least 8 characters";
                              return null;
                            },
                          ),
                        ),

                        const SizedBox(height: 24),

                        Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: SizedBox(
                            width: double.infinity,
                            child: ElevatedButton(
                              style: ElevatedButton.styleFrom(
                                padding: const EdgeInsets.symmetric(
                                  vertical: 16,
                                ),
                                backgroundColor: Colors.blue,
                                foregroundColor: Colors.white,
                              ),
                              onPressed: submit,
                              child: Text("Signup"),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
