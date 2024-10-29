import 'package:flutter/material.dart';
import 'package:portfolio_admin/controllers/auth_controller.dart';
import 'package:portfolio_admin/screens/home_screen/home_screen.dart';

class ProtectedScreen extends StatefulWidget {
  final Widget child;

  const ProtectedScreen({super.key, required this.child});

  @override
  State<ProtectedScreen> createState() => _ProtectedScreenState();
}

class _ProtectedScreenState extends State<ProtectedScreen> {
  @override
  Widget build(BuildContext context) {
    return AuthController().userState() == true && AuthController.userModel.isAdmin == true
        ? Scaffold(
            body: widget.child,
          )
        : const HomeScreen();
  }
}
