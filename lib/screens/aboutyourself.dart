import 'package:flutter/material.dart';
import 'package:flutter_chip_tags/flutter_chip_tags.dart';
import 'package:team_builder/screens/post_screen.dart';
import 'package:toggle_switch/toggle_switch.dart';
import 'package:team_builder/utils/constant.dart';

class Aboutyourself extends StatefulWidget {
  Aboutyourself({Key? key}) : super(key: key);

  @override
  State<Aboutyourself> createState() => _AboutyourselfState();
}

class _AboutyourselfState extends State<Aboutyourself> {
  final _leaderFormKey = GlobalKey<FormState>();
  final _memberFormKey = GlobalKey<FormState>();
  List<String> _myList = ["Pre-Written"];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: Padding(
      padding: const EdgeInsets.all(30.0),
      child: Container(
        child: ListView(
          children: [
            SizedBox(
              height: 20,
            ),
            Center(
                child: Text(
              "ABOUT YOURSELF",
            )),
            SizedBox(
              height: 20,
            ),
            Center(
              child: ToggleSwitch(
                minWidth: 90.0,
                cornerRadius: 20.0,
                activeBgColor: isLeader ? [Colors.green] : [Colors.grey],
                activeFgColor: Colors.white,
                inactiveBgColor: isLeader ? Colors.grey : Colors.green,
                inactiveFgColor: Colors.white,
                initialLabelIndex: 0,
                totalSwitches: 2,
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
                    Navigator.of(context).push(
                        MaterialPageRoute(builder: (context) => PostPage()));
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
              child: Text(isLeader
                  ? 'Enter The fields as a Leader'
                  : 'Enter Field as a Member '),
            ),
          ),
          const SizedBox(height: 10),
          TextFormField(
            decoration: const InputDecoration(
              icon: const Icon(Icons.person),
              hintText: 'Enter your Title Or Objective',
              labelText: 'Objective',
            ),
          ),
           ChipTags(
              list: _myList,
              createTagOnSubmit: true,
              chipColor: Colors.black,
            ),
         
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
              child: Text(isLeader
                  ? 'Enter The fields as a Leader'
                  : 'Enter Field as a Member '),
            ),
          ),
          const SizedBox(height: 10),
           ChipTags(
              list: _myList,
              createTagOnSubmit: true,
              chipColor: Colors.black,
            ),
          TextFormField(
            decoration: const InputDecoration(
              icon: const Icon(Icons.lightbulb_circle_outlined),
              hintText: 'Enter your Ojective./ title  ',
              labelText: 'Objective',
            ),
          ),
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
