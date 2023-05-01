import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/container.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:team_builder/widgets/post_card.dart';

class TeamsPost extends StatefulWidget {
  final uid;
  TeamsPost({required this.uid, super.key});

  @override
  State<TeamsPost> createState() => _TeamsPostState();
}

class _TeamsPostState extends State<TeamsPost> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Posts'),
        centerTitle: true,
      ),
      body: FutureBuilder(
        future: FirebaseFirestore.instance
            .collection('posts')
            .where('uid', isEqualTo: widget.uid)
            .get(),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(
              child: CircularProgressIndicator(),
            );
          }
          if ((snapshot.data! as dynamic).docs.length == 0) {
            return const Center(
              child: Text('No post Yet,\n Go back'),
            );
          }

          return ListView.builder(
            shrinkWrap: true,
            itemCount: (snapshot.data! as dynamic).docs.length,
            itemBuilder: (context, index) {
              DocumentSnapshot snap = (snapshot.data! as dynamic).docs[index];

              return Expanded(
                child: PostCard(
                  snap: snap.data(),
                ),
              );
            },
          );
        },
      ),
    );
  }
}
