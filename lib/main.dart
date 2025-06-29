import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart';
import 'screens/staff_creation_page.dart'; // Import the creation page

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();  // Initialize Firebase
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter CRUD Firebase',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: StaffCreationPage(),  // Start with the Staff Creation page
    );
  }
}
