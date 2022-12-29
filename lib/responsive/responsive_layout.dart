import 'package:flutter/material.dart';

import 'package:provider/provider.dart';

import '../providers/user_provider.dart';
import '../utils/constant.dart';

class ResponsiveLayout extends StatefulWidget {
  final Widget mobileScreenLayout;
  final Widget webScreenLayout;
  const ResponsiveLayout({
    Key? key,
    required this.mobileScreenLayout,
    required this.webScreenLayout,
  }) : super(key: key);

  @override
  State<ResponsiveLayout> createState() => _ResponsiveLayoutState();
}

class _ResponsiveLayoutState extends State<ResponsiveLayout> {
  @override
  void initState() {
    super.initState();
    //addData();
  }

  addData() async {
    UserProvider _userProvider = Provider.of<UserProvider>(
      context,
    );
    // this is another line
    await _userProvider.refreshUser();
  }

  @override
  void didChangeDependencies() {
    addData();
    super.didChangeDependencies();
  }

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(builder: (context, constraints) {
      if (constraints.maxWidth > webScreenSize) {
        // 600 can be changed to 900 if you want to display tablet screen with mobile screen layout
        return widget.webScreenLayout;
      }
      return widget.mobileScreenLayout;
    });
  }
}
