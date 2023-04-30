import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'package:team_builder/providers/user_provider.dart';
import 'package:team_builder/utils/colors.dart';
// import '../models/user_model.dart' as model;

import '../resources/auth_methods.dart';

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
          ListTile(
            selected: true,
            leading: const CircleAvatar(
              backgroundImage: NetworkImage(
                  'https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcRmmO7Z5y-L4RuYKFxH0b6qFPA1BvnUA6Z_t4bBkpzWh_8mpD34Z-0Qo21dJ0jQpHhmJQU&usqp=CAU'),
            ),
            title: const Text("Home"),
            onTap: () => Navigator.of(context).pushReplacement(
              MaterialPageRoute(
                builder: (context) => const DeleteThisLater(), // Add Function
              ),
            ),
          ),
          ListTile(
            leading: const CircleAvatar(
              radius: 18,
              backgroundImage: NetworkImage(
                  'https://img.freepik.com/free-icon/verification-delivery-list-clipboard-symbol_318-61556.jpg'),
            ),
            title: const Text('Tasks'),
            onTap: () {
              // TODO: Add tasks page navigation
            },
          ),
          ListTile(
            leading: const CircleAvatar(
              radius: 18,
              backgroundImage: NetworkImage(
                  'https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcQYAXUsI9H_YUIMdooaoGA_oBUoZbdY19XFPcrUWnV62w&s'),
            ),
            title: Text('Team Members'),
            onTap: () {
              // TODO: Add team members page navigation
            },
          ),
          ListTile(
            leading: const CircleAvatar(
              backgroundImage: NetworkImage(
                  'https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcQTHdD1Zgm522dOopQyqQHigiOBJjiMHlYhhf9FY3A5Jw&s'),
            ),
            title: const Text("Profile"),
            onTap: () {
              Navigator.of(context).push(
                MaterialPageRoute(
                  builder: (context) => const DeleteThisLater(), // Add Function
                ),
              );
            },
          ),
          ListTile(
            leading: const CircleAvatar(
              backgroundImage: NetworkImage(
                  'https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcTmrFWTQs_rQd9JgmpochyeBFZpq3tixY-w7uycL-wfWg&s'),
            ),
            title: Text('Settings'),
            onTap: () {
              // TODO: Add settings page navigation
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
              await AuthMethods().signOut();
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
