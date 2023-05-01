import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

import 'package:provider/provider.dart';

import '../models/user_model.dart';
import '../providers/user_provider.dart';
import '../services/firestore_methods.dart';
import '../utils/colors.dart';
import '../utils/utils.dart';
import '../widgets/comment_card.dart';

class CommentsScreen extends StatefulWidget {
  final postId;
  const CommentsScreen({Key? key, required this.postId}) : super(key: key);

  @override
  _CommentsScreenState createState() => _CommentsScreenState();
}

class _CommentsScreenState extends State<CommentsScreen> {
  final TextEditingController commentEditingController =
      TextEditingController();
  @override
  void dispose() {
    commentEditingController.dispose();
    super.dispose();
  }

  void postComment(String uid, String name, String profilePic) async {
    try {
      // ..calling to  firestore method postconnent
      String res = await FireStoreMethods().postComment(
        widget.postId,
        commentEditingController.text,
        uid,
        name,
        profilePic,
      );

      if (res != 'success') {
        showSnackBar(context, res);
      }
      setState(() {
        commentEditingController.text = "";
      });
    } catch (err) {
      showSnackBar(
        context,
        err.toString(),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    //because we need only user info in this page so we are using provider

    final UserModel user = Provider.of<UserProvider>(context)
        .getUser; //getting current user details

    return Scaffold(
      appBar: AppBar(
        backgroundColor: mobileBackgroundColor,
        title: const Text(
          'Comments',
        ),
        centerTitle: false,
      ),
      body: StreamBuilder(
        stream: FirebaseFirestore.instance
            .collection('posts')
            .doc(widget.postId)
            .collection('comments')
            .snapshots(),
        builder: (context,
            AsyncSnapshot<QuerySnapshot<Map<String, dynamic>>> snapshot) {
          // if (snapshot.connectionState == ConnectionState.waiting) {
          //   return const Center(
          //     child:,
          //   );
          // }

          return ListView.builder(
            itemCount: snapshot.data!.docs.length,
            itemBuilder: (ctx, index) => CommentCard(
              //docs is how many document will contains by this collection
              snap: snapshot
                  .data!.docs[index], //this will contain all the data of docs
              //fields respective to the commentId(indexed)
            ),
          );
        },
      ),
      // text input
      bottomNavigationBar: Container(
        decoration: BoxDecoration(
          color: Colors.white,
          boxShadow: [
            BoxShadow(
              color: Colors.grey.withOpacity(0.3),
              blurRadius: 10,
              offset: const Offset(0, -5),
            ),
          ],
        ),
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
          child: Row(
            children: [
              Container(
                height: 36,
                width: 36,
                decoration: BoxDecoration(
                  shape: BoxShape.circle,
                  image: DecorationImage(
                    image: NetworkImage(user.photoUrl),
                  ),
                ),
              ),
              const SizedBox(width: 16),
              Expanded(
                child: TextFormField(
                  onTap: () {},
                  controller: commentEditingController,
                  decoration: InputDecoration(
                    hintText: 'Comment as ${user.name}',
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(24),
                      borderSide: BorderSide.none,
                    ),
                    filled: true,
                    fillColor: Colors.grey.withOpacity(0.1),
                  ),
                ),
              ),
              const SizedBox(width: 16),
              InkWell(
                onTap: () => postComment(
                  user.uid,
                  user.name,
                  user.phoneNo,
                ),
                child: Container(
                  height: 36,
                  padding:
                      const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
                  decoration: BoxDecoration(
                    color: Colors.blue,
                    borderRadius: BorderRadius.circular(24),
                  ),
                  child: const Text(
                    'Post',
                    style: TextStyle(color: Colors.white),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
