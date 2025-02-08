import 'dart:convert';
import 'package:http/http.dart' as http;

class ApiService {
  final String baseUrl = "https://api.twitch.tv/helix";
  final String clientId = "YOUR_TWITCH_CLIENT_ID";
  final String authToken = "YOUR_AUTH_TOKEN";

  Future<Map<String, dynamic>?> fetchTwitchData(String endpoint) async {
    final response = await http.get(
      Uri.parse("$baseUrl/$endpoint"),
      headers: {
        "Client-ID": clientId,
        "Authorization": "Bearer $authToken",
      },
    );

    if (response.statusCode == 200) {
      return json.decode(response.body);
    } else {
      print("Twitch API Error: ${response.statusCode}");
      return null;
    }
  }
}