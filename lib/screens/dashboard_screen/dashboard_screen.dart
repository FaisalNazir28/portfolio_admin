import 'package:flutter/material.dart';
import 'package:ionicons/ionicons.dart';
import 'package:portfolio_admin/controllers/dashboard_controller.dart';
import 'package:portfolio_admin/screens/chats_screen/chats_view.dart';
import 'package:portfolio_admin/screens/clients_screen/clients_view.dart';
import 'package:portfolio_admin/screens/orders_screen/orders_view.dart';
import 'package:portfolio_admin/screens/payments_screen/payments_view.dart';
import 'package:portfolio_admin/screens/projects_screen/projects_view.dart';
import 'package:portfolio_admin/screens/protected_screen.dart';
import 'package:portfolio_admin/screens/stats_screen/stats_view.dart';
import 'package:portfolio_admin/utilities/app_images.dart';

import 'dashboard_view.dart';

class DashboardScreen extends StatefulWidget {
  const DashboardScreen({super.key});

  @override
  State<DashboardScreen> createState() => _DashboardScreenState();
}

class _DashboardScreenState extends State<DashboardScreen> {
  @override
  Widget build(BuildContext context) {
    return ProtectedScreen(
      child: Container(
        color: const Color(0xfff3f5eb),
        padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 20),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Container(
                  padding:
                      const EdgeInsets.symmetric(horizontal: 22, vertical: 15),
                  child: const Icon(
                    Ionicons.prism_outline,
                    size: 30,
                  ),
                ),
                const SizedBox(
                  width: 20,
                ),
                Expanded(
                  child: Row(
                    mainAxisSize: MainAxisSize.min,
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Column(
                        mainAxisSize: MainAxisSize.min,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        mainAxisAlignment: MainAxisAlignment.start,
                        children: [
                          Text(
                            DashboardController.selectedView.name,
                            style: const TextStyle(fontSize: 35),
                          ),
                          Row(
                            mainAxisSize: MainAxisSize.min,
                            mainAxisAlignment: MainAxisAlignment.start,
                            children: [
                              const Row(
                                mainAxisSize: MainAxisSize.min,
                                mainAxisAlignment: MainAxisAlignment.start,
                                children: [
                                  Icon(
                                    Ionicons.folder_open_outline,
                                    size: 17,
                                  ),
                                  SizedBox(
                                    width: 8,
                                  ),
                                  Text(
                                    'Home',
                                    style: TextStyle(
                                        fontSize: 13, color: Colors.black87),
                                  ),
                                ],
                              ),
                              const Text(
                                '   /   ',
                                style: TextStyle(
                                    fontSize: 18, color: Colors.black54),
                              ),
                              Row(
                                mainAxisSize: MainAxisSize.min,
                                mainAxisAlignment: MainAxisAlignment.start,
                                children: [
                                  const Icon(
                                    Ionicons.folder_open_outline,
                                    size: 17,
                                  ),
                                  const SizedBox(
                                    width: 8,
                                  ),
                                  Text(
                                    DashboardController.selectedView.name,
                                    style: const TextStyle(
                                        fontSize: 13, color: Colors.black87),
                                  ),
                                ],
                              ),
                            ],
                          )
                        ],
                      ),
                      CircleAvatar(
                        radius: 20,
                        backgroundImage: AssetImage(AppImages.faisal),
                      ),
                    ],
                  ),
                ),
              ],
            ),
            const SizedBox(
              height: 50,
            ),
            Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Container(
                  decoration: BoxDecoration(
                    color: Colors.black,
                    borderRadius: BorderRadius.circular(25),
                  ),
                  padding: const EdgeInsets.all(15),
                  child: Column(
                    children: [
                      menuItems(
                          icon: Ionicons.pie_chart_outline,
                          view: Views.Dashboard),
                      menuItems(
                          icon: Ionicons.filter_outline, view: Views.Stats),
                      menuItems(
                          icon: Ionicons.cube_outline, view: Views.Orders),
                      menuItems(
                          icon: Ionicons.person_outline, view: Views.Clients),
                      menuItems(
                          icon: Ionicons.book_outline, view: Views.Projects),
                      menuItems(
                        icon: Ionicons.card_outline,
                        view: Views.Payments,
                      ),
                      menuItems(
                        icon: Ionicons.mail_outline,
                        view: Views.Chats,
                        isLast: true,
                      ),
                    ],
                  ),
                ),
                const SizedBox(
                  width: 20,
                ),
                Expanded(child: selectedView()),
              ],
            ),
          ],
        ),
      ),
    );
  }

  Widget menuItems(
      {required IconData icon, required Views view, bool isLast = false}) {
    return InkWell(
      overlayColor: WidgetStateProperty.all(Colors.transparent),
      onTap: () {
        setState(() {
          DashboardController.selectedView = view;
        });
      },
      child: Tooltip(
        preferBelow: false,
        padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 6),
        margin: const EdgeInsets.only(top: 130, left: 100),
        decoration: BoxDecoration(
          color: Colors.black,
          borderRadius: BorderRadius.circular(8),
        ),
        message: view.name,
        child: Container(
          margin: isLast ? null : const EdgeInsets.only(bottom: 30),
          padding: const EdgeInsets.all(10),
          decoration: BoxDecoration(
            color: view == DashboardController.selectedView
                ? Colors.greenAccent
                : Colors.transparent,
            borderRadius: BorderRadius.circular(15),
          ),
          child: Icon(
            icon,
            color: view == DashboardController.selectedView
                ? Colors.black
                : Colors.white,
          ),
        ),
      ),
    );
  }

  Widget selectedView() {
    switch (DashboardController.selectedView) {
      case Views.Dashboard:
        return const DashboardView();
      case Views.Stats:
        return const StatsView();
      case Views.Orders:
        return const OrdersView();
      case Views.Clients:
        return const ClientsView();
      case Views.Projects:
        return const ProjectsView();
      case Views.Payments:
        return const PaymentsView();
      case Views.Chats:
        return const ChatsView();
      default:
        return const DashboardView();
    }
  }
}