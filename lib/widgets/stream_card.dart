import 'package:flutter/material.dart';

class StreamCard extends StatelessWidget {
  final String title;
  final String game;
  final int viewers;
  final String thumbnailUrl;

  StreamCard({
    required this.title,
    required this.game,
    required this.viewers,
    required this.thumbnailUrl,
  });

  @override
  Widget build(BuildContext context) {
    return Card(
      child: ListTile(
        leading: Image.network(thumbnailUrl, width: 80, height: 50, fit: BoxFit.cover),
        title: Text(title),
        subtitle: Text("Game: $game | Viewers: $viewers"),
      ),
    );
  }
}