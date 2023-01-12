import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:team_builder/providers/user_provider.dart';
import 'package:team_builder/screens/tems.dart';
import 'package:team_builder/utils/colors.dart';

import '../models/user_model.dart' as model;
import '../utils/utils.dart';

class ProfilePage extends StatefulWidget {
  final String uid;

  ProfilePage({super.key, required this.uid});

  @override
  State<ProfilePage> createState() => _ProfilePageState();
}

class _ProfilePageState extends State<ProfilePage> {
  bool isLoading = false;
  int postLen = 0;
  var userData = {};
  @override
  void initState() {
    super.initState();
    getDatas();
  }

  getDatas() async {
    setState(() {
      var isLoading = true;
    });
    try {
      var snap = await FirebaseFirestore.instance
          .collection('users')
          .doc(widget.uid)
          .get();
      userData = snap.data()!;

      // get post lENGTH
      var postSnap = await FirebaseFirestore.instance
          .collection('posts')
          .where('uid', isEqualTo: FirebaseAuth.instance.currentUser!.uid)
          .get();

      postLen = postSnap.docs.length;
    } catch (e) {
      showSnackBar(
        context,
        e.toString(),
      );
    }
    setState(() {
      isLoading = false;
    });
  }

  @override
  Widget build(BuildContext context) {
    final model.User userProvider = Provider.of<UserProvider>(context).getUser;

    // final List<String> list = ["fluttter", "dart"];
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: Text(userData['name'].toString()),

        // leading: const BackButton(),
        // elevation: 0,
        // backgroundColor: Colors.transparent,
      ),
      body: ListView(
        physics: const BouncingScrollPhysics(),
        children: [
          Padding(
            padding: const EdgeInsets.only(top: 20),
            child: ProfileWidget(
              imagePath: userProvider.photoUrl,
              onClicked: () async {}, // Add function
            ),
          ),
          const SizedBox(
            height: 24,
          ),
          buildName(
            userData['name'].toString(),
            userData['email'].toString(),
            userData['objective'].toString(),
            userData['phoneNo'].toString(),
          ),
          const SizedBox(
            height: 20,
          ),
          Center(
            child: ButtonWidget(
              text: userProvider.isLeader
                  ? 'LEADER'
                  : 'MEMBER', // Should change depending on whether leader or member
              onClicked: () {},
              uid: widget
                  .uid, // Add function - Add widget that shows group links
            ),
          ),
          const SizedBox(
            height: 20,
          ),
          // Center(
          //   child: ButtonWidget(
          //     text: '🔥 Interests 🔥',
          //     onClicked: () {}, // Add function - Add tags
          //   ),
          // ),
          buildTags(userData['skills']),
          const SizedBox(
            height: 24,
          ),
          buildAbout(userData['description'].toString()), // Add about details
          const SizedBox(
            height: 24,
          ),
        ],
      ),
    );
  }
}

class ProfileWidget extends StatelessWidget {
  final String imagePath;
  final bool isEdit;
  final VoidCallback onClicked;

  const ProfileWidget({
    Key? key,
    required this.imagePath,
    this.isEdit = false,
    required this.onClicked,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    const color = mainColor;

    return Center(
      child: Stack(
        children: [
          buildImage(),
          Positioned(
            bottom: 0,
            right: 4,
            child: buildEditIcon(color),
          ),
        ],
      ),
    );
  }

  Widget buildImage() {
    final image = NetworkImage(imagePath);

    return ClipOval(
      child: Material(
        color: Colors.transparent,
        child: Ink.image(
          image: image,
          fit: BoxFit.cover,
          width: 128,
          height: 128,
          child: InkWell(onTap: onClicked),
        ),
      ),
    );
  }

  Widget buildEditIcon(Color color) => buildCircle(
        color: Colors.white,
        all: 3,
        child: buildCircle(
          color: color,
          all: 8,
          child: Icon(
            isEdit ? Icons.add_a_photo : Icons.edit,
            color: Colors.white,
            size: 20,
          ),
        ),
      );

  Widget buildCircle({
    required Widget child,
    required double all,
    required Color color,
  }) =>
      ClipOval(
        child: Container(
          padding: EdgeInsets.all(all),
          color: color,
          child: child,
        ),
      );
}

Widget buildName(String name, String userName, String email, String phone) {
  return Column(
    children: [
      Text(
        name,
        style: const TextStyle(
          fontWeight: FontWeight.bold,
          fontSize: 24,
        ),
      ),
      const SizedBox(height: 4),
      Text(
        userName,
        style: const TextStyle(
          fontWeight: FontWeight.bold,
          fontSize: 17,
        ),
      ),
      const SizedBox(height: 4),
      Text(
        email,
        style: TextStyle(
          color: Colors.grey.shade700,
        ),
      ),
      const SizedBox(height: 4),
      Text(
        phone,
        style: TextStyle(
          color: Colors.grey.shade700,
        ),
      )
    ],
  );
}

class ButtonWidget extends StatelessWidget {
  final String text;
  final VoidCallback onClicked;
  final uid;

  const ButtonWidget({
    Key? key,
    required this.uid,
    required this.text,
    required this.onClicked,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) => ElevatedButton(
        style: ElevatedButton.styleFrom(
          //foregroundColor: Colors.white,
          shape: const StadiumBorder(),
          padding: const EdgeInsets.symmetric(horizontal: 32, vertical: 12),
        ),
        onPressed: () {
          Navigator.push(
              context,
              MaterialPageRoute(
                  builder: (contex) => TeamsPost(
                        uid: uid,
                      )));
        },
        child: Column(
          children: [
            Text(
              text,
              style: const TextStyle(
                // color: Colors.grey,
                fontWeight: FontWeight.bold,
                fontSize: 16,
              ),
            ),
            const SizedBox(
              height: 3,
            ),
            const Text(
              "Click To View Your Teams",
              style: TextStyle(
                // color: Colors.grey,
                fontSize: 11,
              ),
            ),
          ],
        ),
      );
}

Widget buildAbout(String about) {
  return Container(
    padding: const EdgeInsets.symmetric(horizontal: 35),
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Text(
          'About',
          style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
        ),
        const SizedBox(height: 16),
        Text(
          about,
          style: const TextStyle(fontSize: 16, height: 1.4),
        ),
      ],
    ),
  );
}

Widget buildChip(String label, Color color) {
  return Chip(
    labelPadding: const EdgeInsets.all(2.0),
    label: Text(
      label,
      style: const TextStyle(
        color: Colors.white,
      ),
    ),
    backgroundColor: color,
    elevation: 6.0,
    shadowColor: Colors.grey[60],
    padding: const EdgeInsets.all(10.0),
  );
}

Widget chipList(List<dynamic> tags) {
  return Wrap(
    spacing: 6.0,
    runSpacing: 6.0,
    children: <Widget>[
      ...(tags).map((option) {
        return buildChip(option, Colors.black);
      }).toList(),
    ],
  );
}

Widget buildTags(List<dynamic> tags) {
  return Container(
    padding: const EdgeInsets.symmetric(horizontal: 35),
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Text(
          'Interests',
          style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
        ),
        const SizedBox(height: 16),
        chipList(tags),
      ],
    ),
  );
}
