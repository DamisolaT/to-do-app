import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:verraki_project1/core/customs/custom_textfield.dart';
import 'package:verraki_project1/core/utils/app_button.dart';
import 'package:verraki_project1/core/utils/constant.dart';
import 'package:verraki_project1/core/utils/images.dart';
import 'package:verraki_project1/navigators/router.dart';
import 'package:verraki_project1/views/auth/signup/sign_up.dart';
import 'package:verraki_project1/views/folder/folders_page.dart';

class LogInScreen extends StatefulWidget {
  const LogInScreen({super.key});

  @override
  State<LogInScreen> createState() => _LogInScreenState();
}

class _LogInScreenState extends State<LogInScreen> {
  final _emailController = TextEditingController();
  final _passwordController = TextEditingController();
  final _formKey = GlobalKey<FormState>();
  // final String? errorText;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: Stack(
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
              child: Form(
                key: _formKey,
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
                    Image.asset(ApppImages.logInImage, height: 200),
                    const SizedBox(height: 44),
                    CustomBorderedTextFormField(
                      title: '',
                      hintText: "Email",
                      validator: FormValidator.validateEmail,
                      inputFormatters: [
                        FilteringTextInputFormatter.allow(
                          RegExp(r'[a-zA-Z@._-]'),
                        ),
                      ],
                      controller: _emailController,
                    ),
                    const SizedBox(height: 15),
                    CustomBorderedTextFormField(
                      title: '',
                      hintText: "Password",
                      validator:
                          (value) => FormValidator.validatePassword(value),
                      obscureText: true,
                      controller: _passwordController,
                    ),
                    const SizedBox(height: 30),

                    AppButton(
                      text: 'Log In',
                      onPressed: () {
                        Navigator.of(context).push(
                          MaterialPageRoute(builder: (_) => FoldersPage()),
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
                            navigateToPage(context, SignUpScreen());
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
          ),
        ],
      ),
    );
  }
}
