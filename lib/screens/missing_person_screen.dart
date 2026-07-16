import 'package:flutter/material.dart';
import '../services/api_service.dart';

class MissingPersonsScreen extends StatefulWidget {
  const MissingPersonsScreen({super.key});

  @override
  State<MissingPersonsScreen> createState() =>
      _MissingPersonsScreenState();
}

class _MissingPersonsScreenState
    extends State<MissingPersonsScreen> {

  late Future<List<dynamic>> persons;

  final nameController =
      TextEditingController();

  final ageController =
      TextEditingController();

  final descriptionController =
      TextEditingController();

  final lastSeenController =
      TextEditingController();

  @override
  void initState() {
    super.initState();
    persons =
        ApiService.getMissingPersons();
  }

  Future<void>
      _showCreateMissingPersonDialog()
      async {

    await showDialog(
      context: context,

      builder: (context) {

        return AlertDialog(

          title: const Text(
            "Report Missing Person",
          ),

          content:
              SingleChildScrollView(

            child: Column(
              mainAxisSize:
                  MainAxisSize.min,

              children: [

                TextField(
                  controller:
                      nameController,
                  decoration:
                      const InputDecoration(
                    labelText:
                        "Name",
                  ),
                ),

                const SizedBox(
                  height: 10,
                ),

                TextField(
                  controller:
                      ageController,
                  keyboardType:
                      TextInputType.number,
                  decoration:
                      const InputDecoration(
                    labelText:
                        "Age",
                  ),
                ),

                const SizedBox(
                  height: 10,
                ),

                TextField(
                  controller:
                      descriptionController,
                  maxLines: 3,
                  decoration:
                      const InputDecoration(
                    labelText:
                        "Description",
                  ),
                ),

                const SizedBox(
                  height: 10,
                ),

                TextField(
                  controller:
                      lastSeenController,
                  decoration:
                      const InputDecoration(
                    labelText:
                        "Last Seen Location",
                  ),
                ),
              ],
            ),
          ),

          actions: [

            TextButton(
              onPressed: () {
                Navigator.pop(
                    context);
              },
              child: const Text(
                "Cancel",
              ),
            ),

            ElevatedButton(

              onPressed:
                  () async {

                try {

                  await ApiService
                      .createMissingPerson(
                    nameController.text,
                    int.parse(
                      ageController.text,
                    ),
                    descriptionController
                        .text,
                    lastSeenController
                        .text,
                  );

                  if (!mounted) {
                    return;
                  }

                  Navigator.pop(
                      context);

                  nameController
                      .clear();

                  ageController
                      .clear();

                  descriptionController
                      .clear();

                  lastSeenController
                      .clear();

                  setState(() {

                    persons =
                        ApiService
                            .getMissingPersons();

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

              child: const Text(
                "Report",
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
          "Missing Persons",
        ),
      ),

      floatingActionButton:
          FloatingActionButton(

        onPressed: () {
          _showCreateMissingPersonDialog();
        },

        child: const Icon(
          Icons.add,
        ),
      ),

      body:
          FutureBuilder<List<dynamic>>(

        future: persons,

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

          final data =
              snapshot.data ?? [];

          if (data.isEmpty) {

            return const Center(
              child: Text(
                "No Missing Persons Found",
              ),
            );
          }

          return ListView.builder(

            itemCount:
                data.length,

            itemBuilder:
                (context, index) {

              final person =
                  data[index];

              return Card(

                margin:
                    const EdgeInsets.all(
                        10),

                child: ListTile(

                  leading:
                      const Icon(
                    Icons.person_search,
                    size: 40,
                    color: Colors.red,
                  ),

                  title: Text(
                    person["name"]
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
                        "Age: ${person["age"]}",
                      ),

                      Text(
                        "Last Seen: ${person["last_seen_location"]}",
                      ),

                      Text(
                        person["description"]
                                ?.toString() ??
                            "",
                      ),

                      Text(
                        "Status: ${person["status"]}",
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