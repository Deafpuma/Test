import 'package:flutter/material.dart';
import '../services/api_service.dart';

class AnalyticsScreen extends StatefulWidget {
  @override
  _AnalyticsScreenState createState() => _AnalyticsScreenState();
}

class _AnalyticsScreenState extends State<AnalyticsScreen> {
  final ApiService _apiService = ApiService();
  Map<String, dynamic>? analyticsData;

  @override
  void initState() {
    super.initState();
    fetchAnalytics();
  }

  Future<void> fetchAnalytics() async {
    var data = await _apiService.fetchTwitchData("analytics");
    setState(() {
      analyticsData = data;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text("Twitch Analytics")),
      body: analyticsData == null
          ? Center(child: CircularProgressIndicator())
          : ListView(
              children: [
                ListTile(
                  title: Text("Total Watch Time: ${analyticsData!["total_watch_time"]}"),
                ),
                ListTile(
                  title: Text("Total Followers: ${analyticsData!["total_followers"]}"),
                ),
                ListTile(
                  title: Text("Average Viewers: ${analyticsData!["average_viewers"]}"),
                ),
              ],
            ),
    );
  }
}