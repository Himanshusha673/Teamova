import 'dart:async';

import 'package:flutter/material.dart';
import 'package:team_builder/screens/forgot_password.dart';
import 'package:team_builder/screens/signup.dart';
import 'package:team_builder/widgets/customDialogBox.dart';
import 'package:team_builder/widgets/signin.dart';

import '../services/auth_methods.dart';
import '../responsive/mobile_screen_layout.dart';
import '../responsive/responsive_layout.dart';
import '../responsive/web_screen_layout.dart';
import '../utils/utils.dart';
import '../widgets/circularIndiacator.dart';

class LogInPage extends StatefulWidget {
  const LogInPage({Key? key}) : super(key: key);

  @override
  State<LogInPage> createState() => LogState();
}

class LogState extends State<LogInPage> {
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();

  bool _isLoading = false;

  void loginUser(BuildContext context) async {
    setState(() {
      _isLoading = true;
    });

    String res = await AuthMethods().loginUser(
      email: _emailController.text,
      password: _passwordController.text,
    );
    if (res == 'success') {
      final completer = Completer();

      Future<void> navigateAndShowDialog() async {
        Navigator.of(context).pushAndRemoveUntil(
          MaterialPageRoute(
            builder: (context) => const ResponsiveLayout(
              mobileScreenLayout: MobileScreenLayout(),
              webScreenLayout: WebScreenLayout(),
            ),
          ),
          (route) => false,
        );

        await Future.delayed(const Duration(
            milliseconds: 300)); // Optional delay for smoother transition

        showCustomDialog(context);

        setState(() {
          _isLoading = false;
        });

        completer.complete();
      }

      await navigateAndShowDialog();
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
                                        loginUser(context);
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
                              height: 30,
                            ),
                            Center(
                              child: SignIn(),
                            ),
                          ],
                        ),
                      ),
                    ),
                    Center(
                      child: Padding(
                        padding: const EdgeInsets.all(18.0),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: const [
                            Icon(
                              Icons.copyright,
                              color: Colors.red,
                              size: 16.0,
                            ),
                            SizedBox(width: 4.0),
                            Text(
                              '2023 Teamova. All rights reserved.',
                              style: TextStyle(fontSize: 14),
                              softWrap: true,
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
}
