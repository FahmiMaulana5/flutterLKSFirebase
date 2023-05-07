import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter/src/widgets/placeholder.dart';
import 'package:lks_jabar_2023/Menu_Page.dart';
import 'package:lks_jabar_2023/Profile_Page.dart';

class Navbar extends StatefulWidget {
  const Navbar({super.key});

  @override
  State<Navbar> createState() => _NavbarState();
}

class _NavbarState extends State<Navbar> {
  
  int _selectedIndex = 0;

  static final List<Widget> _tabs = [
    Menu_Page(),
    Profile_Page()
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      body: _tabs[_selectedIndex],
      bottomNavigationBar: BottomNavigationBar(
        currentIndex: _selectedIndex,
        backgroundColor: Colors.white,
        items: [
          BottomNavigationBarItem(
            icon: Icon(Icons.trolley),
            label: 'Menu'
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.people_alt_rounded),
            label: 'Profile'
          )
        ],
        onTap: (value) {
          setState(() {
             _selectedIndex = value;
          });
        },
      ),
    );
  }
}