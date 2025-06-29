import 'package:cloud_firestore/cloud_firestore.dart';

class FirebaseService {
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;

  // Example method
  Future<void> addStaff(String name, String id, String age) async {
    try {
      await _firestore.collection('staff').add({
        'name': name,
        'id': id,
        'age': age,
      });
    } catch (e) {
      print("Error adding staff: $e");
    }
  }

  // Get all staff
  Stream<QuerySnapshot> getStaffList() {
    return _firestore.collection('staff').snapshots();
  }

  // Delete a staff entry by ID
  Future<void> deleteStaff(String staffId) async {
    try {
      await _firestore.collection('staff').doc(staffId).delete();
    } catch (e) {
      print("Error deleting staff: $e");
    }
  }
}
