// NAME: Ieskandar Zulqarnain Bin Ghazali
// MATRIC NO: A20EC0046
// COURSE: SECJ3623-01(MOBILE APPLICATION PROGRAMMING)

import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_storage/firebase_storage.dart';

class ProfilePage extends StatefulWidget {
  @override
  _ProfilePageState createState() => _ProfilePageState();
}

class _ProfilePageState extends State<ProfilePage> {
  final FirebaseAuth _auth = FirebaseAuth.instance;
  User? _user;
  String? _displayName;
  String? _username;
  String? _email;
  String? _profileImageURL;

  Future<void> _fetchUserData() async {
    final User? user = _auth.currentUser;
    if (user != null) {
      final DocumentSnapshot userDataSnapshot = await FirebaseFirestore.instance
          .collection('users')
          .doc(user.uid)
          .get();

      setState(() {
        _user = user;
        _displayName = userDataSnapshot.get('displayName');
        _username = userDataSnapshot.get('username');
        _email = userDataSnapshot.get('email');
        _profileImageURL = userDataSnapshot.get('photoURL');
      });
    }
  }

  @override
  void initState() {
    super.initState();
    _fetchUserData();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Profile'),
      ),
      body: _user != null
          ? Center(
              // Wrap the content with Center
              child: Padding(
                padding: const EdgeInsets.all(16.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    CircleAvatar(
                      radius: 60,
                      backgroundImage: _profileImageURL != null
                          ? NetworkImage(_profileImageURL!)
                          : null,
                      child: _profileImageURL == null
                          ? const Icon(
                              Icons.person,
                              size: 60,
                            )
                          : null,
                    ),
                    const SizedBox(height: 16.0),
                    Text(
                      _displayName ?? '',
                      style: const TextStyle(
                        fontSize: 24.0,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    const SizedBox(height: 8.0),
                    Text(
                      _username ?? '',
                      style: const TextStyle(
                        fontSize: 18.0,
                        color: Colors.grey,
                      ),
                    ),
                    const SizedBox(height: 16.0),
                    Text(
                      'Email: $_email',
                      style: const TextStyle(
                        fontSize: 16.0,
                      ),
                    ),
                  ],
                ),
              ),
            )
          : const Center(
              child: CircularProgressIndicator(),
            ),
    );
  }
}
