import 'package:flutter/material.dart';
import 'package:portfolio_admin/screens/protected_screen.dart';

class DashboardScreen extends StatefulWidget {
  const DashboardScreen({super.key});

  @override
  State<DashboardScreen> createState() => _DashboardScreenState();
}

class _DashboardScreenState extends State<DashboardScreen> {
  @override
  Widget build(BuildContext context) {
    return const ProtectedScreen(
      child: Placeholder(),
    );
  }
}
