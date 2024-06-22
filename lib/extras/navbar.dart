import 'package:flutter/material.dart';
import 'package:google_nav_bar/google_nav_bar.dart';

class navbar extends StatelessWidget{
  @override
  Widget build(BuildContext context) {
    return GNav(
        backgroundColor: Color.fromARGB(255, 5, 17, 26),
        color: Color.fromARGB(255, 132, 143, 173),
        activeColor: Color.fromARGB(255, 55, 184, 193),
        gap: 5,
        tabs: [
          GButton(
            icon: Icons.home_filled,
            text: 'Home'
          ),
          GButton(
              icon: Icons.devices,
              text: 'Devices'),
          GButton(
              icon: Icons.meeting_room,
              text: 'Rooms'
          ),
          GButton(
              icon: Icons.settings_rounded,
              text: 'Settings'
          ),
        ]
    );
  }

}