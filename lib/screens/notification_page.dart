import 'package:flutter/material.dart';
import 'package:team_builder/services/auth_methods.dart';

class NotificationPage extends StatefulWidget {
  @override
  _NotificationPageState createState() => _NotificationPageState();
}

class _NotificationPageState extends State<NotificationPage> {
  List<String> notifications = [
    "John liked your post",
    "Mary commented on your post",
    "James started following you",
    "Alex mentioned you in a comment"
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Notifications"),
      ),
      body: ListView.builder(
        itemCount: notifications.length,
        itemBuilder: (BuildContext context, int index) {
          return ListTile(
            leading: CircleAvatar(
              backgroundImage: NetworkImage(
                  "https://picsum.photos/seed/${notifications[index]}/50"),
            ),
            title: Text(
              notifications[index],
              style: const TextStyle(fontWeight: FontWeight.bold),
            ),
            subtitle: const Text("1h ago"),
            trailing: const Icon(Icons.more_vert),
            onTap: () async {
              await AuthMethods().signOut();
              // handle notification tap
            },
          );
        },
      ),
    );
  }
}
