import 'package:flutter/material.dart';
import 'package:ionicons/ionicons.dart';
import 'package:portfolio_admin/controllers/auth_controller.dart';
import 'package:portfolio_admin/models/user_model.dart';
import 'package:portfolio_admin/responsiveness/breakpoints.dart';
import 'package:portfolio_admin/routes/routes.dart';
import 'package:portfolio_admin/utilities/app_images.dart';
import 'package:portfolio_admin/utilities/constants.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  final _formKey = GlobalKey<FormState>();
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  bool loading = false;
  bool isError = false;

  @override
  void dispose() {
    super.dispose();
    _emailController.dispose();
    _passwordController.dispose();
  }

  @override
  Widget build(BuildContext context) {
    var isMobileScreen = Breakpoints.isSmallScreen(context);

    return Scaffold(
      backgroundColor: const Color(0xfff5f5f0),
      body: Stack(
        alignment: Alignment.bottomLeft,
        children: [
          Container(
            decoration: BoxDecoration(
              image: DecorationImage(
                image: AssetImage(AppImages.bg2),
                fit: BoxFit.cover,
                colorFilter: const ColorFilter.mode(Colors.black45, BlendMode.darken),
              ),
            ),
            child: Center(
              child: SizedBox(
                width: isMobileScreen ? 250 : 400,
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Container(
                      width: isMobileScreen ? 120 : 150,
                      height: isMobileScreen ? 120 : 150,
                      padding: const EdgeInsets.all(2),
                      decoration: const BoxDecoration(
                        color: Colors.white70,
                        shape: BoxShape.circle,
                      ),
                      child: CircleAvatar(
                        backgroundImage: AssetImage(AppImages.faisal),
                      ),
                    ),
                    const SizedBox(
                      height: 50,
                    ),
                    Form(
                      key: _formKey,
                      child: Column(
                        children: [
                          TextFormField(
                            cursorColor: Colors.white70,
                            controller: _emailController,
                            textAlign: TextAlign.center,
                            style: const TextStyle(
                              color: Colors.white,
                            ),
                            decoration: InputDecoration(
                              contentPadding: const EdgeInsets.symmetric(horizontal: 25),
                              labelText: 'Email',
                              labelStyle: const TextStyle(
                                fontSize: 16.0,
                                color: Colors.white54,
                              ),
                              border: OutlineInputBorder(borderRadius: BorderRadius.circular(100)),
                              focusedBorder: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(100),
                                borderSide: const BorderSide(color: Colors.white70, width: 2.0),
                              ),
                            ),
                            validator: (value) {
                              if (value!.isEmpty) {
                                return 'Email is missing';
                              }
                              String emailPattern = r'^[\w-\.]+@([\w-]+\.)+[\w-]{2,4}$';
                              RegExp regex = RegExp(emailPattern);
                              if (!regex.hasMatch(value)) {
                                return 'Please enter valid Email';
                              }
                              return null;
                            },
                          ),
                          const SizedBox(
                            height: 30,
                          ),
                          TextFormField(
                            cursorColor: Colors.white70,
                            controller: _passwordController,
                            obscureText: true,
                            textAlign: TextAlign.center,
                            style: const TextStyle(
                              color: Colors.white,
                            ),
                            decoration: InputDecoration(
                              contentPadding: const EdgeInsets.symmetric(horizontal: 25),
                              labelText: 'Enter your password',
                              labelStyle: const TextStyle(
                                fontSize: 16.0,
                                color: Colors.white54,
                              ),
                              border: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(100),
                              ),
                              focusedBorder: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(100),
                                borderSide: const BorderSide(color: Colors.white70, width: 2.0),
                              ),
                            ),
                            validator: (value) {
                              if (value!.isEmpty) {
                                return 'Password is missing';
                              }
                              return null;
                            },
                          ),
                          const SizedBox(height: 50),
                          InkWell(
                            onTap: loading
                                ? () {}
                                : () async {
                                    if (_formKey.currentState!.validate()) {
                                      setState(() {
                                        loading = true;
                                        AuthController().loginUser(
                                          email: _emailController.text,
                                          password: _passwordController.text,
                                          onSuccess: () {
                                            AuthController.adminModel.isAdmin == true &&
                                                    AuthController.adminModel.isActive == true
                                                ? setState(() {
                                                    Navigator.pushNamed(context, Routes.dashboard);
                                                    loading = false;
                                                    _emailController.clear();
                                                    _passwordController.clear();
                                                  })
                                                : setState(() {
                                                    loading = false;
                                                    showError();
                                                    AuthController.adminModel = AdminModel();
                                                    AuthController().logOutUser();
                                                  });
                                          },
                                          onError: () {
                                            setState(() {
                                              loading = false;
                                              showError();
                                            });
                                          },
                                        );
                                      });
                                    }
                                  },
                            child: Container(
                              padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 12),
                              decoration: BoxDecoration(
                                color: Colors.white54,
                                borderRadius: BorderRadius.circular(100),
                              ),
                              child: loading
                                  ? const SizedBox(
                                      height: 20,
                                      width: 20,
                                      child: CircularProgressIndicator(
                                        color: Colors.black,
                                        strokeWidth: 4,
                                      ),
                                    )
                                  : const Text(
                                      "Sign in",
                                      style: TextStyle(
                                        color: Colors.black,
                                        fontSize: 16,
                                      ),
                                    ),
                            ),
                          ),
                          if (isError)
                            Container(
                              margin: const EdgeInsets.only(top: 20),
                              child: const Row(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  Icon(
                                    Ionicons.alert_outline,
                                    color: Colors.white70,
                                  ),
                                  Text(
                                    "Invalid Credentials",
                                    style: TextStyle(color: Colors.white70, fontWeight: FontWeight.w500, fontSize: 16),
                                  ),
                                ],
                              ),
                            ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),
          Positioned(
            left: 5,
            bottom: 2,
            child: Text(
              AppConstants.appVersion,
              style: const TextStyle(
                fontSize: 10.0,
                fontWeight: FontWeight.w600,
                fontStyle: FontStyle.italic,
                color: Colors.white,
              ),
            ),
          ),
        ],
      ),
    );
  }

  void showError() {
    setState(() {
      isError = true;
      Future.delayed(const Duration(seconds: 3), () {
        setState(() {
          isError = false;
        });
      });
    });
  }
}
