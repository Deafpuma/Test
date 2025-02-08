import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import '../services/auth_service.dart';

class ProfileScreen extends StatelessWidget {
  final AuthService _authService = AuthService();
  final User? user = FirebaseAuth.instance.currentUser;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text("Profile")),
      body: Center(
        child: user == null
            ? Text("Not logged in")
            : Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  CircleAvatar(
                    backgroundImage: NetworkImage(user!.photoURL ?? ''),
                    radius: 50,
                  ),
                  SizedBox(height: 10),
                  Text("Username: ${user!.displayName}"),
                  SizedBox(height: 10),
                  Text("Email: ${user!.email}"),
                  SizedBox(height: 20),
                  ElevatedButton(
                    onPressed: () async {
                      await _authService.signOut();
                      Navigator.pushReplacementNamed(context, '/login');
                    },
                    child: Text("Logout"),
                  ),
                ],
              ),
      ),
    );
  }
}