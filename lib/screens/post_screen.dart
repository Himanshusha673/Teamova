import 'dart:typed_data';

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

  @override
  Widget build(BuildContext context) {
    // state management
    final model.User userProvider = Provider.of<UserProvider>(context).getUser;

    return Scaffold(
        appBar: AppBar(
            title: Text('Share Post'),
            //leading: Icon(Icons.cancel),
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
                            child: Row(
                              children: [
                                IconButton(
                                  icon: Icon(
                                    Icons.camera,
                                    size: 42,
                                  ),
                                  onPressed: () async {
                                    Uint8List file =
                                        await pickImage(ImageSource.camera);
                                    setState(() {
                                      _file = file;
                                    });
                                  },
                                ),
                                SizedBox(width: 20),
                                const Text(
                                  "Capture a Image",
                                  style: TextStyle(
                                      fontWeight: FontWeight.bold,
                                      fontSize: 28),
                                ),
                              ],
                            ),
                          ),
                          Divider(thickness: 1, color: Colors.grey),
                          Container(
                            height: 50,
                            color: Colors.white,
                            child: Row(
                              children: [
                                IconButton(
                                  icon: Icon(
                                    Icons.image,
                                    size: 42,
                                  ),
                                  onPressed: () async {
                                    Uint8List file =
                                        await pickImage(ImageSource.gallery);
                                    setState(() {
                                      _file = file;
                                    });
                                  },
                                ),
                                SizedBox(width: 20),
                                const Text(
                                  "Take Picture from Gallery",
                                  style: TextStyle(
                                      fontWeight: FontWeight.bold,
                                      fontSize: 28),
                                ),
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
                              const CircleAvatar(
                                  radius: 18,
                                  backgroundImage: NetworkImage(
                                      'https://images.unsplash.com/photo-1494790108377-be9c29b29330?ixlib=rb-4.0.3&ixid=MnwxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8&auto=format&fit=crop&w=2574&q=80')
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
                            labelText: 'Enter Title ',
                            border: InputBorder.none,
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
                          controller: _link_1_Controller,
                          decoration: const InputDecoration(
                            labelText: 'Enter 1st Link ',
                            border: InputBorder.none,

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
                            labelText: 'Enter 2nd link ',
                            border: InputBorder.none,
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
                          maxLines: 8,

                          controller: _descriptionController,
                          decoration: const InputDecoration(
                            labelText: 'Enter description ',
                            border: InputBorder.none,
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
