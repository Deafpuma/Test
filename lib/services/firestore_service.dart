import 'package:cloud_firestore/cloud_firestore.dart';

class FirestoreService {
  final FirebaseFirestore _db = FirebaseFirestore.instance;

  Future<void> saveUserData(String userId, Map<String, dynamic> userData) async {
    try {
      await _db.collection("users").doc(userId).set(userData, SetOptions(merge: true));
    } catch (e) {
      print("Firestore Error: $e");
    }
  }

  Future<DocumentSnapshot?> getUserData(String userId) async {
    try {
      return await _db.collection("users").doc(userId).get();
    } catch (e) {
      print("Error fetching user data: $e");
      return null;
    }
  }
}