import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:lks_jabar_2023/Invoice_Page.dart';
import 'package:lks_jabar_2023/Login_Page.dart';
import 'package:lks_jabar_2023/Navbar.dart';
import 'package:lks_jabar_2023/Register_Page.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Latihan LKS Jawa Barat 2023',
      initialRoute: '/Login_Page',
      routes: {
        '/Login_Page': (context) => Login_Page(),
        '/Register_Page':(context) => Register_Page(),
        '/Navbar':(context) => Navbar(),
        '/Invoice_Page':(context) => Invoice_Page()
      },
    );
  }
}