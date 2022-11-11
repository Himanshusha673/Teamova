import 'package:flutter/material.dart';

import '../utils/colors.dart';

class notification_screen extends StatefulWidget {
 const notification_screen({Key? key}) : super(key: key);

  @override
  State<notification_screen> createState() => _notification_screenState();
}

class _notification_screenState extends State<notification_screen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        // leading: [
        //   Icon(Icons.arrow_back),
        // ],
        leading: IconButton(onPressed: (){}, icon: Icon(Icons.arrow_back)),
        title:Text("Notification",style: TextStyle(fontSize: 20,color: mobileBackgroundColor ),),
      )
    
    );
  }
}