import 'package:flutter/material.dart';
import 'package:flutter_chip_tags/flutter_chip_tags.dart';
// flutter pub add flutter_chip_tags


class SkillDisplay extends StatefulWidget {
  const SkillDisplay({Key? key, this.title}) : super(key: key);
  final String? title;
  @override
  SkillDisplayState createState() => SkillDisplayState();
}

class SkillDisplayState extends State<SkillDisplay> {
  //initialize an empty list
  List<String> _myList = ["Pre-Written"];
  // List<String> _myListCustom = [];
  @override
  Widget build(BuildContext context) {
    return Container(
      child: Padding(
        padding: const EdgeInsets.all(8.0),
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
