import 'package:flutter/material.dart';
import '../services/api_service.dart';

class SOSScreen extends StatefulWidget {
  const SOSScreen({super.key});

  @override
  State<SOSScreen> createState() =>
      _SOSScreenState();
}

class _SOSScreenState
    extends State<SOSScreen> {

  late Future<List<dynamic>> alerts;

  @override
  void initState() {
    super.initState();
    alerts =
        ApiService.getSOSAlerts();
  }

  @override
  Widget build(BuildContext context) {

    return Scaffold(

      appBar: AppBar(
        title: const Text("SOS Alerts"),
      ),

      body: Column(
        children: [

          const SizedBox(height: 20),

          Padding(
            padding:
                const EdgeInsets.all(16),

            child: SizedBox(
              width: double.infinity,
              height: 70,

              child:
                  ElevatedButton.icon(

                onPressed: () async {
  try {
    await ApiService.createSOSAlert();

    setState(() {
      alerts = ApiService.getSOSAlerts();
    });

    ScaffoldMessenger.of(context).showSnackBar(
      const SnackBar(
        content: Text("SOS Alert Sent Successfully"),
      ),
    );
  } catch (e) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text(e.toString()),
      ),
    );
  }
},

                icon: const Icon(
                  Icons.warning,
                  size: 30,
                ),

                label: const Text(
                  "SEND EMERGENCY SOS",
                  style: TextStyle(
                    fontSize: 18,
                    fontWeight:
                        FontWeight.bold,
                  ),
                ),
              ),
            ),
          ),

          Expanded(
            child:
                FutureBuilder<List<dynamic>>(
              future: alerts,

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

                if (snapshot
                    .hasError) {

                  return Center(
                    child: Text(
                      snapshot.error
                          .toString(),
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

                    final sos =
                        data[index];

                    return Card(
                      color: Colors.red
                          .withOpacity(
                              0.2),

                      margin:
                          const EdgeInsets
                              .all(10),

                      child: ListTile(

                        leading:
                            const Icon(
                          Icons.warning,
                          color:
                              Colors.red,
                        ),

                        title: Text(
                          sos["status"] ??
                              "ACTIVE",
                        ),

                        subtitle: Text(
    "Alert: ${sos["alert_type"]}\n"
    "Battery: ${sos["battery_level"]}%\n"
    "Time: ${sos["timestamp"]}",
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