import 'dart:io';
import 'package:e_bus_tracker/model/passenger.dart';
import 'package:e_bus_tracker/passenger/edit_Passenger_Profile.dart';
import 'package:e_bus_tracker/passenger/pRatings.dart';
import 'package:e_bus_tracker/passenger/passengerhome.dart';
import 'package:e_bus_tracker/passenger/viewSchedule.dart';
import 'package:e_bus_tracker/services/getuserauth.dart';
import 'package:e_bus_tracker/login.dart';
import 'package:e_bus_tracker/services/firebase_services.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import '../bus_operator/navigation/bottom_navigation.dart';

class ProfileTypeScreenP extends StatefulWidget {
  const ProfileTypeScreenP({super.key});

  @override
  State<ProfileTypeScreenP> createState() => _ProfileTypeScreenPState();
}

class _ProfileTypeScreenPState extends State<ProfileTypeScreenP> {
  int _currentIndex = 3;

  late Future<UserDetailsP> futuredata;

  String? image = '';
  String? name = '';
  String? home = '';
  String? phone = '';
  String? email = '';
  File? imageXFile;

  final AuthService _authService = AuthService();

  @override
  void initState() {
    futuredata = AuthService().getUserProfile();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.deepPurple,
        title: const Text("Profile"),
        actions: [
          IconButton(
            icon: const Icon(Icons.logout),
            onPressed: () async {
              await FirebaseServices().signOutUser();
              FirebaseAuth.instance.signOut().then((value) {
                print("Signed Out");
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => const Login(),
                  ),
                );
              });
            },
          ),
        ],
      ),
      body: FutureBuilder(
          future: futuredata,
          builder: (context, snapshot) {
            if (snapshot.connectionState == ConnectionState.waiting) {
              return const CircularProgressIndicator();
            } else if (snapshot.hasError) {
              return Text('Error: ${snapshot.error}');
            } else if (!snapshot.hasData || snapshot.data == null) {
              // Handle the case where snapshot.data is null or not available
              return const Text('No data available');
            } else {
              final data = snapshot.data as UserDetailsP;
              return ListView(
                shrinkWrap: true,
                children: [
                  Padding(
                    padding: const EdgeInsets.symmetric(
                      horizontal: 45.0,
                    ),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        const SizedBox(
                          height: 28,
                        ),
                        GestureDetector(
                          onTap: () {
                            //showImageDialog
                          },
                          child: CircleAvatar(
                            backgroundColor: Colors.deepPurpleAccent,
                            minRadius: 70.0,
                            child: CircleAvatar(
                              radius: 67.0,
                              backgroundImage: imageXFile == null
                                  ? (data.profileImageURL != null &&
                                          data.profileImageURL!.isNotEmpty
                                      ? NetworkImage(data.profileImageURL!)
                                      : const AssetImage(
                                              'assets/images/placeholder_image.png')
                                          as ImageProvider)
                                  : Image.file(imageXFile!).image,
                            ),
                          ),
                        ),
                        const SizedBox(
                          height: 5.0,
                        ),
                        Text(
                          (data.name ?? ''),
                          style: const TextStyle(
                            fontSize: 20.0,
                            fontWeight: FontWeight.bold,
                            color: Colors.black,
                          ),
                        ),
                        const SizedBox(
                          height: 40,
                        ),
                        Container(
                          padding: const EdgeInsets.all(10.0),
                          decoration: BoxDecoration(
                              border: Border.all(
                            color: Colors.deepPurpleAccent,
                            width: 2.0,
                          )),
                          child: Row(
                            children: [
                              const Text(
                                'Name : ',
                                style: TextStyle(
                                  fontSize: 16.0,
                                  fontWeight: FontWeight.w500,
                                  color: Colors.black,
                                ),
                              ),
                              Expanded(
                                child: Text(
                                  data.name ?? '',
                                  style: const TextStyle(
                                    fontSize: 16.0,
                                    fontWeight: FontWeight.w400,
                                    color: Colors.black,
                                  ),
                                ),
                              )
                            ],
                          ),
                        ),
                        const Divider(),
                        Container(
                          padding: const EdgeInsets.all(10.0),
                          decoration: BoxDecoration(
                              border: Border.all(
                            color: Colors.deepPurpleAccent,
                            width: 2.0,
                          )),
                          child: Row(
                            children: [
                              const Text(
                                'Email : ',
                                style: TextStyle(
                                  fontSize: 16.0,
                                  fontWeight: FontWeight.w500,
                                  color: Colors.black,
                                ),
                              ),
                              Expanded(
                                child: Text(
                                  data.email ?? '',
                                  style: const TextStyle(
                                    fontSize: 16.0,
                                    fontWeight: FontWeight.w400,
                                    color: Colors.black,
                                  ),
                                ),
                              )
                            ],
                          ),
                        ),
                        const Divider(),
                        Container(
                          padding: const EdgeInsets.all(10.0),
                          decoration: BoxDecoration(
                              border: Border.all(
                            color: Colors.deepPurpleAccent,
                            width: 2.0,
                          )),
                          child: Row(
                            children: [
                              const Text(
                                'Address : ',
                                style: TextStyle(
                                  fontSize: 16.0,
                                  fontWeight: FontWeight.w500,
                                  color: Colors.black,
                                ),
                              ),
                              Expanded(
                                child: Text(
                                  data.homeAddress ?? '',
                                  style: const TextStyle(
                                    fontSize: 16.0,
                                    fontWeight: FontWeight.w400,
                                    color: Colors.black,
                                  ),
                                ),
                              )
                            ],
                          ),
                        ),
                        const Divider(),
                        Container(
                          padding: const EdgeInsets.all(10.0),
                          decoration: BoxDecoration(
                              border: Border.all(
                            color: Colors.deepPurpleAccent,
                            width: 2.0,
                          )),
                          child: Row(
                            children: [
                              const Text(
                                'Phone : ',
                                style: TextStyle(
                                  fontSize: 16.0,
                                  fontWeight: FontWeight.w500,
                                  color: Colors.black,
                                ),
                              ),
                              Expanded(
                                child: Text(
                                  data.phoneNumber ?? '',
                                  style: const TextStyle(
                                    fontSize: 16.0,
                                    fontWeight: FontWeight.w400,
                                    color: Colors.black,
                                  ),
                                ),
                              )
                            ],
                          ),
                        ),
                        const Divider(),
                        const SizedBox(height: 30),
                        SizedBox(
                          width: 300.0,
                          child: Align(
                            alignment: Alignment.center,
                            child: ElevatedButton(
                              onPressed: () {
                                Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                        builder: (context) =>
                                            const PassengerProfileEditScreen()));
                              },
                              style: ElevatedButton.styleFrom(
                                foregroundColor: Colors.white, backgroundColor: Colors.deepPurple,
                                shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(14),
                                ),
                              ),
                              child: const Padding(
                                padding: EdgeInsets.all(12.0),
                                child: Text(
                                  "Edit",
                                  style: TextStyle(fontSize: 18),
                                ),
                              ),
                            ),
                          ),
                        ),
                        const SizedBox(height: 20.0),
                      ],
                    ),
                  ),
                ],
              );
            }
          }),
      bottomNavigationBar: BottomNavigation(
        currentIndex: _currentIndex,
        onTabTapped: (index) {
          setState(() {
            _currentIndex = index;
            if (index == 0) {
              // Navigate to home
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => const PassengerHomeScreen(),
                ),
              );
            } else if (index == 1) {
              // Navigate to schedule
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => const PassengerScheduleScreen(),
                ),
              );
            } else if (index == 2) {
              // Navigate to star
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => const PRatingScreen(),
                ),
              );
            } else if (index == 3) {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => const ProfileTypeScreenP(),
                ),
              );
            }
          });
        },
      ),
    );
  }
}