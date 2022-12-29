import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:team_builder/models/user_model.dart';
import 'package:team_builder/providers/user_provider.dart';

import '../resources/auth_methods.dart';

class NavigationDrawer extends StatelessWidget {
  const NavigationDrawer({super.key});

  @override
  Widget build(BuildContext context) {
    final User _user = Provider.of<UserProvider>(context).getUser;
    return Drawer(
      child: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: <Widget>[
            buildHeader(context, _user.name, _user.email),
            buildMenuItems(context),
          ],
        ),
      ),
    );
  }

  Widget buildHeader(BuildContext context, String name, String email) {
    return Container(
      color: Colors.blue.shade700,
      padding: EdgeInsets.only(
        top: 15 + MediaQuery.of(context).padding.top,
        bottom: 15,
      ),
      child: Column(
        children: [
          const CircleAvatar(
            radius: 45,
            backgroundImage: NetworkImage(
                'https://images.unsplash.com/photo-1494790108377-be9c29b29330?ixlib=rb-4.0.3&ixid=MnwxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8&auto=format&fit=crop&w=2574&q=80'),
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
            leading: const Icon(Icons.home_outlined),
            title: const Text("Home"),
            onTap: () => Navigator.of(context).pushReplacement(
              MaterialPageRoute(
                builder: (context) => const DeleteThisLater(), // Add Function
              ),
            ),
          ),
          ListTile(
            leading: const Icon(Icons.person_outlined),
            title: const Text("Profile"),
            onTap: () {
              Navigator.pop(context);
              Navigator.of(context).push(
                MaterialPageRoute(
                  builder: (context) => const DeleteThisLater(), // Add Function
                ),
              );
            },
          ),
          const Divider(
            color: Colors.black54,
          ),
          ListTile(
            leading: const Icon(Icons.lock_outlined),
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
