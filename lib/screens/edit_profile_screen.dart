import 'package:flutter/material.dart';

class EditProfileScreen extends StatefulWidget {
  final String name;
  final String email;
  final String phoneNo;
  final String description;

  EditProfileScreen(
      {required this.name,
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

  @override
  void initState() {
    super.initState();
    _nameController = TextEditingController(text: widget.name);
    _emailController = TextEditingController(text: widget.email);
    _phoneNoController = TextEditingController(text: widget.phoneNo);
    _descriptionController = TextEditingController(text: widget.description);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Edit Profile'),
      ),
      body: Form(
        key: _formKey,
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: ListView(
            children: [
              Container(
                width: 120.0,
                height: 120.0,
                child: GestureDetector(
                  onTap: () {
                    // Code to update profile photo
                  },
                  child: CircleAvatar(
                    backgroundImage: NetworkImage(
                        "https://www.kindpng.com/picc/m/21-214439_free-high-quality-person-icon-default-profile-picture.png"),
                    radius: 60.0,
                    child: Icon(
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
                onPressed: () {
                  if (_formKey.currentState!.validate()) {
                    // Save the changes and pop the screen
                    final String name = _nameController.text;
                    final String email = _emailController.text;
                    final String phoneNo = _phoneNoController.text;
                    final String description = _descriptionController.text;

                    Navigator.pop(context, {
                      'name': name,
                      'email': email,
                      'phoneNo': phoneNo,
                      'description': description,
                    });
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
