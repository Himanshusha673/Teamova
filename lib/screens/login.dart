import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:team_builder/screens/signup.dart';
import '../resources/auth_methods.dart';
import '../responsive/mobile_screen_layout.dart';
import '../responsive/responsive_layout.dart';
import '../responsive/web_screen_layout.dart';
import '../utils/utils.dart';
import 'aboutyourself.dart';
import 'package:sign_button/sign_button.dart';

class LogInPage extends StatefulWidget {
  const LogInPage({Key? key}) : super(key: key);

  @override
  State<LogInPage> createState() => _logState();
}

class _logState extends State<LogInPage> {
  TextEditingController _emailController = TextEditingController();
  TextEditingController _passwordController = TextEditingController();
  bool _isLoading = false;

  void loginUser() async {
    setState(() {
      _isLoading = true;
    });
    String res = await AuthMethods().loginUser(
        email: _emailController.text, password: _passwordController.text);
    if (res == 'success') {
      Navigator.of(context).pushAndRemoveUntil(
          MaterialPageRoute(
            builder: (context) => const ResponsiveLayout(
              mobileScreenLayout: MobileScreenLayout(),
              webScreenLayout: WebScreenLayout(),
            ),
          ),
          (route) => false);

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
          ? Center(
              child: Container(
                height: 10,
                width: 10,
                child: CircularProgressIndicator(),
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
                                  // width: MediaQuery.of(context).size.width,
                                  // height: MediaQuery.of(context).size.height,
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
                                controller: _passwordController,
                                decoration: const InputDecoration(
                                  prefixIcon: Icon(Icons.fingerprint_outlined),
                                  labelText: 'Password',
                                  hintText: 'Password',
                                  border: OutlineInputBorder(),
                                ),
                              ),
                            ),
                            Align(
                              alignment: Alignment.centerRight,
                              child: GestureDetector(
                                child: const Padding(
                                  padding: EdgeInsets.all(10.0),
                                  child: Text(
                                    "Forget Password ?", // TODO : Fix feature
                                    style: TextStyle(
                                      fontSize: 16.0,
                                      color: Colors.blue,
                                    ),
                                  ),
                                ),
                              ),
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
                                        Navigator.of(context).push(
                                          MaterialPageRoute(
                                            builder: ((context) =>
                                                Registration()),
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
                                          "REGISTER",
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
                                onPressed: () {}, // !TODO : Google sign in
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
}
