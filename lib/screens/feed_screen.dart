import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:team_builder/models/user_model.dart' as model;

import 'package:team_builder/widgets/drawer.dart';
import 'package:team_builder/widgets/postcard.dart';
import '../models/user_model.dart' as model;
import '../providers/user_provider.dart';

import '../resources/auth_methods.dart';
import '../utils/colors.dart';
import '../utils/constant.dart';
import '../widgets/post_card.dart';

class FeedScreen extends StatefulWidget {
  const FeedScreen({Key? key}) : super(key: key);

  @override
  State<FeedScreen> createState() => FeedScreenState();
}

class FeedScreenState extends State<FeedScreen> {
  String name = " ";
  @override
  void initState() {
    super.initState();
    getUserDetais();
  }

  void getUserDetais() async {
    DocumentSnapshot snap = await FirebaseFirestore.instance
        .collection('users')
        .doc(FirebaseAuth.instance.currentUser!.uid)
        .get();

    setState(() {
      name = (snap.data() as Map<String, dynamic>)['name'];
    });

    // debugPrint(snap.data().toString());
  }

  @override
  Widget build(BuildContext context) {
    final width = MediaQuery.of(context).size.width;
    // model.User user = Provider.of<UserProvider>(context).getUser;

    return Scaffold(
      appBar: width > webScreenSize
          ? null
          : AppBar(
              // centerTitle: true,
              title: SizedBox(
                width: width * 0.4,
                child: Image.asset(
                  "images/TeamovaHeaderStrip.png",
                  // color: primaryColor,
                  // height: 32,
                  fit: BoxFit.cover,
                ),
              ),
              actions: [
                IconButton(
                  icon: const Icon(
                    Icons.messenger_outline,
                    color: primaryColor,
                  ),
                  onPressed: () {},
                ),
              ],
            ),
      drawer: const NavigationDrawer(),
      body: PostCard(
        userName: name,
        userImagePath:
            'https://images.unsplash.com/photo-1494790108377-be9c29b29330?ixlib=rb-4.0.3&ixid=MnwxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8&auto=format&fit=crop&w=2574&q=80',
        teamName: 'Sexy Team',
        postImagesPaths: const [
          'https://images.unsplash.com/photo-1594590438588-aadc19454cb0?ixlib=rb-4.0.3&ixid=MnwxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8&auto=format&fit=crop&w=2574&q=80',
          'https://images.unsplash.com/photo-1606792109963-7b34205b1333?ixlib=rb-4.0.3&ixid=MnwxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8&auto=format&fit=crop&w=774&q=80',
          'https://images.unsplash.com/photo-1544963151-fb47c1a06478?ixlib=rb-4.0.3&ixid=MnwxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8&auto=format&fit=crop&w=774&q=80',
        ],
        teamLinks: const [
          'www.google.com',
          'www.xvideos.com',
        ],
        description:
            "Lorem ipsum dolor sit amet, consectetur adipiscing elit, sed do eiusmod tempor incididunt ut labore et dolore magna aliqua. Ut enim ad minim veniam, quis nostrud exercitation ullamco laboris nisi ut aliquip ex ea commodo consequat. Duis aute irure dolor in reprehenderit in voluptate velit esse cillum dolore eu fugiat nulla pariatur. Excepteur sint occaecat cupidatat non proident, sunt in culpa qui officia deserunt mollit anim id est laborum.",
      ),

      // body: Center(
      //   //child: Text("hello"),
      //   child: StreamBuilder(
      //     stream: FirebaseFirestore.instance.collection('posts').snapshots(),
      //     builder: (context,
      //         AsyncSnapshot<QuerySnapshot<Map<String, dynamic>>> snapshot) {
      //       if (snapshot.connectionState == ConnectionState.waiting) {
      //         return const Center(
      //           child: CircularProgressIndicator(),
      //         );
      //       }
      //       return ListView.builder(
      //         itemCount: snapshot.data!.docs.length,
      //         itemBuilder: (ctx, index) => Container(
      //           margin: EdgeInsets.symmetric(
      //             horizontal: width > webScreenSize ? width * 0.3 : 0,
      //             vertical: width > webScreenSize ? 15 : 0,
      //           ),
      //           child: PostCard(
      //             snap: snapshot.data!.docs[index].data(),
      //           ),
      //         ),
      //       );
      //     },
      //   ),
      // ),
    );
  }
}
