import 'dart:ui';
import 'package:flutter/material.dart';

// display the child widget, as alert popup
// with glass blur background
showPopup({required BuildContext context, required Widget child}) {
  showDialog(
    context: context,
    builder: (BuildContext context) {
      return ClipRect(
        child: BackdropFilter(
          filter: ImageFilter.blur(sigmaX: 10.0, sigmaY: 10.0),
          child: Container(
            width: 200.0,
            height: 200.0,
            decoration:
                BoxDecoration(color: Colors.grey.shade100.withOpacity(0.6)),
            child: Stack(
              children: [
                Center(child: child),
              ],
            ),
          ),
        ),
      );
    },
  );
}

//To show alert dialog on screen
//error message
//used for error messages
class PopUpWidget extends StatefulWidget {
  final String message;
  final Function() onPressed;
  const PopUpWidget({
    super.key,
    required this.message,
    required this.onPressed,
  });

  @override
  State<PopUpWidget> createState() => _PopUpWidgetState();
}

class _PopUpWidgetState extends State<PopUpWidget> {
  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        Padding(
          padding: const EdgeInsets.all(25.0),
          child: Material(
            borderRadius: BorderRadius.circular(8),
            elevation: 10,
            shadowColor: Colors.white,
            child: Container(
              padding: const EdgeInsets.only(
                  top: 48, left: 16, right: 16, bottom: 16),
              width: MediaQuery.of(context).size.width * 0.8,
              height: MediaQuery.of(context).size.height * 0.3,
              child: Column(
                children: [
                  Text(
                    widget.message,
                    style: const TextStyle(color: Colors.black),
                  ),
                  const SizedBox(height: 24),
                  SizedBox(
                      width: MediaQuery.of(context).size.width * .65,
                      child: ElevatedButton(
                        onPressed: () {},
                        child: const Text('OK,Proceed'),
                      )),
                  const SizedBox(height: 8),
                  GestureDetector(
                    onTap: () {
                      Navigator.pop(context);
                    },
                    child: const Text(
                      'cancel',
                      style: TextStyle(
                        decoration: TextDecoration.underline,
                      ),
                    ),
                  )
                ],
              ),
            ),
          ),
        ),
        Positioned(
          left: MediaQuery.of(context).size.width / 2.65,
          child: Material(
            shadowColor: Colors.white,
            borderRadius: BorderRadius.circular(100),
            child: Padding(
              padding: const EdgeInsets.all(4.0),
              child: Container(
                width: 44,
                height: 44,
                decoration: BoxDecoration(
                  color: Colors.orange.shade800,
                  borderRadius: BorderRadius.circular(100),
                ),
                padding: const EdgeInsets.all(0),
                child: const Center(
                  child: Icon(
                    Icons.warning_rounded, color: Colors.white,
                    // size: 55,
                  ),
                ),
              ),
            ),
          ),
        ),
      ],
    );
  }
}
