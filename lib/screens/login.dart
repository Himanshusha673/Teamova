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
              child: Padding(
                padding: EdgeInsets.all(8.0),
                child: Column(children: [
                  SizedBox(
                    height: 50,
                  ),
                  Image.asset(
                    'images/TeamovaLogo.png',
                    // height: MediaQuery.of(context).size.height*0.1,
                    // width: MediaQuery.of(context).size.width*0.3,
                  ),
                  SizedBox(
                    height: 80,
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                      ElevatedButton(
                          onPressed: () {},
                          child: Text(
                            "Facebook",
                            style: TextStyle(color: Colors.blue, fontSize: 20),
                          ),
                          style: ElevatedButton.styleFrom(
                            shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(10.0)),
                            primary: Colors.white,
                          )),
                      ElevatedButton(
                          onPressed: () {},
                          child: Text("Google",
                              style: TextStyle(
                                  color: Colors.redAccent, fontSize: 20)),
                          style: ElevatedButton.styleFrom(
                              shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(10.0)),
                              primary: Colors.white))
                    ],
                  ),
                  SizedBox(
                    height: 50,
                  ),
                  Text("SignIn",
                      style: TextStyle(
                          color: Colors.black,
                          fontSize: 30,
                          fontWeight: FontWeight.bold)),
                  Padding(
                    padding: EdgeInsets.all(15.0),
                    child: Column(
                      children: [
                        Padding(
                          padding: EdgeInsets.all(10.0),
                          child: TextField(
                            controller: _emailController ,
                            keyboardType: TextInputType.emailAddress,
                            decoration: InputDecoration(
                                labelText: 'Email', hintText: 'Email'),
                          ),
                        ),
                        Padding(
                          padding: EdgeInsets.all(10.0),
                          child: TextField(
                            controller: _passwordController,
                            decoration: InputDecoration(
                                labelText: 'Password', hintText: 'Password'),
                          ),
                        ),
                        Padding(
                          padding: EdgeInsets.only(left: 310, top: 10),
                          child: GestureDetector(
                            child: Text("Forget Password?",
                                style: TextStyle(color: Colors.black)),
                          ),
                        )
                      ],
                    ),
                  ),
                  ElevatedButton(
                      child: Text("Login",
                          style: TextStyle(color: Colors.white, fontSize: 15)),
                      onPressed: () {
                       loginUser();
                        // Navigator.of(context).push(MaterialPageRoute(
                        //     builder: ((context) => Aboutyourself())));
                        // if (!_emailController.text.contains("@")) {
                        //   Fluttertoast.showToast(
                        //       msg: "PLEASE WRITE A VALID EMAIL ADDRESS");
                        // } else if (_passwordController.text.length < 8) {
                        //   Fluttertoast.showToast(
                        //       msg: "PASSWORD SHOULD BE GREATER THAN 8 WORDS");
                        // } else {
                        //   setState(() {
                        //     _isLoading = true;
                        //   });
                          // login(email.text, password.text).then((user) {
                          //   if (user != null) {
                          //     setState(() {
                          //       isloading = false;
                          //     });
                          //     Fluttertoast.showToast(msg: "LOGIN SUCCESSFUL");
                          //     // Navigator.push(context, MaterialPageRoute(builder: ((context) => homepage())));
                          //   } else {
                          //     Fluttertoast.showToast(
                          //         msg: "LOGIN Failed try again");
                          //   }
                          // });
                       // }
                      },
                      style: ElevatedButton.styleFrom(
                          shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(10.0)),
                          primary: Colors.black)),
                  SizedBox(
                    height: 20,
                  ),
                  Padding(
                    padding: const EdgeInsets.only(left: 90),
                    child: Row(
                      children: [
                        Text("Don't have any account?",
                            style:
                                TextStyle(color: Colors.black, fontSize: 16)),
                        GestureDetector(
                            child: Text(
                              "Register Here!.",
                              style:
                                  TextStyle(color: Colors.blue, fontSize: 16),
                            ),
                            onTap: () {
                              Navigator.of(context).push(MaterialPageRoute(
                                  builder: ((context) => Registration())));
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
