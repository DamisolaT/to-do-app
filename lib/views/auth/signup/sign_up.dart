import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:verraki_project1/core/customs/custom_textfield.dart';
import 'package:verraki_project1/core/customs/page_wrapper.dart';
import 'package:verraki_project1/core/utils/app_button.dart';
import 'package:verraki_project1/core/utils/constant.dart';
import 'package:verraki_project1/core/utils/custom_text.dart';
import 'package:verraki_project1/navigators/router.dart';
import 'package:verraki_project1/views/auth/login/log_in.dart';

class SignUpScreen extends StatefulWidget {
  const SignUpScreen({super.key});

  @override
  State<SignUpScreen> createState() => _SignUpScreenState();
}

class _SignUpScreenState extends State<SignUpScreen> {
  final _nameController = TextEditingController();

  final _emailController = TextEditingController();
  final _passwordController = TextEditingController();
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
                    CustomTextField(
                      controller: _nameController,
                      hintText: "Enter your full name",
                      isObscureText: false,
                      inputFormatter: [],
                      contentPadding: EdgeInsets.symmetric(
                        vertical: 20,
                        horizontal: 16,
                      ),
                    ),
                    const SizedBox(height: 15),
                    CustomTextField(
                      controller: _emailController,
                      hintText: "Enter your email",
                      isObscureText: false,
                      inputFormatter: [
                        FilteringTextInputFormatter.allow(
                          RegExp(r'[a-zA-Z@._-]'),
                        ),
                      ],
                      validator: FormValidator.validateEmail,
                      contentPadding: EdgeInsets.symmetric(
                        vertical: 20,
                        horizontal: 16,
                      ),
                    ),
                    const SizedBox(height: 15),
                    CustomTextField(
                      controller: _passwordController,
                      hintText: "Enter password",
                      isObscureText: true,
                      contentPadding: EdgeInsets.symmetric(
                        vertical: 20,
                        horizontal: 16,
                      ),
                      inputFormatter: [
                        FilteringTextInputFormatter.deny(RegExp(r' ')),
                      ],
                      validator: FormValidator.validatePassword,
                    ),
                    const SizedBox(height: 15),
                    CustomTextField(
                      controller: _passwordController,
                      hintText: "Confirm password",
                      isObscureText: true,
                      contentPadding: EdgeInsets.symmetric(
                        vertical: 20,
                        horizontal: 16,
                      ),
                      inputFormatter: [
                        FilteringTextInputFormatter.deny(RegExp(r' ')),
                      ],
                      validator: FormValidator.validatePassword,
                    ),
                    const SizedBox(height: 30),
                    AppButton(
                      text: 'Register',
                      onPressed: () {
                        Navigator.of(context).push(
                          MaterialPageRoute(builder: (_) => LogInScreen()),
                        );
                      },
                    ),
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
}
