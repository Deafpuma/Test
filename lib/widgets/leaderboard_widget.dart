import 'package:flutter/material.dart';

class LeaderboardWidget extends StatelessWidget {
  final List<Map<String, dynamic>> leaders;

  LeaderboardWidget({required this.leaders});

  @override
  Widget build(BuildContext context) {
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
  }
}