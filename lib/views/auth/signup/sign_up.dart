import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

import 'package:verraki_project1/core/customs/custom_textfield.dart';
import 'package:verraki_project1/core/customs/page_wrapper.dart';
import 'package:verraki_project1/core/utils/app_button.dart';
import 'package:verraki_project1/core/utils/constant.dart';

import 'package:verraki_project1/navigators/router.dart';
import 'package:verraki_project1/views/auth/firebase_auth_impl/firebase_auth_service.dart';
import 'package:verraki_project1/views/auth/login/log_in.dart';
import 'package:verraki_project1/views/folder/folder_pages/folders_page.dart';

class SignUpScreen extends StatefulWidget {
  const SignUpScreen({super.key});

  @override
  State<SignUpScreen> createState() => _SignUpScreenState();
}

class _SignUpScreenState extends State<SignUpScreen> {
  final FirebaseAuthServices _auth = FirebaseAuthServices();

  final _nameController = TextEditingController();
  final _emailController = TextEditingController();
  final _passwordController = TextEditingController();
  final _comfirmPasswordController = TextEditingController();
  // final _confirmController = TextEditingController();

  final _formKey = GlobalKey<FormState>();
  @override
  Widget build(BuildContext context) {
    return PageWrapper(
      child: Form(
        key: _formKey,
        child: Stack(
          children: [
            Positioned(
              top: -40,
              left: -40,
              child: Container(
                width: 150,
                height: 150,
                decoration: BoxDecoration(
                  color: Colors.blue.shade100,
                  shape: BoxShape.circle,
                ),
              ),
            ),
            Positioned(
              top: 20,
              left: 80,
              child: Container(
                width: 100,
                height: 100,
                decoration: BoxDecoration(
                  color: Colors.blue,
                  shape: BoxShape.circle,
                ),
              ),
            ),
            Center(
              child: SingleChildScrollView(
                padding: const EdgeInsets.symmetric(horizontal: 24),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  children: [
                    const SizedBox(height: 50),
                    const Text(
                      'Welcome Onboard!',
                      textAlign: TextAlign.center,
                      style: TextStyle(
                        fontSize: 20,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    const SizedBox(height: 10),
                    const Text(
                      'Let’s help you meet your tasks',
                      textAlign: TextAlign.center,
                      style: TextStyle(fontSize: 14, color: Colors.grey),
                    ),
                    const SizedBox(height: 40),
                    CustomBorderedTextFormField(
                      title: '',
                      hintText: "Enter your full name",

                      controller: _nameController,
                    ),
                    const SizedBox(height: 15),
                    CustomBorderedTextFormField(
                      title: '',
                      hintText: "Enter your email",
                      validator: FormValidator.validateEmail,

                      controller: _emailController,
                    ),
                    const SizedBox(height: 15),
                    CustomBorderedTextFormField(
                      title: '',
                      hintText: "Enter password",
                      validator:
                          (value) => FormValidator.validatePassword(value),
                      obscureText: true,

                      controller: _passwordController,
                    ),
                    const SizedBox(height: 15),
                    CustomBorderedTextFormField(
                      title: '',
                      hintText: "Confirm password",
                      validator:
                          (value) => FormValidator.validatePassword(value),
                      obscureText: true,

                      controller: _comfirmPasswordController,
                    ),
                    const SizedBox(height: 30),
                    AppButton(text: 'Register', onPressed: _signUp),
                    const SizedBox(height: 20),

                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        const Text(
                          "Already have an account? ",
                          style: TextStyle(fontSize: 14),
                        ),
                        GestureDetector(
                          onTap: () {
                            navigateToPage(context, LogInScreen());
                          },
                          child: const Text(
                            "Sign In",
                            style: TextStyle(
                              color: Colors.blue,
                              fontWeight: FontWeight.bold,
                              fontSize: 14,
                            ),
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  // ignore: unused_element
  void _signUp() async {
    // ignore: unused_local_variable
    String name = _nameController.text.trim();
    String email = _emailController.text.trim();
    String password = _passwordController.text.trim();
    // ignore: unused_local_variable
    String comfirm = _comfirmPasswordController.text.trim();

    if (_formKey.currentState!.validate()) {
      User? user = await _auth.signUpWithEmailAndPassword(email, password);

      if (!mounted) return;

      if (user != null) {
        Navigator.pushReplacement(
          context,
          MaterialPageRoute(builder: (context) => const FoldersPage()),
        );
      } else {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(content: Text('Registration failed. Try again.')),
        );
      }
    }
  }
}
