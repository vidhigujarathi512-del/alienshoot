import 'package:flutter/material.dart';
import '../services/api_service.dart';

class VerificationScreen
    extends StatefulWidget {

  const VerificationScreen({
    super.key,
  });

  @override
  State<VerificationScreen>
      createState() =>
          _VerificationScreenState();
}

class _VerificationScreenState
    extends State<
        VerificationScreen> {

  late Future<List<dynamic>>
      organizations;

  @override
  void initState() {

    super.initState();

    organizations =
        ApiService
            .getVerifiedOrganizations();
  }

  @override
  Widget build(
      BuildContext context) {

    return Scaffold(

      appBar: AppBar(
        title: const Text(
          "Trusted Organizations",
        ),
      ),

      body:
          FutureBuilder<List<dynamic>>(

        future: organizations,

        builder:
            (context, snapshot) {

          if (!snapshot.hasData) {

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

              final org =
                  data[index];

              return Card(

                child: ListTile(

                  leading: const Icon(
  Icons.verified,
  color: Colors.green,
),

                  title: Text(
                    org[
                        "organization_name"],
                  ),

                  subtitle: Text(
                    "Verification Level: ${org["verification_level"]}",
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