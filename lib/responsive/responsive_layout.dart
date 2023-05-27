import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

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
  //@override
  // void initState() {
  //   addData();
  //   super.initState();
  // }

  addData() async {
    UserProvider userProvider = Provider.of<UserProvider>(
      context,
    );
    // this is another line
    await userProvider.refreshUser();
  }

  bool _dataAdded = false;

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();

    if (!_dataAdded) {
      addData();
      _dataAdded = true;
    }
  }

  DateTime? _lastPressed;

  @override
  Widget build(BuildContext context) {
    return WillPopScope(onWillPop: () async {
      final now = DateTime.now();
      if (_lastPressed == null ||
          now.difference(_lastPressed!) > const Duration(seconds: 2)) {
        _lastPressed = now;
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: const Text('Press back again to exit'),
            backgroundColor: Colors.grey[700],
            duration: const Duration(seconds: 2),
            width: 280.0, // Width of the SnackBar.
            padding: const EdgeInsets.symmetric(
              horizontal: 8.0, // Inner padding for SnackBar content.
            ),
            behavior: SnackBarBehavior.floating,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(10.0),
            ),
            action: SnackBarAction(
              label: 'Exit',
              onPressed: () => SystemNavigator.pop(),
              textColor: Colors.red,
            ),
          ),
        );
        return false;
      }
      return true;
    }, child: LayoutBuilder(builder: (context, constraints) {
      if (constraints.maxWidth > webScreenSize) {
        // 600 can be changed to 900 if you want to display tablet screen with mobile screen layout
        return widget.webScreenLayout;
      }
      return widget.mobileScreenLayout;
    }));
  }
}
