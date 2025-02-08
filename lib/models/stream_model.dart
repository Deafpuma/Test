class StreamModel {
  final String id;
  final String title;
  final String game;
  final int viewers;
  final DateTime startedAt;

  StreamModel({
    required this.id,
    required this.title,
    required this.game,
    required this.viewers,
    required this.startedAt,
  });

  factory StreamModel.fromJson(Map<String, dynamic> json) {
    return StreamModel(
      id: json['id'],
      title: json['title'],
      game: json['game_name'],
      viewers: json['viewer_count'] ?? 0,
      startedAt: DateTime.parse(json['started_at']),
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'title': title,
      'game_name': game,
      'viewer_count': viewers,
      'started_at': startedAt.toIso8601String(),
    };
  }
}