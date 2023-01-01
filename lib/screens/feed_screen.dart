import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:provider/provider.dart';
import 'package:team_builder/widgets/drawer.dart';
import '../models/user_model.dart' as model;
import '../providers/user_provider.dart';
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
        body: Center(
          //child: Text("hello"),
          child: Text(name),
        )
        // StreamBuilder(
        //   stream: FirebaseFirestore.instance.collection('posts').snapshots(),
        //   builder: (context,
        //       AsyncSnapshot<QuerySnapshot<Map<String, dynamic>>> snapshot) {
        //     if (snapshot.connectionState == ConnectionState.waiting) {
        //       return const Center(
        //         child: CircularProgressIndicator(),
        //       );
        //     }
        //     return ListView.builder(
        //       itemCount: snapshot.data!.docs.length,
        //       itemBuilder: (ctx, index) => Container(
        //         margin: EdgeInsets.symmetric(
        //           horizontal: width > webScreenSize ? width * 0.3 : 0,
        //           vertical: width > webScreenSize ? 15 : 0,
        //         ),
        //         child: PostCard(
        //           snap: snapshot.data!.docs[index].data(),
        //         ),
        //       ),
        //     );
        //   },
        //   ),
        );
  }
}
