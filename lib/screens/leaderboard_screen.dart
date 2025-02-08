import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class LeaderboardScreen extends StatelessWidget {
  final FirebaseFirestore _db = FirebaseFirestore.instance;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text("Leaderboard")),
      body: StreamBuilder(
        stream: _db.collection("leaderboard").orderBy("support_score", descending: true).snapshots(),
        builder: (context, AsyncSnapshot<QuerySnapshot> snapshot) {
          if (!snapshot.hasData) {
            return Center(child: CircularProgressIndicator());
          }
          var leaders = snapshot.data!.docs;
          return ListView.builder(
            itemCount: leaders.length,
            itemBuilder: (context, index) {
              var leader = leaders[index];
              return ListTile(
                leading: CircleAvatar(
                  backgroundImage: NetworkImage(leader['profile_image_url']),
                ),
                title: Text(leader['username']),
                subtitle: Text("Support Score: ${leader['support_score']}"),
              );
            },
          );
        },
      ),
    );
  }
}