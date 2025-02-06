import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'firebase_options.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await initializeFirebase();
  runApp(MyApp());
}

Future<void> initializeFirebase() async {
  if (Firebase.apps.isNotEmpty) {
    debugPrint("⚠️ Firebase already initialized.");
    return;
  }

  try {
    await Firebase.initializeApp(
      options: DefaultFirebaseOptions.currentPlatform,
    );
    debugPrint("✅ Firebase initialized successfully");
  } catch (e, stackTrace) {
    debugPrint("🔥 Firebase initialization error: $e");
    debugPrint("📌 Stack Trace:\n$stackTrace");
    rethrow;
  }
}

class MyApp extends StatefulWidget {
  @override
  _MyAppState createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  bool _isFirebaseInitialized = false;
  String _errorMessage = "";

  @override
  void initState() {
    super.initState();
    initializeFirebase().then((_) {
      setState(() {
        _isFirebaseInitialized = true;
      });
    }).catchError((e, stackTrace) {
      setState(() {
        _errorMessage = "Error: $e\nStackTrace:\n$stackTrace";
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Twitch Stream Tracker',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: _isFirebaseInitialized
          ? MyHomePage()
          : Scaffold(
        body: Center(
          child: Padding(
            padding: EdgeInsets.all(16.0),
            child: _errorMessage.isEmpty
                ? CircularProgressIndicator()
                : Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text("🔥 Firebase Init Failed:",
                    style: TextStyle(
                        fontSize: 18, fontWeight: FontWeight.bold)),
                SizedBox(height: 10),
                SelectableText(_errorMessage,
                    style: TextStyle(color: Colors.red)),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

class MyHomePage extends StatefulWidget {
  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;
  List<Map<String, dynamic>> _streams = [];

  @override
  void initState() {
    super.initState();
    fetchStreamHistory();
  }

  Future<void> fetchStreamHistory() async {
    try {
      QuerySnapshot querySnapshot =
      await _firestore.collection("stream_history").get();
      setState(() {
        _streams = querySnapshot.docs
            .map((doc) => doc.data() as Map<String, dynamic>)
            .toList();
      });
    } catch (e) {
      debugPrint("🔥 Error fetching stream history: $e");
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Twitch Stream Tracker"),
      ),
      body: _streams.isEmpty
          ? Center(child: CircularProgressIndicator())
          : ListView.builder(
        itemCount: _streams.length,
        itemBuilder: (context, index) {
          var stream = _streams[index];
          return ListTile(
            title: Text(stream["title"] ?? "No Title"),
            subtitle: Text("Game: ${stream["game"]}, Viewers: ${stream["viewer_count"]}"),
          );
        },
      ),
    );
  }
}
