import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:portfolio_admin/controllers/messages_controller.dart';

class MessagesScreen extends StatelessWidget {
  MessagesScreen({super.key});
  final messagesController = Get.find<MessagesController>();

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.start,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Container(
          constraints: BoxConstraints(
            maxHeight: MediaQuery.of(context).size.height * 0.82,
          ),
          child: ListView.builder(
              shrinkWrap: true,
              itemCount: messagesController.allMessages.length,
              itemBuilder: (context, index) {
                return Container(
                  margin: const EdgeInsets.only(bottom: 25),
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(20),
                    border: Border.all(color: Colors.black),
                  ),
                  child: Row(
                    children: [
                      if (messagesController.allMessages[index].status != "read")
                        Container(
                          width: 10,
                          height: 100,
                          color: Colors.green,
                        ),
                      Expanded(
                        child: Container(
                          padding: const EdgeInsets.all(25),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Row(
                                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                children: [
                                  Text(
                                    messagesController.allMessages[index].name,
                                    style: const TextStyle(fontWeight: FontWeight.w700, fontSize: 30),
                                  ),
                                  if (messagesController.allMessages[index].status != "read")
                                    const Text("Mark as read", style: TextStyle(fontSize: 12)),
                                ],
                              ),
                              const SizedBox(height: 10),
                              Row(
                                children: [
                                  const Text("From: ", style: TextStyle(fontSize: 12)),
                                  Text(
                                    messagesController.allMessages[index].email,
                                    style: const TextStyle(fontWeight: FontWeight.w700, fontSize: 12),
                                  ),
                                ],
                              ),
                              const SizedBox(height: 15),
                              const Divider(
                                color: Colors.black45,
                                height: 1,
                              ),
                              const SizedBox(height: 15),
                              const Text("Message:", style: TextStyle(fontSize: 12)),
                              const SizedBox(height: 10),
                              Text(
                                messagesController.allMessages[index].message,
                                style: const TextStyle(fontSize: 16),
                              ),
                            ],
                          ),
                        ),
                      ),
                    ],
                  ),
                );
              }),
        ),
      ],
    );
  }
}
