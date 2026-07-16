import 'package:flutter/material.dart';
import '../services/api_service.dart';

class DashboardScreen extends StatefulWidget {
  const DashboardScreen({super.key});

  @override
  State<DashboardScreen> createState() => _DashboardScreenState();
}

class _DashboardScreenState extends State<DashboardScreen> {

  late Future<Map<String, dynamic>> dashboardData;

  @override
  void initState() {
    super.initState();
    dashboardData = ApiService.getDashboardData();
  }

  @override
  Widget build(BuildContext context) {

    return Scaffold(

      body: FutureBuilder<Map<String, dynamic>>(
        future: dashboardData,

        builder: (context, snapshot) {

          if (snapshot.connectionState ==
              ConnectionState.waiting) {
            return const Center(
              child: CircularProgressIndicator(),
            );
          }

          if (snapshot.hasError) {
            return Center(
              child: Text(
                snapshot.error.toString(),
              ),
            );
          }

          if (!snapshot.hasData) {
             return const Center(
           child: Text("No dashboard data"),
  );
}

final data = snapshot.data!;

          return SingleChildScrollView(
            padding: const EdgeInsets.all(20),

            child: Column(
              crossAxisAlignment:
                  CrossAxisAlignment.start,

              children: [

                const SizedBox(height: 40),

                const Text(
                  "ResQNet",
                  style: TextStyle(
                    fontSize: 34,
                    fontWeight: FontWeight.bold,
                  ),
                ),

                const SizedBox(height: 5),

                const Text(
                  "Human Mesh Communication Network",
                  style: TextStyle(
                    color: Colors.grey,
                    fontSize: 15,
                  ),
                ),

                const SizedBox(height: 25),

                Container(
                  width: double.infinity,
                  padding: const EdgeInsets.all(20),

                  decoration: BoxDecoration(
                    borderRadius:
                        BorderRadius.circular(20),

                    gradient: const LinearGradient(
                      colors: [
                        Color(0xFF1E3A8A),
                        Color(0xFF2563EB),
                      ],
                    ),
                  ),

                  child: Column(
                    crossAxisAlignment:
                        CrossAxisAlignment.start,

                    children: [

                      const Text(
                        "NETWORK ACTIVE",
                        style: TextStyle(
                          color: Colors.white70,
                          letterSpacing: 2,
                        ),
                      ),

                      const SizedBox(height: 10),

                      Text(
                        "${data["nodes_in_range"]} Nodes In Range",
                        style: const TextStyle(
                          fontSize: 28,
                          fontWeight:
                              FontWeight.bold,
                        ),
                      ),

                      const SizedBox(height: 8),

                      Text(
                        "Mesh Status: ${data["network_status"]}",
                      ),
                    ],
                  ),
                ),

                const SizedBox(height: 20),

                SizedBox(
                  width: double.infinity,
                  height: 60,

                  child: ElevatedButton.icon(
                    onPressed: () {},

                    icon: const Icon(
                      Icons.warning,
                    ),

                    label: const Text(
                      "EMERGENCY SOS",
                      style: TextStyle(
                        fontSize: 18,
                        fontWeight:
                            FontWeight.bold,
                      ),
                    ),
                  ),
                ),

                const SizedBox(height: 25),

                Row(
                  children: [

                    Expanded(
                      child: _buildCard(
                        "Users",
                        "${data["users"]}",
                        Icons.people,
                      ),
                    ),

                    const SizedBox(width: 12),

                    Expanded(
                      child: _buildCard(
                        "Messages",
                        "${data["messages"]}",
                        Icons.message,
                      ),
                    ),
                  ],
                ),

                const SizedBox(height: 12),

                Row(
                  children: [

                    Expanded(
                      child: _buildCard(
                        "Relay Nodes",
                        "${data["relay_nodes"]}",
                        Icons.router,
                      ),
                    ),

                    const SizedBox(width: 12),

                    Expanded(
                      child: _buildCard(
                        "SOS Alerts",
                        "${data["active_sos"]}",
                        Icons.warning,
                      ),
                    ),
                  ],
                ),

                const SizedBox(height: 30),

                const Text(
                  "Network Health",
                  style: TextStyle(
                    fontSize: 20,
                    fontWeight:
                        FontWeight.bold,
                  ),
                ),

                const SizedBox(height: 10),

                ClipRRect(
                  borderRadius:
                      BorderRadius.circular(10),

                  child: const LinearProgressIndicator(
                    value: 0.92,
                    minHeight: 12,
                  ),
                ),

                const SizedBox(height: 30),

                const Text(
                  "Trust Score",
                  style: TextStyle(
                    fontSize: 20,
                    fontWeight:
                        FontWeight.bold,
                  ),
                ),

                const SizedBox(height: 10),

                ClipRRect(
                  borderRadius:
                      BorderRadius.circular(10),

                  child: const LinearProgressIndicator(
                    value: 0.84,
                    minHeight: 12,
                  ),
                ),

                const SizedBox(height: 30),
              ],
            ),
          );
        },
      ),
    );
  }

  Widget _buildCard(
    String title,
    String value,
    IconData icon,
  ) {
    return Container(

      padding: const EdgeInsets.all(16),

      decoration: BoxDecoration(
        color: const Color(0xFF151B2D),

        borderRadius:
            BorderRadius.circular(18),
      ),

      child: Column(
        children: [

          Icon(
            icon,
            size: 30,
          ),

          const SizedBox(height: 10),

          Text(
            value,
            style: const TextStyle(
              fontSize: 28,
              fontWeight:
                  FontWeight.bold,
            ),
          ),

          const SizedBox(height: 5),

          Text(
            title,
            textAlign: TextAlign.center,
          ),
        ],
      ),
    );
  }
}