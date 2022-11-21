import 'package:flutter/material.dart';
import 'package:flutter_chip_tags/flutter_chip_tags.dart';
import 'package:team_builder/screens/post_screen.dart';
import 'package:toggle_switch/toggle_switch.dart';
import 'package:team_builder/utils/constant.dart';

import '../responsive/mobile_screen_layout.dart';
import '../responsive/responsive_layout.dart';
import '../responsive/web_screen_layout.dart';

class Aboutyourself extends StatefulWidget {
  Aboutyourself({Key? key}) : super(key: key);

  @override
  State<Aboutyourself> createState() => _AboutyourselfState();
}

class _AboutyourselfState extends State<Aboutyourself> {
  final _leaderFormKey = GlobalKey<FormState>();
  final _memberFormKey = GlobalKey<FormState>();
  List<String> _myList = [];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: Padding(
      padding: const EdgeInsets.all(30.0),
      child: Container(
        child: ListView(
          children: [
            SizedBox(
              height: 10,
            ),
            Center(
                child: Text(
              "ABOUT YOURSELF",style:TextStyle(fontSize: 35,fontWeight:FontWeight.bold)
            )),
            SizedBox(
              height: 20,
            ),
            Center(child: Text("CHOOSE WHO YOU ARE?",style: TextStyle(fontSize: 15,fontWeight:FontWeight.bold,color:Colors.blue))),
             SizedBox(
              height: 10,
            ),
            Center(
              child: ToggleSwitch(
                minWidth: 90.0,
                cornerRadius: 20.0,
                borderWidth: 2.0,
                borderColor: [Colors.blueGrey],
                activeBgColor: isLeader ? [Colors.green] : [Colors.black],
                activeFgColor: Colors.white,
                inactiveBgColor: isLeader ? Colors.black54 : Colors.green,
                inactiveFgColor: Colors.white,
                initialLabelIndex: 0,
                totalSwitches: 2,
                 animate: true,
                labels: ['LEADER', 'MEMBER'],
                // radiusStyle: true,
                onToggle: (index) {
                  print("$index");
                  if (index == 0) {
                    setState(() {
                      isLeader = true;
                    });
                  } else {
                    setState(() {
                      isLeader = false;
                    });
                  }
                },
              ),
            ),
            // Ui is for just Member and leader
            isLeader ? leader() : member(),
            SizedBox(height: 30),
            Container(
                alignment: Alignment.center,
                child: ElevatedButton(
                  child: Text('Submit'),
                  onPressed: () {
                    Navigator.of(context).push(MaterialPageRoute(
                      builder: (context) => const ResponsiveLayout(
                        mobileScreenLayout: MobileScreenLayout(),
                        webScreenLayout: WebScreenLayout(),
                      ),
                    ));
                  },
                ))
          ],
        ),
      ),
    ));
  }

  Widget leader() {
    return Form(
      key: _leaderFormKey,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: <Widget>[
          Padding(
            padding: const EdgeInsets.only(top: 18),
            child: Center(
              child: Text('Enter The fields as a Leader',style:TextStyle(fontSize: 20)
                  ),
            ),
          ),
          const SizedBox(height: 18),
          TextFormField(
            decoration: const InputDecoration(
              icon: const Icon(Icons.person),
              hintText: 'Enter your Title Or Objective',
              labelText: 'Objective',
            ),
          ),
           const SizedBox(height: 15),
          Text("SKILL SETS",style: TextStyle(fontSize:15)),
          const SizedBox(height: 5),
          ChipTags(
            list: _myList,
            createTagOnSubmit: true,
            chipColor: Colors.black,
          ),
           const SizedBox(height: 10),
          TextFormField(
            decoration: const InputDecoration(
              icon: const Icon(Icons.calendar_today),
              hintText: 'Description (around 20 words atleast)',
              labelText: 'description',
            ),
          ),
        ],
      ),
    );
  }

  Widget member() {
    return Form(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: <Widget>[
          Padding(
            padding: const EdgeInsets.only(top: 18),
            child: Center(
              child: Text('Enter Field as a Member ',style:TextStyle(fontSize: 20)),
            ),
          ),
          const SizedBox(height: 18),
            TextFormField(
            decoration: const InputDecoration(
              icon: const Icon(Icons.lightbulb_circle_outlined),
              hintText: 'Enter your Ojective./ title  ',
              labelText: 'Objective',
            ),
          ),
           const SizedBox(height: 15),
            Text("SKILL SETS",style: TextStyle(fontSize:15)),
            const SizedBox(height: 5),
           ChipTags(
            list: _myList,
            createTagOnSubmit: true,
            chipColor: Colors.black,
          ),
           const SizedBox(height: 10),
          TextFormField(
            decoration: const InputDecoration(
              icon: const Icon(Icons.calendar_today),
              hintText: 'Enter your date of birth',
              labelText: 'Dob',
            ),
          ),
        ],
      ),
    );
  }
}
