import 'dart:typed_data';
import 'package:team_builder/screens/feed_screen.dart';
import 'package:team_builder/utils/colors.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:provider/provider.dart';
import 'package:snapping_sheet/snapping_sheet.dart';

import '../providers/user_provider.dart';
import '../models/user_model.dart' as model;
import '../services/firestore_methods.dart';
import '../utils/utils.dart';

class PostPage extends StatefulWidget {
  const PostPage({
    Key? key,
  }) : super(key: key);

  @override
  State<PostPage> createState() => _postState();
}

class _postState extends State<PostPage> {
  Uint8List? _file;
  bool isLoading = false;
  final TextEditingController _descriptionController = TextEditingController();
  final TextEditingController _teamName = TextEditingController();
  final TextEditingController _link_1_Controller = TextEditingController();
  final TextEditingController _link_2_Controller = TextEditingController();
  @override
  void dispose() {
    _descriptionController.dispose();
    _teamName.dispose();
    _link_1_Controller.dispose();
    _link_2_Controller.dispose();
    super.dispose();
  }

  void postImage(String uid, String username, String profImage, String teamName,
      String description, String link1, String link2) async {
    setState(() {
      isLoading = true;
    });
    // start the loading
    try {
      // upload to storage and db
      String res = await FireStoreMethods().uploadPost(
          _descriptionController.text,
          _file!,
          uid,
          username,
          profImage,
          teamName,
          link1,
          link2);
      if (res == "success") {
        setState(() {
          isLoading = false;
        });
        showSnackBar(
          context,
          'Posted!',
        );
        clearImage();
      } else {
        showSnackBar(context, res);
      }
    } catch (err) {
      setState(() {
        isLoading = false;
      });
      showSnackBar(
        context,
        err.toString(),
      );
    }
  }

  void clearImage() {
    setState(() {
      _file = null;
    });
  }

  Widget buildEditIcon(Color color) => buildCircle(
        color: Colors.white,
        all: 3,
        child: buildCircle(
          color: color,
          all: 3,
          child: const Icon(
            Icons.cancel,
            color: Colors.white,
            size: 20,
          ),
        ),
      );

  Widget buildCircle({
    required Widget child,
    required double all,
    required Color color,
  }) =>
      ClipOval(
        child: Container(
          padding: EdgeInsets.all(all),
          color: color,
          child: child,
        ),
      );

  @override
  Widget build(BuildContext context) {
    // state management
    final model.UserModel userProvider =
        Provider.of<UserProvider>(context).getUser;

    return Scaffold(
        appBar: AppBar(
            title: const Text('Share Post'),
            leading: IconButton(
                onPressed: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(builder: (context) => const FeedScreen()),
                  );
                },
                icon: const Icon(Icons.arrow_back)),
            actions: <Widget>[
              TextButton(
                onPressed: () {
                  postImage(
                      userProvider.uid,
                      userProvider.name,
                      userProvider.photoUrl,
                      _teamName.text,
                      _descriptionController.text,
                      _link_1_Controller.text,
                      _link_2_Controller.text);
                },
                child: const Text(
                  "Post",
                  style: TextStyle(
                      color: Colors.blueAccent,
                      fontWeight: FontWeight.bold,
                      fontSize: 16.0),
                ),
              )
            ],
            centerTitle: true,
            backgroundColor: Colors.black),
        body: !isLoading
            ? SnappingSheet(
                grabbingHeight: 75,
                grabbing: GrabbingWidget(),
                sheetBelow: SnappingSheetContent(
                  draggable: true,
                  child: Container(
                    decoration: const BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.only(
                        topLeft: Radius.circular(30),
                        topRight: Radius.circular(30),
                      ),
                    ),
                    child: ListView(
                      padding: const EdgeInsets.all(20),
                      children: [
                        const SizedBox(height: 20),
                        GestureDetector(
                          onTap: () async {
                            Uint8List file =
                                await pickImage(ImageSource.camera);
                            setState(() {
                              _file = file;
                            });
                          },
                          child: Container(
                            height: 60,
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(10),
                              color: Colors.grey[100],
                            ),
                            child: Row(
                              children: [
                                const SizedBox(width: 20),
                                const Icon(Icons.camera_alt,
                                    size: 35, color: Colors.black),
                                const SizedBox(width: 20),
                                const Text(
                                  'Capture a Image',
                                  style: TextStyle(
                                    fontWeight: FontWeight.bold,
                                    fontSize: 20,
                                    color: Colors.black,
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ),
                        const SizedBox(height: 20),
                        GestureDetector(
                          onTap: () async {
                            Uint8List file =
                                await pickImage(ImageSource.gallery);
                            setState(() {
                              _file = file;
                            });
                          },
                          child: Container(
                            height: 60,
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(10),
                              color: Colors.grey[100],
                            ),
                            child: Row(
                              children: [
                                const SizedBox(width: 20),
                                const Icon(Icons.photo_library,
                                    size: 35, color: Colors.black),
                                const SizedBox(width: 20),
                                const Text(
                                  'Select from Gallery',
                                  style: TextStyle(
                                    fontWeight: FontWeight.bold,
                                    fontSize: 20,
                                    color: Colors.black,
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ),
                        const SizedBox(height: 20),
                        Center(
                          child: Stack(
                            children: [
                              _file != null
                                  ? CircleAvatar(
                                      radius: 70,
                                      backgroundImage: MemoryImage(_file!),
                                    )
                                  : Container(),
                              _file != null
                                  ? Positioned(
                                      top: -10,
                                      left: 85,
                                      child: IconButton(
                                        onPressed: () {
                                          setState(() {
                                            _file = null;
                                          });
                                        },
                                        icon: const Icon(Icons.edit,
                                            size: 40, color: Colors.black),
                                      ),
                                    )
                                  : Container()
                            ],
                          ),
                        ),
                      ],
                    ),
                  ),
                ),

                ///////////////////////////////
                // below code is for outside part-body of snippingSheet
                ///////////////////////////////
                ////////////////////////
                child: Container(
                  padding: const EdgeInsets.all(16),
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(8),
                    color: Colors.white,
                    boxShadow: [
                      BoxShadow(
                        color: Colors.black.withOpacity(0.2),
                        blurRadius: 4,
                        offset: const Offset(0, 2),
                      ),
                    ],
                  ),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Row(
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          CircleAvatar(
                            radius: 28,
                            backgroundImage:
                                NetworkImage(userProvider.photoUrl),
                          ),
                          const SizedBox(width: 16),
                          Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                userProvider.name,
                                style: const TextStyle(
                                  fontWeight: FontWeight.w600,
                                  fontSize: 20,
                                ),
                              ),
                              const SizedBox(height: 4),
                              Text(
                                '${userProvider.objective} ',
                                style: TextStyle(
                                  fontWeight: FontWeight.w400,
                                  fontSize: 16,
                                  color: Colors.grey,
                                ),
                              ),
                            ],
                          ),
                        ],
                      ),
                      const SizedBox(height: 24),
                      const Text(
                        'Team Name',
                        style: TextStyle(
                          fontWeight: FontWeight.w600,
                          fontSize: 18,
                        ),
                      ),
                      const SizedBox(height: 8),
                      TextFormField(
                        controller: _teamName,
                        decoration: const InputDecoration(
                          hintText: 'Enter team name',
                          enabledBorder: OutlineInputBorder(
                            borderSide:
                                BorderSide(width: 2, color: Colors.grey),
                            borderRadius: BorderRadius.all(Radius.circular(4)),
                          ),
                          focusedBorder: OutlineInputBorder(
                            borderSide:
                                BorderSide(width: 2, color: Colors.blue),
                            borderRadius: BorderRadius.all(Radius.circular(4)),
                          ),
                        ),
                        validator: (text) {
                          if (text == null || text.isEmpty) {
                            return 'Team name is required';
                          }
                          if (text.length < 4) {
                            return 'Team name must be at least 4 characters';
                          }
                          return null;
                        },
                      ),
                      const SizedBox(height: 16),
                      const Text(
                        'Social Media Links',
                        style: TextStyle(
                          fontWeight: FontWeight.w600,
                          fontSize: 18,
                        ),
                      ),
                      const SizedBox(height: 8),
                      TextFormField(
                        controller: _link_1_Controller,
                        decoration: const InputDecoration(
                          hintText: 'Enter social media link 1',
                          enabledBorder: OutlineInputBorder(
                            borderSide:
                                BorderSide(width: 2, color: Colors.grey),
                            borderRadius: BorderRadius.all(Radius.circular(4)),
                          ),
                          focusedBorder: OutlineInputBorder(
                            borderSide:
                                BorderSide(width: 2, color: Colors.blue),
                            borderRadius: BorderRadius.all(Radius.circular(4)),
                          ),
                        ),
                        validator: (text) {
                          if (text == null || text.isEmpty) {
                            return 'Social media link 1 is required';
                          }
                          if (text.length < 4) {
                            return 'Social media link 1 must be at least 4 characters';
                          }
                          return null;
                        },
                      ),
                      const SizedBox(height: 8),
                      TextFormField(
                        controller: _link_2_Controller,
                        decoration: const InputDecoration(
                          hintText: 'Enter social media link 2',
                          enabledBorder: OutlineInputBorder(
                            borderSide:
                                BorderSide(width: 2, color: Colors.grey),
                            borderRadius: BorderRadius.all(Radius.circular(4)),
                          ),
                          focusedBorder: OutlineInputBorder(
                            borderSide:
                                BorderSide(width: 2, color: Colors.blue),
                            borderRadius: BorderRadius.all(Radius.circular(4)),
                          ),
                        ),
                        validator: (text) {
                          if (text == null || text.isEmpty) {
                            return 'Can\'t be empty';
                          }
                          if (text.length < 4) {
                            return 'Too short';
                          }
                          return null;
                        },
                      ),

                      // Description text field
                      const SizedBox(height: 10),
                      TextFormField(
                        maxLines: 8,
                        controller: _descriptionController,
                        decoration: InputDecoration(
                          labelText: 'Description',
                          labelStyle: const TextStyle(color: Colors.grey),
                          hintText: 'Describe your team and what you do',
                          hintStyle: const TextStyle(color: Colors.grey),
                          filled: true,
                          fillColor: Colors.white,
                          enabledBorder: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(10),
                            borderSide: const BorderSide(color: Colors.grey),
                          ),
                          focusedBorder: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(10),
                            borderSide: const BorderSide(color: Colors.blue),
                          ),
                          errorBorder: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(10),
                            borderSide: const BorderSide(color: Colors.red),
                          ),
                          errorStyle: const TextStyle(fontSize: 12),
                          errorMaxLines: 2,
                        ),
                        validator: (text) {
                          if (text == null || text.isEmpty) {
                            return 'Can\'t be empty';
                          }
                          if (text.length < 4) {
                            return 'Too short';
                          }
                          return null;
                        },
                      ),
                    ],
                  ),
                ))
            : const Center(
                child: CircularProgressIndicator(),
              ));
  }
}

class GrabbingWidget extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: const BorderRadius.vertical(top: Radius.circular(20)),
        boxShadow: [
          BoxShadow(blurRadius: 25, color: Colors.black.withOpacity(0.2)),
        ],
      ),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Container(
            margin: const EdgeInsets.only(top: 20),
            width: 100,
            height: 7,
            decoration: BoxDecoration(
              color: Colors.grey,
              borderRadius: BorderRadius.circular(5),
            ),
          ),
          Container(
            color: Colors.grey[200],
            height: 2,
            margin: const EdgeInsets.all(15).copyWith(top: 0, bottom: 0),
          )
        ],
      ),
    );
  }
}
