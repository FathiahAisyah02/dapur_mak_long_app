import 'package:flutter/material.dart';
import '../services/firebase_service.dart';
import 'staff_list_page.dart';

class StaffCreationPage extends StatefulWidget {
  const StaffCreationPage({Key? key}) : super(key: key);

  @override
  _StaffCreationPageState createState() => _StaffCreationPageState();
}

class _StaffCreationPageState extends State<StaffCreationPage> {
  final nameController = TextEditingController();
  final idController = TextEditingController();
  final ageController = TextEditingController();

  final FirebaseService _firebaseService = FirebaseService();

  void submitData() {
    final name = nameController.text;
    final id = idController.text;
    final age = ageController.text;

    if (name.isEmpty || id.isEmpty || age.isEmpty) {
      // Show an alert for missing input
      return;
    }

    // Save data to Firebase
    _firebaseService.addStaff(name, id, age).then((_) {
      if (mounted) {
        // Navigate to the Staff List page if the widget is still mounted
        Navigator.pushReplacement(
          context,
          MaterialPageRoute(builder: (context) => StaffListPage()),
        );
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Create Staff'),
        backgroundColor: const Color.fromARGB(255, 150, 0, 62), // AppBar color change
        elevation: 5, // Add shadow to the app bar for a subtle 3D effect
      ),
      body: Padding(
        padding: EdgeInsets.all(16.0),
        child: SingleChildScrollView( // Allow scrolling if keyboard appears
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              // Staff Name Field
              TextField(
                controller: nameController,
                decoration: InputDecoration(
                  labelText: 'Staff Name',
                  labelStyle: TextStyle(
                    color: const Color.fromARGB(255, 150, 0, 62), // Label color change
                    fontSize: 18,
                  ),
                  border: OutlineInputBorder(),
                  focusedBorder: OutlineInputBorder(
                    borderSide: BorderSide(color: const Color.fromARGB(255, 150, 0, 62), width: 2), // Focused border
                  ),
                  enabledBorder: OutlineInputBorder(
                    borderSide: BorderSide(color: const Color.fromARGB(255, 150, 0, 62), width: 1), // Default border
                  ),
                ),
              ),
              SizedBox(height: 16), // Space between fields

              // Staff ID Field
              TextField(
                controller: idController,
                decoration: InputDecoration(
                  labelText: 'Staff ID',
                  labelStyle: TextStyle(
                    color: const Color.fromARGB(255, 150, 0, 62), // Label color change
                    fontSize: 18,
                  ),
                  border: OutlineInputBorder(),
                  focusedBorder: OutlineInputBorder(
                    borderSide: BorderSide(color: const Color.fromARGB(255, 150, 0, 62), width: 2), // Focused border
                  ),
                  enabledBorder: OutlineInputBorder(
                    borderSide: BorderSide(color: const Color.fromARGB(255, 150, 0, 62), width: 1), // Default border
                  ),
                ),
              ),
              SizedBox(height: 16), // Space between fields

              // Staff Age Field
              TextField(
                controller: ageController,
                decoration: InputDecoration(
                  labelText: 'Staff Age',
                  labelStyle: TextStyle(
                    color: const Color.fromARGB(255, 150, 0, 62), // Label color change
                    fontSize: 18,
                  ),
                  border: OutlineInputBorder(),
                  focusedBorder: OutlineInputBorder(
                    borderSide: BorderSide(color:const Color.fromARGB(255, 150, 0, 62), width: 2), // Focused border
                  ),
                  enabledBorder: OutlineInputBorder(
                    borderSide: BorderSide(color: const Color.fromARGB(255, 150, 0, 62), width: 1), // Default border
                  ),
                ),
                keyboardType: TextInputType.number,
              ),
              SizedBox(height: 24), // Space before the button

              // Submit Button
              ElevatedButton(
                onPressed: submitData,
                style: ElevatedButton.styleFrom(
                  backgroundColor: const Color.fromARGB(255, 150, 0, 62), // Correct way to set background color
                  padding: EdgeInsets.symmetric(vertical: 12, horizontal: 30), // Padding
                  textStyle: TextStyle(fontSize: 18, fontWeight: FontWeight.bold), // Text styling
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(8), // Rounded corners
                  ),
                ),
                child: Text('Submit'), // Correct 'child' parameter
              ),
            ],
          ),
        ),
      ),
    );
  }
}
