import 'dart:developer';
import 'dart:typed_data';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_chip_tags/flutter_chip_tags.dart';
import 'package:image_picker/image_picker.dart';
import 'package:team_builder/utils/colors.dart';
import 'package:toggle_switch/toggle_switch.dart';
import 'package:team_builder/utils/constant.dart';

import '../services/auth_methods.dart';
import '../responsive/mobile_screen_layout.dart';
import '../responsive/responsive_layout.dart';
import '../responsive/web_screen_layout.dart';
import '../utils/utils.dart';

class Aboutyourself extends StatefulWidget {
  final String? name;
  final String? email;
  final String? password;
  final String? phoneNo;
  User? user;

  Aboutyourself(
      {Key? key,
      this.user,
      required this.name,
      required this.email,
      required this.password,
      required this.phoneNo})
      : super(key: key);

  @override
  State<Aboutyourself> createState() => _AboutyourselfState();
}

class _AboutyourselfState extends State<Aboutyourself> {
  final _leaderFormKey = GlobalKey<FormState>();
  final _memberFormKey = GlobalKey<FormState>();
  bool _isLoading = false;
  final List<String> _myList = [];
  final TextEditingController _objectiveController = TextEditingController();
  final TextEditingController _descriptionController = TextEditingController();
  Uint8List? _image;

  @override
  void dispose() {
    super.dispose();
    _objectiveController.dispose();
    _descriptionController.dispose();
  }

  void signUpUser() async {
    // set loading to true
    setState(() {
      _isLoading = true;
    });
    log("i am in  signup");

    log(widget.password.toString());
    try {
      // signup user using our authmethodds
      String res = widget.password != null
          //  user != null &&
          //         user.providerData.any((info) =>
          //             info.providerId == GoogleAuthProvider.GOOGLE_SIGN_IN_METHOD)
          ? await AuthMethods().signUpUserWithEmailPassword(
              name: widget.name ?? "",
              email: widget.email ?? " ",
              password: widget.password ?? " ",
              phoneNo: widget.phoneNo ?? " ",
              description: _descriptionController.text,
              isLeader: isLeader,
              objective: _objectiveController.text,
              skills: _myList,
              file: _image!,
            )
          : await AuthMethods().signUpUserWithGoogle(
              description: _descriptionController.text,
              isLeader: isLeader,
              objective: _objectiveController.text,
              skills: _myList,
              file: _image,
            );
      // if string returned is sucess, user has been created
      if (res == "success") {
        setState(() {
          _isLoading = false;
        });
        // navigate to the home screen
        Navigator.of(context).pushReplacement(
          MaterialPageRoute(
            builder: (context) => const ResponsiveLayout(
              mobileScreenLayout: MobileScreenLayout(),
              webScreenLayout: WebScreenLayout(),
            ),
          ),
        );
      } else {
        setState(() {
          _isLoading = false;
        });
        // show the error
        showSnackBar(context, res);
      }
    } catch (e) {
      log(e.toString());
    }
  }

  Widget buildEditIcon(Color color) => buildCircle(
        color: Colors.white,
        all: 3,
        child: buildCircle(
          color: color,
          all: 3,
          child: const Icon(
            Icons.edit_outlined,
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

  selectImage() async {
    Uint8List im = await pickImage(ImageSource.camera);
    // set state because we need to display the image we selected on the circle avatar
    setState(() {
      _image = im;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: _isLoading
          ? Center(child: CircularProgressIndicator())
          : SingleChildScrollView(
              child: Padding(
                padding: const EdgeInsets.all(10.0),
                child: Column(
                  children: [
                    const SizedBox(
                      height: 30,
                    ),
                    const Align(
                      alignment: Alignment.centerLeft,
                      child: Padding(
                        padding: EdgeInsets.all(15.0),
                        child: Text(
                          "About Yourself",
                          style: TextStyle(
                            color: Colors.black,
                            fontSize: 25.0,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ),
                    ),
                    // const SizedBox(
                    //   height: 5,
                    // ),
                    //https://prod.liveshare.vsengsaas.visualstudio.com/join?05DD551B050D6FA66820EF3E831DA333B9E6
                    // Padding(
                    //   padding: const EdgeInsets.all(10),
                    //   child: Stack(
                    //     children: [
                    //       ClipOval(
                    //         child: Material(
                    //           color: Colors.transparent,
                    //           child: Ink.image(
                    //             image: const AssetImage('images/No-DP2.png'),
                    //             fit: BoxFit.cover,
                    //             width: 128,
                    //             height: 128,
                    //             child: InkWell(onTap: selectImage),
                    //           ),
                    //         ),
                    //       ),
                    //       Positioned(
                    //         bottom: 0,
                    //         right: 4,
                    //         child: buildEditIcon(mainColor),
                    //       ),
                    //     ],
                    //   ),
                    // ),
                    Stack(
                      children: [
                        _image != null
                            ? CircleAvatar(
                                radius: 64,
                                backgroundImage: MemoryImage(_image!),
                                backgroundColor: Colors.white,
                              )
                            : const CircleAvatar(
                                radius: 64,
                                backgroundImage:
                                    AssetImage('images/No-DP2.png'),
                                // NetworkImage('https://i.stack.imgur.com/l60Hf.png'),
                                backgroundColor: Colors.transparent,
                              ),
                        Positioned(
                          bottom: -8,
                          left: 80,
                          child: IconButton(
                            onPressed: selectImage,
                            icon: buildEditIcon(mainColor),
                            // const Icon(Icons.add_a_photo),
                          ),
                        )
                      ],
                    ),

                    const SizedBox(
                      height: 10,
                    ),
                    Center(
                      child: Column(
                        children: [
                          const Text(
                            "CHOOSE WHO YOU ARE ?",
                            style: TextStyle(
                              color: Colors.blue,
                              fontSize: 18.0,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                          Padding(
                            padding: const EdgeInsets.symmetric(vertical: 15),
                            child: ToggleSwitch(
                              minWidth: 90.0,
                              cornerRadius: 20.0,
                              borderWidth: 2.0,
                              activeBgColor:
                                  isLeader ? [Colors.green] : [Colors.black],
                              activeFgColor: Colors.white,
                              inactiveBgColor:
                                  isLeader ? Colors.black : Colors.green,
                              inactiveFgColor: Colors.white,
                              initialLabelIndex: 0,
                              totalSwitches: 2,
                              animate: true,
                              labels: const ['LEADER', 'MEMBER'],
                              onToggle: (index) {
                                // print("$index");
                                if (index == 0) {
                                  setState(() {
                                    isLeader = true;
                                  });
                                } else {
                                  setState(() {
                                    isLeader = false;
                                  });
                                }
                              },
                            ),
                          ),
                        ],
                      ),
                    ),
                    // Ui is for just Member and leader
                    Padding(
                      padding: const EdgeInsets.symmetric(
                        horizontal: 10.0,
                        vertical: 10.0,
                      ),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            'Fill Your Information as ${isLeader ? 'Leader' : 'Member'}',
                            style: const TextStyle(fontSize: 18),
                          ),
                          isLeader ? leader() : member(),
                        ],
                      ),
                    ),
                    SizedBox(
                      width: double.infinity,
                      child: Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 7.0),
                        child: ElevatedButton(
                          onPressed: () async {
                            signUpUser();
                            // await AuthMethods().signOut();
                          },
                          style: ElevatedButton.styleFrom(
                            shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(10.0)),
                            backgroundColor: Colors.black,
                          ),
                          child: const Padding(
                            padding: EdgeInsets.all(15.0),
                            child: Text(
                              "SUBMIT",
                              style: TextStyle(
                                color: Colors.white,
                                fontSize: 18,
                              ),
                            ),
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
    );
  }

  Widget leader() {
    return Form(
      key: _leaderFormKey,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          Padding(
            padding: const EdgeInsets.symmetric(vertical: 12.0),
            child: TextFormField(
              controller: _objectiveController,
              decoration: const InputDecoration(
                prefixIcon: Icon(Icons.lightbulb_circle_outlined),
                hintText: 'Enter the objective for your team',
                labelText: 'Objective',
                border: OutlineInputBorder(),
              ),
            ),
          ),
          Padding(
            padding: const EdgeInsets.symmetric(vertical: 12.0),
            child: ChipTags(
              list: _myList,
              createTagOnSubmit: true,
              chipColor: Colors.black,
              decoration: const InputDecoration(
                prefixIcon: Icon(Icons.account_tree_outlined),
                hintText: 'Add your skill sets',
                labelText: 'Skills',
                border: OutlineInputBorder(),
              ),
            ),
          ),
          Padding(
            padding: const EdgeInsets.symmetric(vertical: 12.0),
            child: TextFormField(
              controller: _descriptionController,
              decoration: const InputDecoration(
                prefixIcon: Icon(Icons.description_outlined),
                hintText: 'Description (around 20 words atleast)',
                labelText: 'Description',
                border: OutlineInputBorder(),
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget member() {
    return Form(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          Padding(
            padding: const EdgeInsets.symmetric(vertical: 12.0),
            child: TextFormField(
              controller: _objectiveController,
              decoration: const InputDecoration(
                prefixIcon: Icon(Icons.lightbulb_circle_outlined),
                hintText: 'Enter the objective for your team',
                labelText: 'Objective',
                border: OutlineInputBorder(),
              ),
            ),
          ),
          Padding(
            padding: const EdgeInsets.symmetric(vertical: 12.0),
            child: ChipTags(
              list: _myList,
              createTagOnSubmit: true,
              chipColor: Colors.black,
              decoration: const InputDecoration(
                prefixIcon: Icon(Icons.account_tree_outlined),
                hintText: 'Add your skill sets',
                labelText: 'Skills',
                border: OutlineInputBorder(),
              ),
            ),
          ),
          Padding(
            padding: const EdgeInsets.symmetric(vertical: 12.0),
            child: TextFormField(
              controller: _descriptionController,
              decoration: const InputDecoration(
                prefixIcon: Icon(Icons.description_outlined),
                hintText: 'Description (around 20 words atleast)',
                labelText: 'Description',
                border: OutlineInputBorder(),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
