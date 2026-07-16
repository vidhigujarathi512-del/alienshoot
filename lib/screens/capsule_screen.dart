import 'package:flutter/material.dart';
import '../services/api_service.dart';

class VoiceCapsuleScreen
    extends StatefulWidget {

  const VoiceCapsuleScreen({
    super.key,
  });

  @override
  State<VoiceCapsuleScreen>
      createState() =>
          _VoiceCapsuleScreenState();
}

class _VoiceCapsuleScreenState
    extends State<
        VoiceCapsuleScreen> {

  final controller =
      TextEditingController();

  late Future<List<dynamic>>
      capsules;

  @override
  void initState() {

    super.initState();

    capsules =
        ApiService.getVoiceCapsules();
  }

  @override
  Widget build(
      BuildContext context) {

    return Scaffold(

      appBar: AppBar(
        title: const Text(
          "Voice Capsules",
        ),
      ),

      floatingActionButton:
          FloatingActionButton(

        onPressed: () async {

          await ApiService
              .createVoiceCapsule(

            "Vidhi",

            controller.text,
          );

          setState(() {

            capsules =
                ApiService
                    .getVoiceCapsules();

          });
        },

        child:
            const Icon(Icons.mic),
      ),

      body: Column(

        children: [

          Padding(
            padding:
                const EdgeInsets.all(16),

            child: TextField(

              controller:
                  controller,

              decoration:
                  const InputDecoration(

                hintText:
                    "Emergency voice transcript",
              ),
            ),
          ),

          Expanded(

            child:
                FutureBuilder<List<dynamic>>(

              future: capsules,

              builder:
                  (context, snapshot) {

                if (!snapshot
                    .hasData) {

                  return const Center(
                    child:
                        CircularProgressIndicator(),
                  );
                }

                final data =
                    snapshot.data!;

                return ListView.builder(

                  itemCount:
                      data.length,

                  itemBuilder:
                      (context, index) {

                    final capsule =
                        data[index];

                    return Card(

                      child: ListTile(

                        leading:
                            const Icon(
                          Icons.mic,
                        ),

                       title: Text(
    capsule["sender"],
),

                        subtitle: Text(
                          capsule[
                              "transcript"],
                        ),
                      ),
                    );
                  },
                );
              },
            ),
          ),
        ],
      ),
    );
  }
}