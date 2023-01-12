import 'dart:typed_data';
import 'package:team_builder/screens/feed_screen.dart';
import 'package:team_builder/utils/colors.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:provider/provider.dart';
import 'package:snapping_sheet/snapping_sheet.dart';

import '../providers/user_provider.dart';
import '../models/user_model.dart' as model;
import '../resources/firestore_methods.dart';
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
    final model.User userProvider = Provider.of<UserProvider>(context).getUser;

    return Scaffold(
        appBar: AppBar(
            title: Text('Share Post'),
            leading: IconButton(
                onPressed: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(builder: (context) => const FeedScreen()),
                  );
                },
                icon: Icon(Icons.arrow_back)),
            actions: <Widget>[
              TextButton(
                onPressed: () {
                  Navigator.of(context).pop();
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
                // TODO: Add your grabbing widget here,
                grabbing: GrabbingWidget(),
                /////////////////
                // Part forSnipingSheet
                /////////////////////
                sheetBelow: SnappingSheetContent(
                    draggable: true,
                    // childScrollController: listViewController,
                    child: Container(
                      color: Colors.white,
                      child: ListView(
                        children: [
                          Container(
                            height: 50,
                            color: Colors.white,
                            child: GestureDetector(
                              onTap: () async {
                                Uint8List file =
                                    await pickImage(ImageSource.camera);
                                setState(() {
                                  _file = file;
                                });
                              },
                              child: Row(
                                children: [
                                  Icon(
                                    Icons.camera,
                                    size: 40,
                                  ),
                                  SizedBox(width: 20),
                                  const Text(
                                    "Capture a Image",
                                    style: TextStyle(
                                        fontWeight: FontWeight.bold,
                                        fontSize: 24),
                                  ),
                                ],
                              ),
                            ),
                          ),
                          Divider(thickness: 1, color: Colors.grey),
                          Container(
                            height: 50,
                            color: Colors.white,
                            child: GestureDetector(
                              onTap: () async {
                                Uint8List file =
                                    await pickImage(ImageSource.gallery);
                                setState(() {
                                  _file = file;
                                });
                              },
                              child: Row(
                                children: [
                                  Icon(
                                    Icons.image,
                                    size: 40,
                                  ),
                                  SizedBox(width: 20),
                                  const Text(
                                    "Take Picture from Gallery",
                                    style: TextStyle(
                                        fontWeight: FontWeight.bold,
                                        fontSize: 24),
                                  ),
                                ],
                              ),
                            ),
                          ),
                          SizedBox(
                            height: 12,
                          ),
                          Center(
                            child: Stack(
                              children: [
                                _file != null
                                    ? CircleAvatar(
                                        radius: 64,
                                        backgroundImage: MemoryImage(_file!),
                                        backgroundColor: Colors.white,
                                      )
                                    : Container(),
                                _file != null
                                    ? Positioned(
                                        top: -8,
                                        left: 80,
                                        child: IconButton(
                                          onPressed: () {
                                            setState(() {
                                              _file = null;
                                            });
                                          },
                                          icon: buildEditIcon(mainColor),
                                          // const Icon(Icons.add_a_photo),
                                        ),
                                      )
                                    : Container()
                              ],
                            ),
                          ),
                        ],
                      ),
                    )),

                ///////////////////////////////
                // below code is for outside part-body of snippingSheet
                ///////////////////////////////
                ////////////////////////
                child: Container(
                  padding: const EdgeInsets.all(8),
                  child: Column(
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: [
                        Row(
                            mainAxisAlignment: MainAxisAlignment.start,
                            children: [
                              CircleAvatar(
                                radius: 18,
                                backgroundImage:
                                    NetworkImage(userProvider.photoUrl),

                                //radius: 20,
                              ),
                              const SizedBox(width: 15),
                              Text(userProvider.name,
                                  style: const TextStyle(
                                      fontWeight: FontWeight.bold))
                            ]),
                        TextFormField(
                          controller: _teamName,
                          decoration: const InputDecoration(
                              labelText: 'Enter Team Name ',
                              enabledBorder: UnderlineInputBorder(
                                  borderSide: BorderSide(
                                      width: 3, color: Colors.black87))),
                          // use the validator to return an error string (or null) based on the input text
                          validator: (text) {
                            if (text == null || text.isEmpty) {
                              return 'Can\'t be empty';
                            }
                            if (text.length < 4) {
                              return 'Too short';
                            }
                            return null;
                          },
                          // update the state variable when the text changes
                        ),
                        TextFormField(
                          controller: _link_1_Controller,
                          decoration: const InputDecoration(
                              labelText: 'Enter 1st Social Link Of Your Team',
                              enabledBorder: UnderlineInputBorder(
                                  borderSide: BorderSide(
                                      width: 3, color: Colors.black87))

                              ///prefixIcon: Icon(Icons.)
                              ),
                          // use the validator to return an error string (or null) based on the input text
                          validator: (text) {
                            if (text == null || text.isEmpty) {
                              return 'Can\'t be empty';
                            }
                            if (text.length < 4) {
                              return 'Too short';
                            }
                            return null;
                          },
                          // update the state variable when the text changes
                        ),
                        TextFormField(
                          controller: _link_2_Controller,
                          decoration: const InputDecoration(
                              labelText: 'Enter 2nd Social Link Of Your Team',
                              enabledBorder: UnderlineInputBorder(
                                  borderSide: BorderSide(
                                      width: 3, color: Colors.black87))),
                          // use the validator to return an error string (or null) based on the input text
                          validator: (text) {
                            if (text == null || text.isEmpty) {
                              return 'Can\'t be empty';
                            }
                            if (text.length < 4) {
                              return 'Too short';
                            }
                            return null;
                          },
                          // update the state variable when the text changes
                        ),
                        SizedBox(height: 10),
                        TextFormField(
                          maxLines: 8,
                          controller: _descriptionController,
                          decoration: const InputDecoration(
                              labelText: 'Enter description ',
                              hintText: 'Enter description ',
                              enabledBorder: OutlineInputBorder(
                                  borderSide: BorderSide(
                                      width: 3, color: Colors.black87))),
                          // use the validator to return an error string (or null) based on the input text
                          validator: (text) {
                            if (text == null || text.isEmpty) {
                              return 'Can\'t be empty';
                            }
                            if (text.length < 4) {
                              return 'Too short';
                            }
                            return null;
                          },
                          // update the state variable when the text changes
                        ),
                      ]),
                ))
            : Center(
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
        borderRadius: BorderRadius.vertical(top: Radius.circular(20)),
        boxShadow: [
          BoxShadow(blurRadius: 25, color: Colors.black.withOpacity(0.2)),
        ],
      ),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Container(
            margin: EdgeInsets.only(top: 20),
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
            margin: EdgeInsets.all(15).copyWith(top: 0, bottom: 0),
          )
        ],
      ),
    );
  }
}
