import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:ionicons/ionicons.dart';
import 'package:portfolio_admin/controllers/client_controller.dart';
import 'package:portfolio_admin/controllers/projects_controller.dart';
import 'package:portfolio_admin/screens/clients_screen/add_new_client.dart';
import 'package:portfolio_admin/screens/clients_screen/client_details_view.dart';
import 'package:portfolio_admin/utilities/custom_dialog_box.dart';

class ClientsView extends StatefulWidget {
  const ClientsView({super.key});

  @override
  State<ClientsView> createState() => _ClientsViewState();
}

class _ClientsViewState extends State<ClientsView> {
  bool newClientView = false;
  bool newProjectView = false;
  bool clientDetailsView = false;

  int? selectedProjectIndex;

  final clientController = Get.find<ClientController>();
  final projectsController = Get.find<ProjectsController>();

  @override
  Widget build(BuildContext context) {
    return Obx(() {
      return Stack(
        alignment: Alignment.topLeft,
        children: [
          if (!newClientView && !clientDetailsView)
            Row(
              mainAxisSize: MainAxisSize.min,
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Expanded(
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.start,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Column(
                        mainAxisAlignment: MainAxisAlignment.start,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Container(
                            constraints: BoxConstraints(
                              maxHeight: MediaQuery.of(context).size.height * 0.82,
                            ),
                            child: GridView.builder(
                              gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                                crossAxisCount: 4,
                                crossAxisSpacing: 25,
                                mainAxisSpacing: 25,
                                childAspectRatio: 1.4775,
                              ),
                              itemCount: clientController.allClients.length,
                              itemBuilder: (context, index) {
                                var clientsProject = projectsController.allProjects
                                    .where((project) =>
                                        project.clientUID.toString().toLowerCase() ==
                                        clientController.allClients[index].uid.toLowerCase())
                                    .toList();
                                return Obx(() {
                                  return InkWell(
                                    overlayColor: WidgetStateProperty.all(Colors.transparent),
                                    onTap: () => setState(() {
                                      selectedProjectIndex = index;
                                      clientDetailsView = true;
                                    }),
                                    child: Container(
                                      decoration: BoxDecoration(
                                        borderRadius: BorderRadius.circular(15),
                                        border: Border.all(color: Colors.black45, width: 1),
                                      ),
                                      padding: const EdgeInsets.all(20),
                                      child: Column(
                                        mainAxisSize: MainAxisSize.min,
                                        crossAxisAlignment: CrossAxisAlignment.end,
                                        children: [
                                          Row(
                                            mainAxisAlignment: MainAxisAlignment.start,
                                            children: [
                                              CircleAvatar(
                                                radius: 30,
                                                backgroundImage:
                                                    NetworkImage(clientController.allClients[index].profilePicture),
                                              ),
                                              const SizedBox(
                                                width: 20,
                                              ),
                                              Column(
                                                crossAxisAlignment: CrossAxisAlignment.start,
                                                children: [
                                                  Row(
                                                    mainAxisSize: MainAxisSize.min,
                                                    mainAxisAlignment: MainAxisAlignment.start,
                                                    children: [
                                                      Text(
                                                        clientController.allClients[index].name,
                                                        style:
                                                            const TextStyle(fontSize: 18, fontWeight: FontWeight.w500),
                                                      ),
                                                      const SizedBox(width: 5),
                                                      if (clientController.allClients[index].isAdmin)
                                                        const Icon(
                                                          CupertinoIcons.checkmark_shield_fill,
                                                          size: 22,
                                                          color: Colors.blueAccent,
                                                        )
                                                    ],
                                                  ),
                                                  const SizedBox(
                                                    height: 5,
                                                  ),
                                                  Text(
                                                    clientController.allClients[index].email,
                                                    style: const TextStyle(fontSize: 12),
                                                  ),
                                                ],
                                              ),
                                            ],
                                          ),
                                          const SizedBox(height: 15),
                                          Row(
                                            mainAxisSize: MainAxisSize.min,
                                            children: [
                                              Container(
                                                width: 8,
                                                height: 8,
                                                decoration: BoxDecoration(
                                                  shape: BoxShape.circle,
                                                  color: clientController.allClients[index].isActive
                                                      ? Colors.green
                                                      : Colors.red,
                                                ),
                                              ),
                                              const SizedBox(
                                                width: 5,
                                              ),
                                              Text(
                                                clientController.allClients[index].isActive ? 'Active' : 'Inactive',
                                                style: TextStyle(
                                                    fontSize: 12,
                                                    fontWeight: FontWeight.bold,
                                                    color: clientController.allClients[index].isActive
                                                        ? Colors.green
                                                        : Colors.red),
                                              ),
                                            ],
                                          ),
                                          const SizedBox(height: 5),
                                          Row(
                                            mainAxisSize: MainAxisSize.min,
                                            children: [
                                              Text(
                                                clientController.allClients[index].designation,
                                                style: const TextStyle(fontSize: 12, fontWeight: FontWeight.w600),
                                              ),
                                              Text(
                                                " - ${clientController.allClients[index].company}",
                                                style: const TextStyle(fontSize: 12),
                                              ),
                                            ],
                                          ),
                                          const SizedBox(height: 15),
                                          const Divider(height: 5),
                                          const SizedBox(height: 15),
                                          clientsProject.isEmpty
                                              ? const Center(
                                                  child: Text(
                                                    'Project not assigned yet!\nAssign new or bind the existing project!',
                                                    style: TextStyle(
                                                      fontSize: 12,
                                                      color: Colors.black87,
                                                      fontStyle: FontStyle.normal,
                                                    ),
                                                    textAlign: TextAlign.center,
                                                  ),
                                                )
                                              : Row(
                                                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                                  children: [
                                                    Column(
                                                      crossAxisAlignment: CrossAxisAlignment.start,
                                                      children: [
                                                        Text(
                                                          clientsProject[0].projectName,
                                                          style: const TextStyle(
                                                              fontSize: 15, fontWeight: FontWeight.w500),
                                                        ),
                                                        const SizedBox(height: 5),
                                                        Text(
                                                          clientsProject.length == 1
                                                              ? "1 project only"
                                                              : "+${clientsProject.length - 1} more projects",
                                                          style: const TextStyle(fontSize: 12, color: Colors.black54),
                                                        ),
                                                      ],
                                                    ),
                                                    Column(
                                                      crossAxisAlignment: CrossAxisAlignment.end,
                                                      children: [
                                                        Text(
                                                          clientsProject[0].projectBudget,
                                                          style: const TextStyle(
                                                              fontSize: 15,
                                                              fontWeight: FontWeight.w500,
                                                              color: Colors.deepOrangeAccent),
                                                        ),
                                                        const SizedBox(height: 5),
                                                        Text(
                                                          clientsProject[0].projectStatus,
                                                          style: const TextStyle(
                                                              fontSize: 12, fontWeight: FontWeight.w600),
                                                        ),
                                                      ],
                                                    ),
                                                  ],
                                                ),
                                        ],
                                      ),
                                    ),
                                  );
                                });
                              },
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
                const SizedBox(
                  width: 40,
                ),
                Container(
                  width: MediaQuery.of(context).size.width * .15,
                  constraints: BoxConstraints(
                    maxHeight: MediaQuery.of(context).size.height * 0.82,
                  ),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    crossAxisAlignment: CrossAxisAlignment.stretch,
                    children: [
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.stretch,
                        children: [
                          Container(
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(15),
                              border: Border.all(color: Colors.black45, width: 1),
                            ),
                            padding: const EdgeInsets.all(20),
                            child: const Column(
                              mainAxisSize: MainAxisSize.min,
                              crossAxisAlignment: CrossAxisAlignment.start,
                              mainAxisAlignment: MainAxisAlignment.start,
                              children: [
                                Text(
                                  "Total balance",
                                  style: TextStyle(fontSize: 16, fontWeight: FontWeight.w600),
                                ),
                                SizedBox(
                                  height: 10,
                                ),
                                Text(
                                  "\$0",
                                  style: TextStyle(fontSize: 19, color: Colors.green, fontWeight: FontWeight.w600),
                                ),
                              ],
                            ),
                          ),
                          const SizedBox(
                            height: 40,
                          ),
                          Container(
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(15),
                              border: Border.all(color: Colors.black45, width: 1),
                            ),
                            padding: const EdgeInsets.all(20),
                            child: Column(
                              mainAxisSize: MainAxisSize.min,
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Row(
                                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                  children: [
                                    const Text(
                                      "Total Clients",
                                      style: TextStyle(fontSize: 16, fontWeight: FontWeight.w600),
                                    ),
                                    Text(
                                      clientController.allClients.length.toString(),
                                      style: const TextStyle(fontSize: 19),
                                    ),
                                  ],
                                ),
                                const SizedBox(
                                  height: 20,
                                ),
                                Row(
                                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                  children: [
                                    const Text(
                                      "Active Clients",
                                      style: TextStyle(fontSize: 16, fontWeight: FontWeight.w600),
                                    ),
                                    Text(
                                      clientController.allClients.where((e) => e.isActive == true).length.toString(),
                                      style: const TextStyle(fontSize: 19),
                                    ),
                                  ],
                                ),
                                const SizedBox(
                                  height: 20,
                                ),
                                Row(
                                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                  children: [
                                    const Text(
                                      "Inactive Clients",
                                      style: TextStyle(fontSize: 16, fontWeight: FontWeight.w600),
                                    ),
                                    Text(
                                      clientController.allClients.where((e) => e.isActive == false).length.toString(),
                                      style: const TextStyle(fontSize: 19),
                                    ),
                                  ],
                                ),
                              ],
                            ),
                          ),
                        ],
                      ),
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.stretch,
                        children: [
                          addButton(
                              icon: Ionicons.person_add_outline,
                              title: "New Client",
                              onTap: () {
                                newClientView = true;
                              }),
                          addButton(icon: Ionicons.code_working_outline, title: "New Project", onTap: () {}),
                        ],
                      ),
                    ],
                  ),
                )
              ],
            ),
          if (newClientView)
            AddNewClient(
              onClose: () {
                setState(() {
                  newClientView = false;
                });
              },
              onRegisterClient: () {
                setState(() {
                  clientController.getAllClients();
                  newClientView = false;
                });
              },
            ),
          if (clientDetailsView)
            ClientDetailsView(
              onClose: () {
                setState(() {
                  clientDetailsView = false;
                });
              },
              onDeleteClient: () {
                Get.dialog(
                  CustomDialogBox(
                    userModel: clientController.allClients[selectedProjectIndex!],
                    onSuccess: () {
                      clientController.deleteUser(clientController.allClients[selectedProjectIndex!].uid).then((v) {
                        if (v == true) {
                          setState(() {
                            clientController.getAllClients();
                            clientDetailsView = false;
                          });
                        }
                      });
                    },
                  ),
                );
              },
              clientDetails: clientController.allClients[selectedProjectIndex!],
            ),
        ],
      );
    });
  }

  Widget addButton({
    required IconData icon,
    required String title,
    required Function() onTap,
  }) {
    return InkWell(
      overlayColor: WidgetStateProperty.all(Colors.transparent),
      onTap: () {
        setState(() {
          onTap();
        });
      },
      child: Container(
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(15),
          border: Border.all(color: Colors.black45, width: 1),
        ),
        padding: const EdgeInsets.all(20),
        margin: const EdgeInsets.only(bottom: 30),
        child: Row(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Icon(
              icon,
              size: 30,
            ),
            const SizedBox(
              width: 15,
            ),
            Text(
              title,
              style: const TextStyle(fontSize: 16, fontWeight: FontWeight.w600),
            ),
          ],
        ),
      ),
    );
  }
}
