import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
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
                padding: EdgeInsets.all(8.0),
                child: Column(children: [
                  SizedBox(
                    height: 40,
                  ),
                  Row(
                    children: [
                      SizedBox(
                        width: 17,
                      ),
                      Icon(
                        Icons.arrow_back,
                        size: 40,
                      ),
                      SizedBox(
                        width: 20,
                      ),
                      Text("Registeration",
                          style: TextStyle(color: Colors.black, fontSize: 40)),
                    ],
                  ),
                  Padding(
                    padding: EdgeInsets.all(15.0),
                    child: Column(
                      children: [
                        Padding(
                          padding: EdgeInsets.all(10.0),
                          child: TextField(
                            controller: _nameController,
                            keyboardType: TextInputType.name,
                            decoration: InputDecoration(
                                labelText: 'Name',
                                labelStyle: TextStyle(
                                    fontSize: 14.0, color: Colors.black),
                                hintStyle: TextStyle(
                                    color: Colors.black, fontSize: 14.0)),
                          ),
                        ),
                        Padding(
                          padding: EdgeInsets.all(10.0),
                          child: TextField(
                            controller: _emailController,
                            keyboardType: TextInputType.emailAddress,
                            decoration: InputDecoration(
                                labelText: 'Email',
                                hintStyle: TextStyle(
                                    color: Colors.black, fontSize: 14.0)),
                          ),
                        ),
                        Padding(
                          padding: EdgeInsets.all(10.0),
                          child: TextField(
                            controller: _phoneNoController,
                            keyboardType: TextInputType.phone,
                            decoration: InputDecoration(
                                labelText: 'Phone',
                                hintStyle: TextStyle(
                                    color: Colors.black, fontSize: 14.0)),
                          ),
                        ),
                        Padding(
                          padding: EdgeInsets.all(10.0),
                          child: TextField(
                            controller: _passwordController,
                            decoration: InputDecoration(
                                labelText: 'Password',
                                hintStyle: TextStyle(
                                    color: Colors.black, fontSize: 14.0)),
                          ),
                        ),
                        Padding(
                          padding: EdgeInsets.all(10.0),
                          child: TextField(
                            controller: _passwordConfirmController,
                            keyboardType: TextInputType.phone,
                            decoration: InputDecoration(
                                labelText: 'Confirm Password',
                                hintStyle: TextStyle(
                                    color: Colors.black, fontSize: 14.0)),
                          ),
                        ),
                      ],
                    ),
                  ),
                  SizedBox(
                    width: MediaQuery.of(context).size.width * 0.8,
                    child: Text(
                      'By registering you agree to Term & Conditions and Privacy Policy of the TeamBuilder ',
                      style: TextStyle(fontSize: 13),
                      softWrap: false,
                      maxLines: 2,
                    ),
                  ),
                  SizedBox(
                    height: 5,
                  ),
                  Center(
                    child: Text(
                      'Policy of the TeamBuilder ',
                      style: TextStyle(fontSize: 13),
                      softWrap: false,
                      maxLines: 2,
                    ),
                  ),
                  SizedBox(
                    height: 20,
                  ),
                  ElevatedButton(
                      child: Text("Create Account",
                          style: TextStyle(color: Colors.white)),
                      onPressed: () {
                        signUpUser();
                      }),
                  SizedBox(
                    height: 18,
                  ),
                  Padding(
                    padding: const EdgeInsets.only(left: 90),
                    child: Row(
                      children: [
                        Text("Already have an Account!",
                            style:
                                TextStyle(color: Colors.black, fontSize: 16)),
                        GestureDetector(
                            child: Text(
                              "Login Here",
                              style:
                                  TextStyle(color: Colors.blue, fontSize: 16),
                            ),
                            onTap: () {
                              Navigator.pop(context);
                            }),
                      ],
                    ),
                  ),
                ]),
              ),
            ),
    );
  }
}
