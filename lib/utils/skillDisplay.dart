import 'package:flutter/material.dart';
// flutter pub add flutter_chip_tags


class SkillDisplay extends StatefulWidget {
  const SkillDisplay({Key? key, this.title}) : super(key: key);
  final String? title;
  @override
  SkillDisplayState createState() => SkillDisplayState();
}

class SkillDisplayState extends State<SkillDisplay> {
  //initialize an empty list
  final List<String> _myList = ["Pre-Written"];
  // List<String> _myListCustom = [];
  @override
  Widget build(BuildContext context) {
    return Container(
      child: const Padding(
        padding: EdgeInsets.all(8.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            //Default use space to seprate
           
          ],
        ),
      ),
    );
  }
}
