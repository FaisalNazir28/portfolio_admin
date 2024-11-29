import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:portfolio_admin/controllers/client_controller.dart';
import 'package:portfolio_admin/controllers/messages_controller.dart';
import 'package:portfolio_admin/services/firebase_options.dart';

import 'routes/routes.dart';
import 'screens/dashboard_screen/dashboard_screen.dart';
import 'screens/home_screen/home_screen.dart';
import 'screens/page_not_found_screen/page_not_found_screen.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  initializeControllers();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      title: 'Admin Dashboard',
      debugShowCheckedModeBanner: false,
      initialRoute: Routes.home,
      routes: {
        Routes.home: (context) => const HomeScreen(),
        Routes.dashboard: (context) => const DashboardScreen(),
        Routes.pageNotFound: (context) => const PageNotFound(),
      },
      onUnknownRoute: (unknownRoute) {
        return MaterialPageRoute(builder: (_) => const PageNotFound());
      },
    );
  }
}

void initializeControllers() {
  Get.lazyPut(() => MessagesController());
  Get.lazyPut(() => ClientController());
}
