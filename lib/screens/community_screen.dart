import 'package:flutter/material.dart';
import '../services/api_service.dart';

class CommunityScreen extends StatefulWidget {
  const CommunityScreen({super.key});

  @override
  State<CommunityScreen> createState() =>
      _CommunityScreenState();
}

class _CommunityScreenState
    extends State<CommunityScreen> {

  late Future<List<dynamic>> hubs;

  final hubNameController =
      TextEditingController();

  final locationController =
      TextEditingController();

  @override
  void initState() {
    super.initState();
    hubs =
        ApiService.getCommunityHubs();
  }

  Future<void> _showCreateHubDialog() async {

    await showDialog(
      context: context,

      builder: (context) {

        return AlertDialog(

          title: const Text(
            "Create Community Hub",
          ),

          content: Column(
            mainAxisSize:
                MainAxisSize.min,

            children: [

              TextField(
                controller:
                    hubNameController,
                decoration:
                    const InputDecoration(
                  labelText:
                      "Hub Name",
                ),
              ),

              const SizedBox(
                height: 10,
              ),

              TextField(
                controller:
                    locationController,
                decoration:
                    const InputDecoration(
                  labelText:
                      "Location",
                ),
              ),
            ],
          ),

          actions: [

            TextButton(
              onPressed: () {
                Navigator.pop(context);
              },
              child: const Text(
                "Cancel",
              ),
            ),

            ElevatedButton(
              onPressed: () async {

                await ApiService
                    .createCommunityHub(
                  hubNameController.text,
                  locationController.text,
                );

                Navigator.pop(context);

                setState(() {
                  hubs =
                      ApiService.getCommunityHubs();
                });
              },

              child: const Text(
                "Create",
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
          "Community Hubs",
        ),
      ),

      floatingActionButton:
          FloatingActionButton(

        onPressed: () {
          _showCreateHubDialog();
        },

        child: const Icon(
          Icons.add,
        ),
      ),

      body: FutureBuilder<
          List<dynamic>>(

        future: hubs,

        builder:
            (context, snapshot) {

          if (snapshot.connectionState ==
              ConnectionState.waiting) {

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

          if (!snapshot.hasData ||
              snapshot.data!.isEmpty) {

            return const Center(
              child: Text(
                "No Community Hubs Found",
              ),
            );
          }

          final data =
              snapshot.data!;

          return ListView.builder(

            itemCount:
                data.length,

            itemBuilder:
                (context, index) {

              final hub =
                  data[index];

              return Card(

                margin:
                    const EdgeInsets.all(
                        10),

                child: ListTile(

                  leading: const Icon(
                    Icons.groups,
                    size: 40,
                  ),

                  title: Text(
                    hub["hub_name"] ??
                        "Community Hub",
                  ),

                  subtitle: Column(
                    crossAxisAlignment:
                        CrossAxisAlignment
                            .start,

                    children: [

                      Text(
                        "Location: ${hub["location"]}",
                      ),

                      Text(
                        "Members: ${hub["members"]}",
                      ),

                      Text(
                        "Status: ${hub["status"]}",
                      ),
                    ],
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