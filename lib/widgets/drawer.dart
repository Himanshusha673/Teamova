import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'package:team_builder/providers/user_provider.dart';
import 'package:team_builder/screens/Help&suppout.dart';
import 'package:team_builder/screens/event_page.dart';
import 'package:team_builder/screens/leadership_page.dart';
import 'package:team_builder/screens/login.dart';
import 'package:team_builder/screens/my_tasks.dart';
import 'package:team_builder/screens/settingPage.dart';
import 'package:team_builder/screens/team_members_page.dart';
import 'package:team_builder/utils/colors.dart';
// import '../models/user_model.dart' as model;

import '../services/auth_methods.dart';

class MyDrawer extends StatefulWidget {
  const MyDrawer({super.key});

  @override
  State<MyDrawer> createState() => _MyDrawerState();
}

class _MyDrawerState extends State<MyDrawer> {
  bool isLoading = false;
  @override
  @override
  Widget build(BuildContext context) {
    final user = Provider.of<UserProvider>(context).getUser;
    // log("user.name");
    // log(user.name);
    // log(user.email);

    // log(user.photoUrl);

    return Drawer(
      child: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: <Widget>[
            buildHeader(context, user.name, user.email, user.photoUrl),
            buildMenuItems(context),
          ],
        ),
      ),
    );
  }

  Widget buildHeader(
      BuildContext context, String name, String email, String photoUrl) {
    return Container(
      color: mainColor,
      padding: EdgeInsets.only(
        top: 15 + MediaQuery.of(context).padding.top,
        bottom: 15,
      ),
      child: Column(
        children: [
          CircleAvatar(
            radius: 45,
            backgroundImage: NetworkImage(photoUrl),
          ),
          const SizedBox(
            height: 12,
          ),
          Text(
            name,
            style: const TextStyle(
                fontSize: 18, color: Colors.white, fontWeight: FontWeight.bold),
          ),
          Text(
            email,
            style: const TextStyle(
              fontSize: 12,
              color: Colors.white,
            ),
          ),
        ],
      ),
    );
  }

  Widget buildMenuItems(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(15),
      child: Wrap(
        runSpacing: 15,
        children: [
          //  'https://img.freepik.com/free-icon/verification-delivery-list-clipboard-symbol_318-61556.jpg'
          ListTile(
            leading: FadeInImage(
              placeholder: const AssetImage('assets/images/No-DP2.png'),
              image: const NetworkImage(
                  'https://img.freepik.com/free-icon/verification-delivery-list-clipboard-symbol_318-61556.jpg'),
              imageErrorBuilder: (context, error, stackTrace) {
                return const CircleAvatar(
                  child: Icon(Icons.error),
                );
              },
              fadeInDuration: const Duration(milliseconds: 300),
              fit: BoxFit.cover,
              width: 50,
              height: 50,
            ),
            title: const Text('Tasks'),
            onTap: () {
              Navigator.of(context).push(
                MaterialPageRoute(
                    builder: (BuildContext context) => const MyTasksPage()),
              );
            },
          ),
          ListTile(
            leading: const CircleAvatar(
              radius: 18,
              backgroundImage: NetworkImage(
                  'https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcQYAXUsI9H_YUIMdooaoGA_oBUoZbdY19XFPcrUWnV62w&s'),
            ),
            title: const Text('Team Members'),
            onTap: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                    builder: (context) => const AnimatedTeamMembersPage(
                          members: [
                            'John Doe',
                            'Jane Smith',
                            'Alex Johnson',
                            'Samantha Lee',
                            'Michael Brown',
                            'Emily Davis',
                            'David Wilson',
                            'Avery Robinson',
                          ],
                        )),
              );
            },
          ),
          ListTile(
            leading: const CircleAvatar(
              radius: 18,
              backgroundImage: NetworkImage(
                  'https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcTmrFWTQs_rQd9JgmpochyeBFZpq3tixY-w7uycL-wfWg&s'),
            ),
            title: const Text('Settings'),
            onTap: () {
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => SettingsScreen()),
              );
            },
          ),
          ListTile(
            leading: Icon(Icons.event),
            title: Text('Events'),
            onTap: () {
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => EventPage()),
              );
            },
          ),
          ListTile(
            leading: Icon(Icons.leaderboard),
            title: Text('Leaderboard'),
            onTap: () {
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => LeaderboardPage()),
              );
            },
          ),
          ListTile(
            leading: const CircleAvatar(
              radius: 18,
              backgroundImage: NetworkImage(
                  'https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcSAQQSeSiPKfbkruJb9XyKdC5bn5j04Y87C5w&usqp=CAU'),
            ),
            title: const Text('Help & Support'),
            onTap: () {
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => HelpAndSupportPage()),
              );
            },
          ),
          const Divider(
            color: Colors.black54,
          ),
          ListTile(
            leading: const CircleAvatar(
              backgroundImage: NetworkImage(
                  'https://static.vecteezy.com/system/resources/previews/000/574/782/original/vector-logout-sign-icon.jpg'),
            ),
            title: const Text("Log Out"),
            onTap: () async {
              showDialog(
                context: context,
                builder: (BuildContext context) {
                  return AlertDialog(
                    title: const Text(
                      'Confirm Logout',
                      style: TextStyle(
                        fontSize: 24,
                        fontWeight: FontWeight.bold,
                        color: Colors.black,
                      ),
                    ),
                    content: Column(
                      mainAxisSize: MainAxisSize.min,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: const [
                        Text(
                          'Are you sure you want to log out?',
                          style: TextStyle(
                            fontSize: 18,
                            fontWeight: FontWeight.normal,
                            color: Colors.black,
                          ),
                        ),
                        SizedBox(height: 16),
                        Divider(
                          color: Colors.grey,
                        ),
                      ],
                    ),
                    actions: [
                      TextButton(
                        child: const Text(
                          'Cancel',
                          style: TextStyle(
                            fontSize: 18,
                            fontWeight: FontWeight.normal,
                            color: Colors.black,
                          ),
                        ),
                        onPressed: () {
                          Navigator.of(context).pop();
                        },
                      ),
                      TextButton(
                        child: const Text(
                          'Log Out',
                          style: TextStyle(
                            fontSize: 18,
                            fontWeight: FontWeight.bold,
                            color: Colors.red,
                          ),
                        ),
                        onPressed: () async {
                          await AuthMethods().signOut();
                          Navigator.of(context).pushAndRemoveUntil(
                            MaterialPageRoute(
                                builder: (BuildContext context) =>
                                    const LogInPage()),
                            (Route<dynamic> route) => false,
                          );
                        },
                      ),
                    ],
                  );
                },
              );
            }, // Add Function
          ),
        ],
      ),
    );
  }
}

class DeleteThisLater extends StatelessWidget {
  const DeleteThisLater({super.key});

  @override
  Widget build(BuildContext context) {
    return Container();
  }
}
