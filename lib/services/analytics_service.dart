import 'package:cloud_firestore/cloud_firestore.dart';

class AnalyticsService {
  final FirebaseFirestore _db = FirebaseFirestore.instance;

  Future<void> logStreamAnalytics(String userId, Map<String, dynamic> analyticsData) async {
    try {
      await _db.collection("analytics").doc(userId).set(analyticsData, SetOptions(merge: true));
    } catch (e) {
      print("Error logging analytics: $e");
    }
  }

  Future<Map<String, dynamic>?> getAnalytics(String userId) async {
    try {
      var doc = await _db.collection("analytics").doc(userId).get();
      return doc.exists ? doc.data() : null;
    } catch (e) {
      print("Error fetching analytics: $e");
      return null;
    }
  }
}