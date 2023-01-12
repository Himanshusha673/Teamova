import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:team_builder/screens/post_screen.dart';
import '../screens/feed_screen.dart';
import '../screens/profile.dart';
import '../screens/search.dart';

const webScreenSize = 600;
bool isLeader = true;

//for bottom navogation bar

List<Widget> homeScreenItems = [
  const FeedScreen(),
  const SearchPage(),
  const PostPage(),
  ProfilePage(uid: FirebaseAuth.instance.currentUser!.uid),
];
