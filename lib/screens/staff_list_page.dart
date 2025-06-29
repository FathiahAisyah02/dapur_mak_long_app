import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import '../services/firebase_service.dart';
import 'staff_creation_page.dart';

class StaffListPage extends StatelessWidget {
  final FirebaseService _firebaseService = FirebaseService();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Staff List'),
        backgroundColor: const Color.fromRGBO(255, 77, 107, 0.836), // Dark pink color for AppBar
        elevation: 5, // Add a subtle shadow effect to the app bar
      ),
      body: StreamBuilder(
        stream: _firebaseService.getStaffList(),
        builder: (context, AsyncSnapshot<QuerySnapshot> snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return Center(child: CircularProgressIndicator());
          }

          if (!snapshot.hasData || snapshot.data!.docs.isEmpty) {
            return Center(child: Text('No staff data available.'));
          }

          final staffList = snapshot.data!.docs;
          return ListView.builder(
            itemCount: staffList.length,
            itemBuilder: (context, index) {
              final staff = staffList[index];
              return Card( // Added a card for better visual appeal
                margin: EdgeInsets.symmetric(vertical: 8, horizontal: 16),
                color: Colors.pink[50], // Light pink card background
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(15), // Rounded corners for the card
                ),
                elevation: 3, // Subtle shadow around the card
                child: ListTile(
                  contentPadding: EdgeInsets.all(16), // Added padding inside ListTile
                  title: Text(
                    'Name: ${staff['name']}',
                    style: TextStyle(fontWeight: FontWeight.bold, fontSize: 18),
                  ),
                  subtitle: Text(
                    'ID: ${staff['id']} - Age: ${staff['age']}',
                    style: TextStyle(fontSize: 16),
                  ),
                  trailing: IconButton(
                    icon: Icon(Icons.delete, color: Colors.red), // Red delete icon
                    onPressed: () {
                      // Delete the staff entry
                      _firebaseService.deleteStaff(staff.id);
                    },
                  ),
                ),
              );
            },
          );
        },
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          Navigator.push(
            context,
            MaterialPageRoute(builder: (context) => StaffCreationPage()),
          );
        },
        backgroundColor: const Color.fromRGBO(255, 77, 107, 0.836), // Dark pink color for the FAB
        child: Icon(Icons.add),
      ),
    );
  }
}
