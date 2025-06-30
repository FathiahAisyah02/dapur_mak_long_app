import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'staff_creation_page.dart'; // Correct import

class StaffListPage extends StatelessWidget {
  final FirebaseFirestore _firebaseService = FirebaseFirestore.instance;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Staff List'),
        backgroundColor: const Color.fromRGBO(255, 77, 107, 0.836),
        elevation: 5,
      ),
      body: StreamBuilder(
        stream: _firebaseService.collection('staff').snapshots(),
        builder: (context, AsyncSnapshot<QuerySnapshot> snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return Center(child: CircularProgressIndicator());
          }

          if (snapshot.hasError) {
            return Center(child: Text('Something went wrong!'));
          }

          if (!snapshot.hasData || snapshot.data!.docs.isEmpty) {
            return Center(child: Text('No staff data available.'));
          }

          final staffList = snapshot.data!.docs;
          return ListView.builder(
            itemCount: staffList.length,
            itemBuilder: (context, index) {
              final staff = staffList[index];

              // Safely check for null data
              final staffData = staff.data() as Map<String, dynamic>?;

              if (staffData == null || !staffData.containsKey('name') || !staffData.containsKey('id') || !staffData.containsKey('age')) {
                return ListTile(
                  title: Text('Invalid Staff Data'),
                );
              }

              return Card(
                margin: EdgeInsets.symmetric(vertical: 8, horizontal: 16),
                color: Colors.pink[50], // Light pink card background
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(15),
                ),
                elevation: 3,
                child: ListTile(
                  contentPadding: EdgeInsets.all(16),
                  title: Text(
                    'Name: ${staffData['name']}',
                    style: TextStyle(fontWeight: FontWeight.bold, fontSize: 18),
                  ),
                  subtitle: Text(
                    'ID: ${staffData['id']} - Age: ${staffData['age']}',
                    style: TextStyle(fontSize: 16),
                  ),
                  trailing: IconButton(
                    icon: Icon(Icons.delete, color: Colors.red),
                    onPressed: () {
                      _firebaseService.collection('staff').doc(staff.id).delete();
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
        backgroundColor: const Color.fromRGBO(255, 77, 107, 0.836),
        child: Icon(Icons.add),
      ),
    );
  }
}
