class AnalyticsModel {
  final int totalWatchTime;
  final int totalFollowers;
  final int totalStreams;
  final double averageViewers;

  AnalyticsModel({
    required this.totalWatchTime,
    required this.totalFollowers,
    required this.totalStreams,
    required this.averageViewers,
  });

  factory AnalyticsModel.fromJson(Map<String, dynamic> json) {
    return AnalyticsModel(
      totalWatchTime: json['total_watch_time'] ?? 0,
      totalFollowers: json['total_followers'] ?? 0,
      totalStreams: json['total_streams'] ?? 0,
      averageViewers: json['average_viewers']?.toDouble() ?? 0.0,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'total_watch_time': totalWatchTime,
      'total_followers': totalFollowers,
      'total_streams': totalStreams,
      'average_viewers': averageViewers,
    };
  }
}