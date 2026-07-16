import 'package:flutter/material.dart';
import '../services/api_service.dart';

class MessagesScreen extends StatefulWidget {
  const MessagesScreen({super.key});

  @override
  State<MessagesScreen> createState() =>
      _MessagesScreenState();
}

class _MessagesScreenState
    extends State<MessagesScreen> {

  late Future<List<dynamic>> messages;

  final titleController =
      TextEditingController();

  final contentController =
      TextEditingController();

  final authorController =
      TextEditingController(
        text: "Vidhi",
      );

  @override
  void initState() {
    super.initState();
    messages =
        ApiService.getMessages();
  }

  Future<void>
      _showCreateMessageDialog() async {

    await showDialog(
      context: context,

      builder: (context) {

        return AlertDialog(

          title: const Text(
            "Create Message",
          ),

          content: Column(
            mainAxisSize:
                MainAxisSize.min,

            children: [

              TextField(
                controller:
                    titleController,

                decoration:
                    const InputDecoration(
                  labelText:
                      "Title",
                ),
              ),

              const SizedBox(
                height: 10,
              ),

              TextField(
                controller:
                    contentController,

                maxLines: 4,

                decoration:
                    const InputDecoration(
                  labelText:
                      "Message",
                ),
              ),
            ],
          ),

          actions: [

            TextButton(
              onPressed: () {
                Navigator.pop(
                    context);
              },

              child:
                  const Text(
                "Cancel",
              ),
            ),

            ElevatedButton(

              onPressed:
                  () async {

                try {

                  await ApiService
                      .sendMessage(
                    titleController
                        .text,
                    contentController
                        .text,
                    authorController
                        .text,
                  );

                  if (!mounted) {
                    return;
                  }

                  Navigator.pop(
                      context);

                  titleController
                      .clear();

                  contentController
                      .clear();

                  setState(() {

                    messages =
                        ApiService
                            .getMessages();

                  });

                } catch (e) {

                  ScaffoldMessenger.of(
                          context)
                      .showSnackBar(

                    SnackBar(
                      content: Text(
                        e.toString(),
                      ),
                    ),

                  );
                }
              },

              child:
                  const Text(
                "Send",
              ),
            ),
          ],
        );
      },
    );
  }

  @override
  Widget build(
      BuildContext context) {

    return Scaffold(

      appBar: AppBar(
        title: const Text(
          "Messages",
        ),
      ),

      floatingActionButton:
          FloatingActionButton(

        onPressed: () {
          _showCreateMessageDialog();
        },

        child:
            const Icon(
          Icons.add,
        ),
      ),

      body:
          FutureBuilder<
              List<dynamic>>(

        future: messages,

        builder:
            (context, snapshot) {

          if (snapshot
                  .connectionState ==
              ConnectionState
                  .waiting) {

            return const Center(
              child:
                  CircularProgressIndicator(),
            );
          }

          if (snapshot.hasError) {

            return Center(
              child: Text(
                snapshot.error
                    .toString(),
              ),
            );
          }

          final data =
              snapshot.data ?? [];

          if (data.isEmpty) {

            return const Center(
              child: Text(
                "No messages found",
              ),
            );
          }

          return ListView.builder(

            itemCount:
                data.length,

            itemBuilder:
                (context, index) {

              final message =
                  data[index];

              return Card(

                margin:
                    const EdgeInsets
                        .all(10),

                child: ListTile(

                  title: Text(
                    message["title"]
                            ?.toString() ??
                        "",
                  ),

                  subtitle:
                      Column(

                    crossAxisAlignment:
                        CrossAxisAlignment
                            .start,

                    children: [

                      Text(
                        message["content"]
                                ?.toString() ??
                            "",
                      ),

                      const SizedBox(
                        height: 5,
                      ),

                      Text(
                        "Priority: ${message["priority_level"]}",
                      ),

                      Text(
                        "Status: ${message["delivery_status"]}",
                      ),

                      Text(
                        "Hops: ${message["hop_count"]}",
                      ),
                    ],
                  ),

                  trailing: Text(
                    message["author"]
                            ?.toString() ??
                        "",
                  ),
                ),
              );
            },
          );
        },
      ),
    );
  }
}