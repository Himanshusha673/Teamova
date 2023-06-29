import 'dart:developer';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

import 'package:intl/intl.dart';
import 'package:provider/provider.dart';
import 'package:team_builder/screens/profile.dart';
import 'package:url_launcher/url_launcher.dart';

import '../models/user_model.dart';
import '../providers/user_provider.dart';
import '../services/firestore_methods.dart';
import '../screens/comments_screen.dart';
import '../utils/colors.dart';

import '../utils/utils.dart';
import 'circularIndiacator.dart';
import 'like_animation.dart';

class PostCard extends StatefulWidget {
  final dynamic? snap;
  const PostCard({
    Key? key,
    required this.snap,
  }) : super(key: key);

  @override
  State<PostCard> createState() => _PostCardState();
}

class _PostCardState extends State<PostCard> {
  int commentLen = 0;
  bool isLikeAnimating = false;
  bool isLoading = false;

  @override
  void initState() {
    super.initState();
    fetchCommentLen();
  }

  fetchCommentLen() async {
    try {
      QuerySnapshot snap = await FirebaseFirestore.instance
          .collection('posts')
          .doc(widget.snap['postId'])
          .collection('comments')
          .get();
      commentLen = snap.docs.length;
    } catch (err) {
      showSnackBar(
        context,
        err.toString(),
      );
    }
    setState(() {});
  }

  deletePost(String postId) async {
    try {
      await FireStoreMethods().deletePost(postId);
    } catch (err) {
      showSnackBar(
        context,
        err.toString(),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    final UserModel user = Provider.of<UserProvider>(context).getUser;
    final width = MediaQuery.of(context).size.width;

    return isLoading
        ? const Center(
            child: CircularProgressIndicator(),
          )
        : Container(
            // boundary needed for web

            decoration: BoxDecoration(
              border: Border.all(
                color: mainColor,
              ),
              gradient: const LinearGradient(
                begin: Alignment.topLeft,
                end: Alignment.bottomRight,
                colors: [
                  Colors.black,
                  Colors.black87,
                  Colors.black,
                ],
              ),
              borderRadius: const BorderRadius.all(Radius.circular(10)),
              color: mainColor,
            ),
            margin: EdgeInsets.symmetric(
              // vertical: 6,
              horizontal: width * 0.015,
            ).copyWith(top: 8),
            padding: const EdgeInsets.only(
              bottom: 7,
            ),
            child: Column(
              children: [
                Container(
                  padding: const EdgeInsets.symmetric(
                    vertical: 10.0,
                    horizontal: 16.0,
                  ),
                  decoration: const BoxDecoration(
                    borderRadius: BorderRadius.vertical(
                      top: Radius.circular(10),
                    ),
                    color: mainColor,
                    boxShadow: [
                      BoxShadow(
                        color: Colors.black,
                        blurRadius: 2.0,
                        offset: Offset(0, 2),
                      ),
                    ],
                  ),
                  child: GestureDetector(
                    onTap: () {
                      Navigator.of(context).push(MaterialPageRoute(
                        builder: (context) => ProfilePage(
                          uid: widget.snap['uid'],
                        ),
                      ));
                    },
                    child: Row(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        CircleAvatar(
                          radius: 24,
                          backgroundImage: NetworkImage(
                            widget.snap['profImage'].toString(),
                          ),
                        ),
                        const SizedBox(width: 16.0),
                        Expanded(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                widget.snap['username'].toString(),
                                style: const TextStyle(
                                  color: Colors.white,
                                  fontSize: 18.0,
                                  fontWeight: FontWeight.w500,
                                ),
                              ),
                              const SizedBox(height: 4.0),
                              // Text(
                              //   '  ${widget.snap['objective'].toString()}',
                              //   style: const TextStyle(
                              //     color: Colors.grey,
                              //     fontSize: 14.0,
                              //   ),
                              // ),
                            ],
                          ),
                        ),
                        if (widget.snap['uid'].toString() == user.uid)
                          IconButton(
                            onPressed: () {
                              showDialog(
                                useRootNavigator: false,
                                context: context,
                                builder: (context) {
                                  return Dialog(
                                    child: ListView(
                                      padding: const EdgeInsets.symmetric(
                                        vertical: 16.0,
                                        horizontal: 16.0,
                                      ),
                                      shrinkWrap: true,
                                      children: [
                                        const Text(
                                          'Delete post?',
                                          style: TextStyle(
                                            fontWeight: FontWeight.bold,
                                            fontSize: 18.0,
                                          ),
                                        ),
                                        const SizedBox(height: 16.0),
                                        TextButton(
                                          onPressed: () {
                                            Navigator.of(context).pop();
                                          },
                                          child: const Text(
                                            'Cancel',
                                            style: TextStyle(
                                              color: Colors.grey,
                                            ),
                                          ),
                                        ),
                                        TextButton(
                                          onPressed: () {
                                            deletePost(
                                              widget.snap['postId'].toString(),
                                            );
                                            Navigator.of(context).pop();
                                          },
                                          child: const Text(
                                            'Delete',
                                            style: TextStyle(
                                              color: Colors.red,
                                            ),
                                          ),
                                        ),
                                      ],
                                    ),
                                  );
                                },
                              );
                            },
                            icon: const Icon(Icons.delete_forever_outlined),
                            color: Colors.red,
                          ),
                      ],
                    ),
                  ),
                ),

                // IMAGE SECTION OF THE POST//
                GestureDetector(
                  onDoubleTap: () {
                    //calling when douletapped
                    FireStoreMethods().likePost(
                      widget.snap['postId'].toString(),
                      user.uid,
                      widget.snap['likes'],
                    );
                    setState(() {
                      isLikeAnimating = true;
                    });
                  },
                  child: Stack(
                    alignment: Alignment.center,
                    children: [
                      SizedBox(
                        height: MediaQuery.of(context).size.height * 0.35,
                        width: double.infinity,
                        child: Image.network(
                          widget.snap['postUrl'].toString(),
                          fit: BoxFit.cover,
                          loadingBuilder: (BuildContext context, Widget child,
                              ImageChunkEvent? loadingProgress) {
                            if (loadingProgress == null) {
                              return child;
                            } else {
                              return const Center(
                                child: TeamCircularProgressIndicator(
                                    teamIcon:
                                        'https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcQYAXUsI9H_YUIMdooaoGA_oBUoZbdY19XFPcrUWnV62w&shttps://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcQYAXUsI9H_YUIMdooaoGA_oBUoZbdY19XFPcrUWnV62w&s',
                                    size: 64.0,
                                    color: Colors.black),
                              );
                            }
                          },
                        ),
                        // You can add any other overlay widgets here if needed.
                      ),

                      //generaly opacity used for bool changes in widgets with opacity value 1 and 0
                      AnimatedOpacity(
                        duration: const Duration(milliseconds: 200),
                        opacity: isLikeAnimating ? 1 : 0,
                        child: LikeAnimation(
                          isAnimating: isLikeAnimating,
                          duration: const Duration(
                            milliseconds: 400,
                          ),
                          onEnd: () {
                            setState(() {
                              isLikeAnimating = false;
                            });
                          },
                          child: Icon(
                            Icons.favorite,
                            color: Colors.grey[400],
                            size: 100,
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
                // LIKE, COMMENT SECTION OF THE POST
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: <Widget>[
                    Row(
                      children: [
                        LikeAnimation(
                          isAnimating: widget.snap['likes'].contains(user.uid),
                          smallLike: true,
                          child: IconButton(
                            color: Colors.grey[400],
                            icon: widget.snap['likes'].contains(user.uid)
                                ? const Icon(
                                    Icons.favorite,
                                    color: Colors.red,
                                  )
                                : const Icon(
                                    Icons.favorite_border,
                                  ),
                            onPressed: () => FireStoreMethods().likePost(
                              widget.snap['postId'].toString(),
                              user.uid,
                              widget.snap['likes'],
                            ),
                          ),
                        ),
                        IconButton(
                          color: Colors.grey[400],
                          icon: const Icon(
                            Icons.comment_outlined,
                          ),
                          onPressed: () => Navigator.of(context).push(
                            MaterialPageRoute(
                              builder: (context) => CommentsScreen(
                                postId: widget.snap['postId'].toString(),
                              ),
                            ),
                          ),
                        ),
                      ],
                    ),
                    Row(
                      children: [
                        Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 8.0),
                          child: Text(
                            widget.snap['teamName'].toString(),
                            style: const TextStyle(
                              color: primaryColor,
                              fontSize: 18.0,
                              // fontWeight: FontWeight.bold,
                              fontStyle: FontStyle.italic,
                            ),
                          ),
                        ),
                        IconButton(
                          onPressed: (() {
                            showDialog(
                              context: context,
                              builder: ((context) => Dialog(
                                    backgroundColor: Colors.white,
                                    shape: RoundedRectangleBorder(
                                      borderRadius: BorderRadius.circular(10.0),
                                    ),
                                    child: Container(
                                      padding: const EdgeInsets.symmetric(
                                          vertical: 16.0, horizontal: 20.0),
                                      child: Column(
                                        mainAxisSize: MainAxisSize.min,
                                        crossAxisAlignment:
                                            CrossAxisAlignment.start,
                                        children: [
                                          Text(
                                            '${widget.snap['teamName']}',
                                            overflow: TextOverflow.ellipsis,
                                            maxLines: 1,
                                            style: const TextStyle(
                                              fontSize: 22.0,
                                              fontWeight: FontWeight.bold,
                                              color: Colors.black,
                                            ),
                                          ),
                                          const SizedBox(height: 20.0),
                                          InkWell(
                                            onTap: () async {
                                              log(widget.snap['link1']
                                                  .toString());

                                              _launchThisUrl(
                                                  widget.snap['link1']);
                                              Clipboard.setData(ClipboardData(
                                                text: widget.snap['link1'],
                                              ));
                                              Navigator.pop(context);
                                              ScaffoldMessenger.of(context)
                                                  .showSnackBar(
                                                const SnackBar(
                                                  duration: Duration(
                                                      milliseconds: 500),
                                                  content: Text(
                                                      'Copied to clipboard'),
                                                  backgroundColor: mainColor,
                                                ),
                                              );
                                            },
                                            child: Row(
                                              children: [
                                                const Icon(
                                                  Icons.link,
                                                  size: 30.0,
                                                  color: Colors.black,
                                                ),
                                                const SizedBox(width: 10.0),
                                                Flexible(
                                                  child: Text(
                                                    widget.snap['link1']
                                                        .toString(),
                                                    overflow:
                                                        TextOverflow.ellipsis,
                                                    style: const TextStyle(
                                                      fontSize: 18.0,
                                                      color: Colors.black,
                                                    ),
                                                  ),
                                                ),
                                              ],
                                            ),
                                          ),
                                          const SizedBox(height: 20.0),
                                          InkWell(
                                            onTap: () {
                                              log(widget.snap['link2']
                                                  .toString());

                                              _launchThisUrl(
                                                  widget.snap['link2']);
                                              Clipboard.setData(ClipboardData(
                                                text: widget.snap['link2'],
                                              ));
                                              Navigator.pop(context);
                                              ScaffoldMessenger.of(context)
                                                  .showSnackBar(
                                                const SnackBar(
                                                  duration: Duration(
                                                      milliseconds: 500),
                                                  content: Text(
                                                      'Copied to clipboard'),
                                                  backgroundColor: mainColor,
                                                ),
                                              );
                                            },
                                            child: Row(
                                              children: [
                                                const Icon(
                                                  Icons.link,
                                                  size: 30.0,
                                                  color: Colors.black,
                                                ),
                                                const SizedBox(width: 10.0),
                                                Flexible(
                                                  child: Text(
                                                    widget.snap['link2']
                                                        .toString(),
                                                    overflow:
                                                        TextOverflow.ellipsis,
                                                    style: const TextStyle(
                                                      fontSize: 18.0,
                                                      color: Colors.black,
                                                    ),
                                                  ),
                                                ),
                                              ],
                                            ),
                                          ),
                                        ],
                                      ),
                                    ),
                                  )),
                            );
                          }),
                          icon: const Icon(Icons.link),
                          color: Colors.amber[600],
                        ),
                      ],
                    ),
                    // IconButton(
                    //     icon: const Icon(
                    //       Icons.send,
                    //     ),
                    //     onPressed: () {}),
                    // Expanded(
                    //     child: Align(
                    //   alignment: Alignment.bottomRight,
                    //   child: IconButton(
                    //       icon: const Icon(Icons.bookmark_border), onPressed: () {}),
                    // ))
                  ],
                ),
                //DESCRIPTION AND NUMBER OF COMMENTS
                Container(
                  padding: const EdgeInsets.symmetric(horizontal: 10),
                  child: Column(
                    mainAxisSize: MainAxisSize.min,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: <Widget>[
                      Text(
                        '${widget.snap['likes'].length} likes',
                        style: TextStyle(
                          color: Colors.grey[400],
                        ),
                      ),
                      // DefaultTextStyle(
                      //     style: Theme.of(context)
                      //         .textTheme
                      //         .subtitle2!
                      //         .copyWith(fontWeight: FontWeight.w800),
                      //     child: Text(
                      //       '${widget.snap['likes'].length} likes',
                      //       style: Theme.of(context).textTheme.bodyText2,
                      //     )),
                      Container(
                        width: double.infinity,
                        padding: const EdgeInsets.only(
                          top: 8,
                        ),
                        child: RichText(
                          text: TextSpan(
                            style: const TextStyle(color: primaryColor),
                            children: [
                              TextSpan(
                                text: widget.snap['username'].toString(),
                                style: const TextStyle(
                                  fontWeight: FontWeight.bold,
                                  fontSize: 15.0,
                                ),
                              ),
                              TextSpan(
                                text: '   ${widget.snap['description']}',
                                style: const TextStyle(
                                  fontSize: 15.0,
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                      InkWell(
                        child: Container(
                          padding: const EdgeInsets.symmetric(vertical: 8),
                          child: Text(
                            'View all $commentLen comments',
                            style: TextStyle(
                              fontSize: 14,
                              color: Colors.grey[400],
                            ),
                          ),
                        ),
                        onTap: () => Navigator.of(context).push(
                          MaterialPageRoute(
                            builder: (context) => CommentsScreen(
                              postId: widget.snap['postId'].toString(),
                            ),
                          ),
                        ),
                      ),
                      Container(
                        padding: const EdgeInsets.symmetric(vertical: 4),
                        child: Text(
                          DateFormat.yMMMd()
                              .format(widget.snap['datePublished'].toDate()),
                          style: TextStyle(
                            color: Colors.grey[400],
                          ),
                        ),
                      ),
                    ],
                  ),
                )
              ],
            ),
          );
  }

  Future<void> _launchThisUrl(String url) async {
    if (url.startsWith('https://') || url.startsWith('http://')) {
      final Uri uri = Uri.parse(url);
      if (!await launchUrl(uri, mode: LaunchMode.externalApplication)) {
        throw Exception('Could not launch $url');
      }
      await launch(url);
    } else if (url.startsWith('instagram')) {
      final Uri uri = Uri.parse(url);
      if (!await launchUrl(uri, mode: LaunchMode.externalApplication)) {
        throw Exception('Could not launch $url');
      }
    } else {
      throw Exception('Unsupported URL format: $url');
    }
  }
}
