import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:team_builder/screens/aboutyourself.dart';
import '../resources/auth_methods.dart';
import '../responsive/mobile_screen_layout.dart';
import '../responsive/responsive_layout.dart';
import '../responsive/web_screen_layout.dart';
import '../utils/utils.dart';

class Registration extends StatefulWidget {
  Registration({Key? key}) : super(key: key);

  @override
  State<Registration> createState() => _RegistrationState();
}

class _RegistrationState extends State<Registration> {
  final TextEditingController _nameController = TextEditingController();
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _phoneNoController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  final TextEditingController _passwordConfirmController =
      TextEditingController();

  bool _isLoading = false;

  @override
  void dispose() {
    super.dispose();
    _emailController.dispose();
    _passwordController.dispose();
    _nameController.dispose();
    _phoneNoController.dispose();
  }

  void signUpUser() async {
    // set loading to true
    setState(() {
      _isLoading = true;
    });
    // signup user using our authmethodds
    String res = await AuthMethods().signUpUser(
      name: _nameController.text,
      email: _emailController.text,
      password: _passwordController.text,
      phoneNo: _phoneNoController.text,
    );
    // if string returned is sucess, user has been created
    if (res == "success") {
      setState(() {
        _isLoading = false;
      });
      // navigate to the home screen
      Navigator.of(context).pushReplacement(
        MaterialPageRoute(
          builder: (context) => Aboutyourself(),
          // const ResponsiveLayout(
          //   mobileScreenLayout: MobileScreenLayout(),
          //   webScreenLayout: WebScreenLayout(),
          // ),
        ),
      );
    } else {
      setState(() {
        _isLoading = false;
      });
      // show the error
      showSnackBar(context, res);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: _isLoading
          ? Center(
              child: Container(
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
                              ),
                            ),
                            const SizedBox(
                              height: 7,
                            ),
                            const Padding(
                              padding: EdgeInsets.all(10.0),
                              child: Text(
                                'By registering you agree to Term & Conditions and Privacy Policy of Teamova',
                                style: TextStyle(fontSize: 14),
                                softWrap: true,
                              ),
                            ),
                            const SizedBox(
                              height: 12,
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
                            signUpUser();
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
                    // ElevatedButton(
                    //     child: Text("Create Account",
                    //         style: TextStyle(color: Colors.white)),
                    //     onPressed: () {
                    //       signUpUser();
                    //     }),
                    // SizedBox(
                    //   height: 18,
                    // ),
                    // Padding(
                    //   padding: const EdgeInsets.only(left: 90),
                    //   child: Row(
                    //     children: [
                    //       Text("Already have an Account!",
                    //           style:
                    //               TextStyle(color: Colors.black, fontSize: 16)),
                    //       GestureDetector(
                    //           child: Text(
                    //             "Login Here",
                    //             style:
                    //                 TextStyle(color: Colors.blue, fontSize: 16),
                    //           ),
                    //           onTap: () {
                    //             Navigator.pop(context);
                    //           }),
                    //     ],
                    //   ),
                    // ),
                  ],
                ),
              ),
            ),
    );
  }
}
