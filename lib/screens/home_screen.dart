import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class HomeScreen extends StatefulWidget {
  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  final FirebaseFirestore _db = FirebaseFirestore.instance;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text("Twitch Affiliate Tracker")),
      body: StreamBuilder(
        stream: _db.collection("streams").snapshots(),
        builder: (context, AsyncSnapshot<QuerySnapshot> snapshot) {
          if (!snapshot.hasData) {
            return Center(child: CircularProgressIndicator());
          }
          var streams = snapshot.data!.docs;
          return ListView.builder(
            itemCount: streams.length,
            itemBuilder: (context, index) {
              var stream = streams[index];
              return ListTile(
                title: Text(stream['title']),
                subtitle: Text("Viewers: ${stream['viewer_count']}"),
              );
            },
          );
        },
      ),
    );
  }
}