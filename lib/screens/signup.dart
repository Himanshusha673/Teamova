import 'package:flutter/material.dart';

import 'package:team_builder/screens/aboutyourself.dart';
import 'package:team_builder/screens/login.dart';

class Registration extends StatefulWidget {
  const Registration({Key? key}) : super(key: key);

  @override
  State<Registration> createState() => _RegistrationState();
}

class _RegistrationState extends State<Registration> {
  final _formKey = GlobalKey<FormState>();
  final TextEditingController _nameController = TextEditingController();
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _phoneNoController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  final TextEditingController _passwordConfirmController =
      TextEditingController();

  final bool _isLoading = false;

  @override
  void dispose() {
    super.dispose();
    _emailController.dispose();
    _passwordController.dispose();
    _nameController.dispose();
    _phoneNoController.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: _isLoading
          ? const Center(
              child: SizedBox(
                height: 10,
                width: 10,
                child: CircularProgressIndicator(),
              ),
            )
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
                          "Register Yourself",
                          style: TextStyle(
                            color: Colors.black,
                            fontSize: 25.0,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ),
                    ),
                    Form(
                      key: _formKey,
                      child: Padding(
                        padding: const EdgeInsets.symmetric(vertical: 10.0),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Padding(
                              padding: const EdgeInsets.all(10.0),
                              child: TextFormField(
                                controller: _nameController,
                                keyboardType: TextInputType.name,
                                decoration: const InputDecoration(
                                  prefixIcon:
                                      Icon(Icons.person_outline_outlined),
                                  labelText: 'Full Name',
                                  hintText: 'Enter Name',
                                  border: OutlineInputBorder(),
                                ),
                                validator: validatename,
                              ),
                            ),
                            const SizedBox(
                              height: 7,
                            ),
                            Padding(
                              padding: const EdgeInsets.all(10.0),
                              child: TextFormField(
                                controller: _emailController,
                                keyboardType: TextInputType.emailAddress,
                                decoration: const InputDecoration(
                                  prefixIcon: Icon(Icons.email_outlined),
                                  labelText: 'Email',
                                  hintText: 'Enter Email',
                                  border: OutlineInputBorder(),
                                ),
                                validator: validateemail,
                              ),
                            ),
                            const SizedBox(
                              height: 7,
                            ),
                            Padding(
                              padding: const EdgeInsets.all(10.0),
                              child: TextFormField(
                                controller: _phoneNoController,
                                keyboardType: TextInputType.phone,
                                decoration: const InputDecoration(
                                  prefixIcon: Icon(Icons.phone_outlined),
                                  labelText: 'Mobile Number',
                                  hintText: 'Enter Mobile Number',
                                  border: OutlineInputBorder(),
                                ),
                                validator: validatemobile,
                              ),
                            ),
                            const SizedBox(
                              height: 7,
                            ),
                            Padding(
                              padding: const EdgeInsets.all(10.0),
                              child: TextFormField(
                                obscureText: true,
                                enableSuggestions: false,
                                autocorrect: false,
                                controller: _passwordController,
                                decoration: const InputDecoration(
                                  prefixIcon: Icon(Icons.password_outlined),
                                  labelText: 'Password',
                                  hintText: 'Enter Password',
                                  border: OutlineInputBorder(),
                                ),
                                validator: validatepassword,
                              ),
                            ),
                            const SizedBox(
                              height: 7,
                            ),
                            Padding(
                              padding: const EdgeInsets.all(10.0),
                              child: TextFormField(
                                obscureText: true,
                                enableSuggestions: false,
                                autocorrect: false,
                                controller: _passwordConfirmController,
                                decoration: const InputDecoration(
                                  prefixIcon: Icon(Icons.password_outlined),
                                  labelText: 'Confirm Password',
                                  hintText: 'Enter Password',
                                  border: OutlineInputBorder(),
                                ),
                                validator: validateconfirmpassword,
                              ),
                            ),
                            const SizedBox(
                              height: 7,
                            ),
                          ],
                        ),
                      ),
                    ),
                    SizedBox(
                      width: double.infinity,
                      child: Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 7.0),
                        child: ElevatedButton(
                          onPressed: () {
                            if (_formKey.currentState!.validate()) {
                              Navigator.of(context)
                                  .pushReplacement(MaterialPageRoute(
                                builder: (context) => Aboutyourself(
                                    email: _emailController.text,
                                    password: _passwordController.text,
                                    name: _nameController.text,
                                    phoneNo: _phoneNoController.text),
                              ));
                              return;
                            }
                          },
                          style: ElevatedButton.styleFrom(
                            shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(10.0)),
                            backgroundColor: Colors.black,
                          ),
                          child: const Padding(
                            padding: EdgeInsets.all(15.0),
                            child: Text(
                              "CREATE ACCOUNT",
                              style: TextStyle(
                                color: Colors.white,
                                fontSize: 18,
                              ),
                            ),
                          ),
                        ),
                      ),
                    ),
                    const SizedBox(
                      height: 20,
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: <Widget>[
                        const Text(
                          "Already have an account? ",
                          style: TextStyle(
                            color: Colors.black,
                            fontSize: 16.0,
                          ),
                        ),
                        GestureDetector(
                          onTap: () {
                            Navigator.of(context).pushReplacement(
                              MaterialPageRoute(
                                  builder: (BuildContext context) =>
                                      const LogInPage()),
                            );
                          },
                          child: const Text(
                            "Login",
                            style: TextStyle(
                              color: Colors.blue,
                              fontSize: 16.0,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ),
                      ],
                    ),
                    Center(
                      child: Padding(
                        padding: const EdgeInsets.only(
                            top: 40.0, left: 20, right: 20, bottom: 20),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            const Icon(Icons.info_outline,
                                color: Colors.grey, size: 25.0),
                            const SizedBox(width: 5.0),
                            Expanded(
                              child: Column(
                                children: [
                                  RichText(
                                    text: const TextSpan(
                                      style: TextStyle(
                                        fontSize: 14.0,
                                        color: Colors.black,
                                      ),
                                      children: [
                                        TextSpan(
                                          text:
                                              'By registering you agree to our ',
                                        ),
                                        TextSpan(
                                          text: 'Terms & Conditions ',
                                          style: TextStyle(
                                            decoration:
                                                TextDecoration.underline,
                                          ),
                                        ),
                                        TextSpan(
                                          text: 'and ',
                                        ),
                                        TextSpan(
                                          text: 'Privacy Policy ',
                                          style: TextStyle(
                                            decoration:
                                                TextDecoration.underline,
                                          ),
                                        ),
                                        TextSpan(
                                          text: 'of Teamova.',
                                        ),
                                      ],
                                    ),
                                    softWrap: true,
                                    textAlign: TextAlign.center,
                                  ),
                                ],
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
    );
  }

  String? validateemail(String? value) {
    String pattern =
        r'^(([^<>()[\]\\.,;:\s@\"]+(\.[^<>()[\]\\.,;:\s@\"]+)*)|(\".+\"))@((\[[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\])|(([a-zA-Z\-0-9]+\.)+[a-zA-Z]{2,}))$';
    RegExp regex = RegExp(pattern);
    if (!regex.hasMatch(value!)) {
      return 'Enter Valid Email';
    } else {
      return null;
    }
  }

  String? validatemobile(String? value) {
// Indian Mobile number are of 10 digit only
    if (value!.length != 10) {
      return 'Mobile Number must be of 10 digit';
    } else {
      return null;
    }
  }

  String? validatename(String? value) {
    if (value!.length < 3) {
      return 'Name must be more than 2 charater';
    } else {
      return null;
    }
  }

  String? validatepassword(String? value) {
    if (value!.length < 6) {
      return 'Password must be more than 6 charater';
    } else {
      return null;
    }
  }

  String? validateconfirmpassword(String? value) {
    if (value == null) {
      return 'Please re-enter password';
    }

    if (_passwordController.text != _passwordConfirmController.text) {
      return "Password does not match";
    }
    return null;
  }
}
