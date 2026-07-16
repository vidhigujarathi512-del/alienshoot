import 'package:flutter/material.dart';
import 'dashboard_screen.dart';
import 'messages_screen.dart';
import 'sos_screen.dart';
import 'maps_screen.dart';
import 'more_screen.dart';
import 'vault_screen.dart';

class NavigationScreen extends StatefulWidget {
  const NavigationScreen({super.key});

  @override
  State<NavigationScreen> createState() =>
      _NavigationScreenState();
}

class _NavigationScreenState
    extends State<NavigationScreen> {

  int selectedIndex = 0;

  final List<Widget> screens = [

    const DashboardScreen(),

    const MessagesScreen(),

    const MapScreen(),

    const SOSScreen(),

    const KnowledgeScreen(),

   const MoreScreen(),

  ];

  @override
  Widget build(BuildContext context) {

    return Scaffold(

      body: screens[selectedIndex],

      bottomNavigationBar:
          BottomNavigationBar(

        currentIndex: selectedIndex,

        onTap: (index) {

          setState(() {

            selectedIndex = index;

          });
        },

        type: BottomNavigationBarType.fixed,

        items: const [

          BottomNavigationBarItem(
            icon: Icon(Icons.home),
            label: "Home",
          ),

          BottomNavigationBarItem(
            icon: Icon(Icons.message),
            label: "Messages",
          ),

          BottomNavigationBarItem(
            icon: Icon(Icons.map),
            label: "Map",
          ),

          BottomNavigationBarItem(
            icon: Icon(Icons.warning),
            label: "SOS",
          ),

          BottomNavigationBarItem(
            icon: Icon(Icons.menu_book),
            label: "Vault",
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.menu),
            label: "More",
          ),
        ],
      ),
    );
  }
}