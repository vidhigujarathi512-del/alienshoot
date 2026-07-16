import 'package:flutter/material.dart';

import 'community_screen.dart';
import 'translation_screen.dart';
import 'capsule_screen.dart';
import 'verification_screen.dart';
import 'missing_person_screen.dart';

class MoreScreen extends StatelessWidget {
  const MoreScreen({super.key});

  @override
  Widget build(BuildContext context) {

    return Scaffold(

      appBar: AppBar(
        title: const Text("More"),
      ),

      body: ListView(

        children: [

          ListTile(
            leading: const Icon(Icons.groups),
            title: const Text("Community Hubs"),

            onTap: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (_) =>
                      const CommunityScreen(),
                ),
              );
            },
          ),


          ListTile(
  leading: const Icon(
    Icons.person_search,
  ),

  title: const Text(
    "Missing Persons",
  ),

  onTap: () {

    Navigator.push(
      context,

      MaterialPageRoute(
        builder: (_) =>
            const MissingPersonsScreen(),
      ),
    );
  },
),

          ListTile(
            leading: const Icon(Icons.translate),
            title: const Text("AI Translation"),

            onTap: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (_) =>
                      const TranslationScreen(),
                ),
              );
            },
          ),

          ListTile(
            leading: const Icon(Icons.mic),
            title:
                const Text("Voice Capsules"),

            onTap: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (_) =>
                      const VoiceCapsuleScreen(),
                ),
              );
            },
          ),

          ListTile(
            leading:
                const Icon(Icons.verified),

            title: const Text(
              "Trusted Organizations",
            ),

            onTap: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (_) =>
                      const VerificationScreen(),
                ),
              );
            },
          ),
        ],
      ),
    );
  }
}