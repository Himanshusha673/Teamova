import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:team_builder/screens/chatPage.dart';
import 'package:team_builder/widgets/circularIndiacator.dart';
import 'package:team_builder/widgets/drawer.dart';
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
      backgroundColor: primaryColor,
      appBar: width > webScreenSize
          ? null
          : AppBar(
              //centerTitle: true,
              actions: [
                IconButton(
                  onPressed: () async {
                    Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context) => const ChatPage()));
                  },
                  icon: const Icon(
                    Icons.wechat_outlined,
                    size: 35,
                  ),
                )
              ],
              title: SizedBox(
                width: width * 0.4,
                child: Image.asset(
                  "images/TeamovaHeaderStrip.png",
                  // color: primaryColor,
                  // height: 32,
                  fit: BoxFit.cover,
                ),
              ),
            ),
      drawer: const MyDrawer(),
      body: Container(
        padding: const EdgeInsets.only(bottom: 2.0),
        child: Center(
          child: StreamBuilder(
            stream: FirebaseFirestore.instance
                .collection('posts')
                .orderBy("datePublished", descending: true)
                .snapshots(),
            builder: (context,
                AsyncSnapshot<QuerySnapshot<Map<String, dynamic>>> snapshot) {
              if (snapshot.connectionState == ConnectionState.waiting) {
                return const Center(
                  child: TeamCircularProgressIndicator(
                      teamIcon:
                          'https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcQYAXUsI9H_YUIMdooaoGA_oBUoZbdY19XFPcrUWnV62w&shttps://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcQYAXUsI9H_YUIMdooaoGA_oBUoZbdY19XFPcrUWnV62w&s',
                      size: 64.0,
                      color: Colors.black),
                );
              }
              return ListView.builder(
                itemCount: snapshot.data!.docs.length,
                itemBuilder: (ctx, index) => Container(
                  margin: EdgeInsets.symmetric(
                    horizontal: width > webScreenSize ? width * 0.3 : 0,
                    vertical: width > webScreenSize ? 15 : 0,
                  ),
                  child: PostCard(
                    snap: snapshot.data!.docs[index].data(),
                  ),
                ),
              );
            },
          ),
        ),
      ),
    );
  }
}
