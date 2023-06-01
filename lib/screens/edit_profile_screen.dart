import 'dart:developer';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:team_builder/models/user_model.dart' as model;
import 'package:team_builder/providers/user_provider.dart';
import 'package:team_builder/widgets/circularIndiacator.dart';

class EditProfileScreen extends StatefulWidget {
  final String name;
  final String email;
  final String phoneNo;
  final String description;

  const EditProfileScreen(
      {super.key, required this.name,
      required this.email,
      required this.phoneNo,
      required this.description});

  @override
  _EditProfileScreenState createState() => _EditProfileScreenState();
}

class _EditProfileScreenState extends State<EditProfileScreen> {
  final _formKey = GlobalKey<FormState>();
  late TextEditingController _nameController;
  late TextEditingController _emailController;
  late TextEditingController _phoneNoController;
  late TextEditingController _descriptionController;
  final FirebaseFirestore firestore = FirebaseFirestore.instance;
  model.UserModel? userProvider;
  bool isLoading = false;

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();

    if (userProvider == null) {
      userProvider = Provider.of<UserProvider>(context).getUser;
      log(userProvider!.uid);

      _nameController =
          TextEditingController(text: userProvider?.name ?? "Testing name");
      _emailController =
          TextEditingController(text: userProvider?.email ?? "Testing name");
      _phoneNoController = TextEditingController(
          text: userProvider?.phoneNo ?? "Please enter you mobile no.");
      _descriptionController = TextEditingController(
          text: userProvider?.description ?? "Testing name");
    }
  }

  Future<bool> updateData() async {
    setState(() {
      isLoading = true;
    });
    try {
      // Update the document with new data
      await firestore.collection('users').doc(userProvider!.uid).update({
        'name': _nameController.text,
        'email': _emailController.text,
        'phoneNo': _phoneNoController.text,
        'description': _descriptionController.text,
      });

      // Success message
      return true;
    } catch (e) {
      return false;
      // Error message
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text('Data not updated'),
        ),
      );
    }
    setState(() {
      isLoading = false;
    });
  }

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider<UserProvider>(
      create: (context) => UserProvider(),
      child: body(context),
    );
  }

  Widget body(BuildContext context) {
    return isLoading
        ? const Center(
            child: TeamCircularProgressIndicator(
                teamIcon:
                    'https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcQYAXUsI9H_YUIMdooaoGA_oBUoZbdY19XFPcrUWnV62w&shttps://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcQYAXUsI9H_YUIMdooaoGA_oBUoZbdY19XFPcrUWnV62w&s',
                size: 64.0,
                color: Colors.black),
          )
        : Scaffold(
            appBar: AppBar(
              title: const Text('Edit Profile'),
            ),
            body: Form(
              key: _formKey,
              child: Padding(
                padding: const EdgeInsets.all(16.0),
                child: ListView(
                  children: [
                    SizedBox(
                      width: 120.0,
                      height: 120.0,
                      child: GestureDetector(
                        onTap: () {
                          // Code to update profile photo
                        },
                        child: CircleAvatar(
                          backgroundImage: NetworkImage(
                            userProvider?.photoUrl ??
                                "https://www.kindpng.com/picc/m/21-214439_free-high-quality-person-icon-default-profile-picture.png",
                          ),
                          radius: 60.0,
                          child: const Icon(
                            Icons.camera_alt,
                            size: 30.0,
                            color: Colors.white,
                          ),
                        ),
                      ),
                    ),
                    TextFormField(
                      controller: _nameController,
                      decoration: const InputDecoration(
                        labelText: 'Name',
                        hintText: 'Enter your name',
                      ),
                      validator: (value) {
                        if (value!.isEmpty) {
                          return 'Please enter your name';
                        }
                        return null;
                      },
                    ),
                    TextFormField(
                      controller: _emailController,
                      decoration: const InputDecoration(
                        labelText: 'Email',
                        hintText: 'Enter your email',
                      ),
                      validator: (value) {
                        if (value!.isEmpty) {
                          return 'Please enter your email';
                        }
                        return null;
                      },
                    ),
                    TextFormField(
                      controller: _phoneNoController,
                      decoration: const InputDecoration(
                        labelText: 'Phone Number',
                        hintText: 'Enter your phone number',
                      ),
                      validator: (value) {
                        if (value!.isEmpty) {
                          return 'Please enter your phone number';
                        }
                        return null;
                      },
                    ),
                    TextFormField(
                      controller: _descriptionController,
                      decoration: const InputDecoration(
                        labelText: 'Description',
                        hintText: 'Enter a short description about yourself',
                      ),
                      maxLines: 3,
                    ),
                    const SizedBox(height: 16.0),
                    ElevatedButton(
                      onPressed: () async {
                        if (_formKey.currentState!.validate()) {
                          // Save the changes and pop the screen
                          final String name = _nameController.text;
                          final String email = _emailController.text;
                          final String phoneNo = _phoneNoController.text;
                          final String description =
                              _descriptionController.text;
                          await updateData().then((value) => value
                              ? ScaffoldMessenger.of(context).showSnackBar(
                                  const SnackBar(
                                    content: Text('Data updated successfully!'),
                                  ),
                                )
                              : ScaffoldMessenger.of(context).showSnackBar(
                                  const SnackBar(
                                    content: Text('Data not updated!!'),
                                  ),
                                ));

                          // showPopup(
                          //     context: context,
                          //     child: AlertDialog(
                          //       title: Text('Profile Updated'),
                          //       content: Text(
                          //           'Your profile has been successfully updated.'),
                          //       actions: [
                          //         TextButton(
                          //           child: Text('OK'),
                          //           onPressed: () {
                          //             Navigator.of(context).pop();
                          //           },
                          //         ),
                          //       ],
                          //     ));

                          Navigator.pop(context);
                        }
                      },
                      child: const Text('Save'),
                    ),
                  ],
                ),
              ),
            ),
          );
  }
}
