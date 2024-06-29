import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:task_app/core/constants/app_colors.dart';
import 'package:task_app/widget/porfile_folder/textBoxPro.dart';
import 'package:task_app/widget/common/custom_bottom_navigation_bar.dart';

class ProfileScreen extends StatefulWidget {
  const ProfileScreen({Key? key}) : super(key: key);

  @override
  State<ProfileScreen> createState() => _ProfileScreenState();
}

class _ProfileScreenState extends State<ProfileScreen> {
  late User? currentUser;
  DocumentSnapshot<Map<String, dynamic>>? userData;
  bool isLoading = true;

  @override
  void initState() {
    super.initState();
    currentUser = FirebaseAuth.instance.currentUser;
    if (currentUser != null) {
      _fetchUserData(currentUser!.uid);
    }
  }

  Future<void> _fetchUserData(String uid) async {
    try {
      DocumentSnapshot<Map<String, dynamic>> userDocument =
          await FirebaseFirestore.instance.collection('users').doc(uid).get();
      setState(() {
        userData = userDocument;
        isLoading = false;
      });
    } catch (e) {
      print('Error fetching user data: $e');
      setState(() {
        isLoading = false;
      });
    }
  }

  // Edit field function (placeholder)
  Future<void> editfield(String field) async {
    // Implementation for editing fields
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        title: Text('PROFILE', style: TextStyle(color: Colors.black)),
        backgroundColor: AppColors.primary,
      ),
      body: isLoading
          ? Center(child: CircularProgressIndicator())
          : currentUser != null
              ? ListView(
                  children: [
                    const SizedBox(height: 50),
                    // Profile picture
                    Center(
                      child: CircleAvatar(
                        radius: 50.0, // Adjust the radius to the desired size
                        backgroundColor: Colors.white,
                        backgroundImage: userData?['profileImage'] != null
                            ? AssetImage(userData!['profileImage']) // Use NetworkImage if URL is from the network
                            : AssetImage('assets/images/default_avatar.png') as ImageProvider, // Default avatar
                        // Ensure the image scales properly within the CircleAvatar
                        child: ClipOval(
                          child: userData?['profileImage'] != null
                              ? Image.asset(
                                  userData!['profileImage'],
                                  fit: BoxFit.cover,
                                  width: 100.0,
                                  height: 100.0,
                                )
                              : Image.asset(
                                  'assets/images/default_avatar.png',
                                  fit: BoxFit.cover,
                                  width: 100.0,
                                  height: 100.0,
                                ),
                        ),
                      ),
                    ),
                    const SizedBox(height: 10),
                    // User email
                    Text(
                      currentUser!.email ?? 'No email available',
                      textAlign: TextAlign.center,
                      style: TextStyle(color: Colors.black, fontSize: 20.0),
                    ),
                    const SizedBox(height: 20),
                    // User details
                    Padding(
                      padding: const EdgeInsets.only(left: 20.0),
                      child: Text(
                        'My Details',
                        style: TextStyle(color: Colors.black),
                      ),
                    ),
                    // Text boxes for username and email
                    textBOXS(
                      text: 'Username',
                      sectionName: 'username',
                      onPressed: () => editfield('username'),
                    ),
                    textBOXS(
                      text: 'Email',
                      sectionName: 'email',
                      onPressed: () => editfield('email'),
                    ),
                  ],
                )
              : Center(child: Text('No user data available')),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
      bottomNavigationBar: const CustomBottomNavigationBar(),
    );
  }
}
