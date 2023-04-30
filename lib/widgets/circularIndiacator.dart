import 'package:flutter/material.dart';

class TeamCircularProgressIndicator extends StatelessWidget {
  final String teamIcon;
  final double size;
  final Color color;

  const TeamCircularProgressIndicator(
      {Key? key,
      required this.teamIcon,
      this.size = 32.0,
      this.color = Colors.blue})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      width: size,
      height: size,
      decoration: BoxDecoration(
        shape: BoxShape.circle,
        image: DecorationImage(
          image: NetworkImage(teamIcon),
          fit: BoxFit.cover,
        ),
      ),
      child: CircularProgressIndicator(
        strokeWidth: 3.0,
        valueColor: AlwaysStoppedAnimation<Color>(color),
        backgroundColor: Colors.white.withOpacity(0.4),
      ),
    );
  }
}
