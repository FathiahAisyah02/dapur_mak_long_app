import 'package:flutter/material.dart';
import 'staff_list_page.dart'; // Ensure correct navigation to Staff List Page
import 'package:cloud_firestore/cloud_firestore.dart';

class StaffCreationPage extends StatefulWidget {
  const StaffCreationPage({Key? key}) : super(key: key);

  @override
  _StaffCreationPageState createState() => _StaffCreationPageState();
}

class _StaffCreationPageState extends State<StaffCreationPage> {
  final nameController = TextEditingController();
  final idController = TextEditingController();
  final ageController = TextEditingController();

  void submitData() {
    final name = nameController.text;
    final id = idController.text;
    final age = ageController.text;

    // Validation
    if (name.isEmpty || id.isEmpty || age.isEmpty) {
      _showErrorDialog('All fields are required!');
      return;
    }

    if (id.length < 4) {
      _showErrorDialog('Staff ID must be at least 4 characters long!');
      return;
    }

    if (int.tryParse(age) == null || int.parse(age) < 18) {
      _showErrorDialog('Please enter a valid age (18 or above)!');
      return;
    }

    // Save data to Firebase
    FirebaseFirestore.instance.collection('staff').add({
      'name': name,
      'id': id,
      'age': age,
    }).then((_) {
      Navigator.pushReplacement(
        context,
        MaterialPageRoute(builder: (context) => StaffListPage()),
      );
    }).catchError((error) {
      _showErrorDialog('Failed to add staff: $error');
    });
  }

  // Error dialog function
  void _showErrorDialog(String message) {
    showDialog(
      context: context,
      builder: (ctx) => AlertDialog(
        title: Text('Error'),
        content: Text(message),
        actions: [
          TextButton(
            child: Text('OK'),
            onPressed: () {
              Navigator.of(ctx).pop();
            },
          ),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Create Staff'),
        backgroundColor: const Color.fromARGB(255, 150, 0, 62),
        elevation: 5,
      ),
      body: Padding(
        padding: EdgeInsets.all(16.0),
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              // Staff Name Field
              TextField(
                controller: nameController,
                decoration: InputDecoration(
                  labelText: 'Staff Name',
                  labelStyle: TextStyle(
                    color: const Color.fromARGB(255, 150, 0, 62),
                    fontSize: 18,
                  ),
                  border: OutlineInputBorder(),
                  focusedBorder: OutlineInputBorder(
                    borderSide: BorderSide(color: const Color.fromARGB(255, 150, 0, 62), width: 2),
                  ),
                ),
              ),
              SizedBox(height: 16),
              // Staff ID Field
              TextField(
                controller: idController,
                decoration: InputDecoration(
                  labelText: 'Staff ID',
                  labelStyle: TextStyle(
                    color: const Color.fromARGB(255, 150, 0, 62),
                    fontSize: 18,
                  ),
                  border: OutlineInputBorder(),
                  focusedBorder: OutlineInputBorder(
                    borderSide: BorderSide(color: const Color.fromARGB(255, 150, 0, 62), width: 2),
                  ),
                ),
              ),
              SizedBox(height: 16),
              // Staff Age Field
              TextField(
                controller: ageController,
                decoration: InputDecoration(
                  labelText: 'Staff Age',
                  labelStyle: TextStyle(
                    color: const Color.fromARGB(255, 150, 0, 62),
                    fontSize: 18,
                  ),
                  border: OutlineInputBorder(),
                  focusedBorder: OutlineInputBorder(
                    borderSide: BorderSide(color: const Color.fromARGB(255, 150, 0, 62), width: 2),
                  ),
                ),
                keyboardType: TextInputType.number,
              ),
              SizedBox(height: 24),
              // Submit Button
              ElevatedButton(
                onPressed: submitData,
                style: ElevatedButton.styleFrom(
                  backgroundColor: const Color.fromARGB(255, 150, 0, 62),
                  padding: EdgeInsets.symmetric(vertical: 12, horizontal: 30),
                  textStyle: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(8),
                  ),
                ),
                child: Text('Submit'),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
