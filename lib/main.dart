import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:team_builder/providers/user_provider.dart';
import 'package:team_builder/responsive/mobile_screen_layout.dart';
import 'package:team_builder/responsive/responsive_layout.dart';
import 'package:team_builder/responsive/web_screen_layout.dart';
import 'package:team_builder/screens/login.dart';
import 'package:team_builder/utils/colors.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  // initialise app based on platform- web or mobile
  if (kIsWeb) {
    await Firebase.initializeApp(
      options: const FirebaseOptions(
          apiKey: "AIzaSyA8OfVjEM2yjmXu1EYL8A5nxeFeliQ_37Y",
          appId: "1:943777402555:web:e938ef7036718a64a7a39e",
          messagingSenderId: "943777402555",
          projectId: "teambuilder-ab499",
          storageBucket: 'teambuilder-ab499.appspot.com'),
    );
  } else {
    await Firebase.initializeApp();
  }

  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return
        MultiProvider(
            providers: [
              ChangeNotifierProvider(
                create: (_) => UserProvider(),
              ),
            ],
            child:
      MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Teamova',
      theme: ThemeData.light().copyWith(backgroundColor: mainColor),
      
      home: StreamBuilder(
        stream: FirebaseAuth.instance.authStateChanges(),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.active) {
            // Checking if the snapshot has any data or not
            if (snapshot.hasData) {
              // if snapshot has data which means user is logged in then we 
              //check the width of screen and accordingly display the screen layout
              return const ResponsiveLayout(
                mobileScreenLayout: MobileScreenLayout(),
                webScreenLayout: WebScreenLayout(),
              );
            } else if (snapshot.hasError) {
              return Center(
                child: Text('${snapshot.error}'),
              );
            }
          }

          // means connection to future hasnt been made yet
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(
              child: CircularProgressIndicator(),
            );
          }

          return const LogInPage();
        },
      ),
      ),
      
    );
  }
}
