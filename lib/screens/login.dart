import 'dart:developer';

import 'package:firebase_auth/firebase_auth.dart';

import 'package:flutter/material.dart';
import 'package:team_builder/screens/forgot_password.dart';
import 'package:team_builder/screens/signup.dart';
import 'package:team_builder/widgets/customDialogBox.dart';

import '../services/auth_methods.dart';
import '../responsive/mobile_screen_layout.dart';
import '../responsive/responsive_layout.dart';
import '../responsive/web_screen_layout.dart';
import '../utils/utils.dart';
import '../widgets/circularIndiacator.dart';
import 'package:sign_button/sign_button.dart';

class LogInPage extends StatefulWidget {
  const LogInPage({Key? key}) : super(key: key);

  @override
  State<LogInPage> createState() => LogState();
}

class LogState extends State<LogInPage> {
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();

  bool _isLoading = false;
  final FirebaseAuth _auth = FirebaseAuth.instance;

  void loginUser() async {
    setState(() {
      _isLoading = true;
    });

    String res = await AuthMethods().loginUser(
      email: _emailController.text,
      password: _passwordController.text,
    );
    if (res == 'success') {
      Navigator.of(context).pushAndRemoveUntil(
          MaterialPageRoute(
            builder: (context) => const ResponsiveLayout(
              mobileScreenLayout: MobileScreenLayout(),
              webScreenLayout: WebScreenLayout(),
            ),
          ),
          (route) => false);
      showCustomDialog(context);

      setState(() {
        _isLoading = false;
      });
    } else {
      setState(() {
        _isLoading = false;
      });
      showSnackBar(context, res);
    }
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
                child: TeamCircularProgressIndicator(
                    teamIcon:
                        'https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcQYAXUsI9H_YUIMdooaoGA_oBUoZbdY19XFPcrUWnV62w&shttps://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcQYAXUsI9H_YUIMdooaoGA_oBUoZbdY19XFPcrUWnV62w&s',
                    size: 64.0,
                    color: Colors.black),
              ),
            )
          : SingleChildScrollView(
              child: Container(
                padding: const EdgeInsets.all(10),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const SizedBox(
                      height: 25,
                    ),
                    Stack(
                      children: [
                        const Image(
                          image: AssetImage('images/login.png'),
                        ),
                        Column(
                          children: [
                            const SizedBox(
                              height: 14,
                            ),
                            Container(
                              alignment: Alignment.topCenter,
                              child: CircleAvatar(
                                radius: 55,
                                backgroundColor: Colors.transparent,
                                child: SizedBox(
                                  child: ClipOval(
                                    child: Image.asset(
                                      "images/TeamovaLogo.png",
                                    ),
                                  ),
                                ),
                              ),
                            ),
                          ],
                        ),
                      ],
                    ),
                    Form(
                      child: Padding(
                        padding: const EdgeInsets.symmetric(vertical: 15.0),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Padding(
                              padding: const EdgeInsets.all(10.0),
                              child: TextFormField(
                                controller: _emailController,
                                keyboardType: TextInputType.emailAddress,
                                decoration: const InputDecoration(
                                  prefixIcon:
                                      Icon(Icons.person_outline_outlined),
                                  labelText: 'Email',
                                  hintText: 'Email',
                                  border: OutlineInputBorder(),
                                ),
                              ),
                            ),
                            Padding(
                              padding: const EdgeInsets.all(10.0),
                              child: TextField(
                                obscureText: true,
                                controller: _passwordController,
                                decoration: const InputDecoration(
                                  prefixIcon: Icon(Icons.fingerprint_outlined),
                                  labelText: 'Password',
                                  hintText: 'Password',
                                  border: OutlineInputBorder(),
                                ),
                              ),
                            ),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.end,
                              children: [
                                GestureDetector(
                                  onTap: () {
                                    Navigator.of(context).push(
                                      MaterialPageRoute(
                                        builder: ((context) =>
                                            const ForgotPasswordScreen()),
                                      ),
                                    );
                                  },
                                  child: const Padding(
                                    padding: EdgeInsets.symmetric(
                                      vertical: 5.0,
                                      horizontal: 8.0,
                                    ),
                                    child: Text(
                                      "Forgot Password ?",
                                      style: TextStyle(
                                        fontSize: 16.0,
                                        color:
                                            Color.fromARGB(255, 42, 143, 250),
                                      ),
                                    ),
                                  ),
                                ),
                              ],
                            ),
                            const SizedBox(height: 10),
                            Row(
                              children: [
                                Expanded(
                                  child: Padding(
                                    padding: const EdgeInsets.symmetric(
                                        horizontal: 7.0),
                                    child: ElevatedButton(
                                      onPressed: () {
                                        loginUser();
                                      },
                                      style: ElevatedButton.styleFrom(
                                        shape: RoundedRectangleBorder(
                                            borderRadius:
                                                BorderRadius.circular(10.0)),
                                        backgroundColor: Colors.black,
                                      ),
                                      child: const Padding(
                                        padding: EdgeInsets.all(15.0),
                                        child: Text(
                                          "LOGIN",
                                          style: TextStyle(
                                            color: Colors.white,
                                            fontSize: 18,
                                          ),
                                        ),
                                      ),
                                    ),
                                  ),
                                ),
                                Expanded(
                                  child: Padding(
                                    padding: const EdgeInsets.symmetric(
                                        horizontal: 7.0),
                                    child: ElevatedButton(
                                      onPressed: () {
                                        Navigator.of(context).pushReplacement(
                                          MaterialPageRoute(
                                            builder: ((context) =>
                                                const Registration()),
                                          ),
                                        );
                                      },
                                      style: ElevatedButton.styleFrom(
                                        shape: RoundedRectangleBorder(
                                            borderRadius:
                                                BorderRadius.circular(10.0)),
                                        backgroundColor: Colors.black,
                                      ),
                                      child: const Padding(
                                        padding: EdgeInsets.all(15.0),
                                        child: Text(
                                          "SIGN UP",
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
                            const SizedBox(
                              height: 20,
                            ),
                            const SizedBox(
                              child: Padding(
                                padding: EdgeInsets.symmetric(vertical: 15.0),
                                child: Center(
                                  child: Text(
                                    "OR",
                                    style: TextStyle(
                                      fontSize: 18,
                                      fontWeight: FontWeight.bold,
                                    ),
                                  ),
                                ),
                              ),
                            ),
                            Center(
                              child: SignInButton(
                                buttonType: ButtonType.google,
                                buttonSize: ButtonSize.large,
                                onPressed: () async {
                                  User? user = _auth.currentUser;
                                  if (user == null) {
                                    // User is not signed in, start the sign-in process
                                    OAuthCredential credential =
                                        await AuthMethods().signInWithGoogle();
                                    UserCredential userCredential = await _auth
                                        .signInWithCredential(credential);

                                    log(credential.toString());
                                    user = userCredential.user;

                                    log(user.toString());
                                  }
                                }, // !TODO : Google sign in
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                    const Center(
                      child: Padding(
                        padding: EdgeInsets.all(18.0),
                        child: FittedBox(
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Icon(
                                Icons.copyright,
                                color: Colors.red,
                                size: 16.0,
                              ),
                              SizedBox(width: 4.0),
                              Text(
                                ' 2023 Teamova. All rights reserved.',
                                style: TextStyle(fontSize: 14),
                                softWrap: true,
                              ),
                            ],
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
}
