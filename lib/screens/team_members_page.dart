import 'package:flutter/material.dart';

class AnimatedTeamMembersPage extends StatefulWidget {
  final List<String> members;

  const AnimatedTeamMembersPage({Key? key, required this.members})
      : super(key: key);

  @override
  _AnimatedTeamMembersPageState createState() =>
      _AnimatedTeamMembersPageState();
}

class _AnimatedTeamMembersPageState extends State<AnimatedTeamMembersPage>
    with SingleTickerProviderStateMixin {
  late AnimationController _controller;
  late Animation<double> _animation;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      duration: const Duration(seconds: 2),
      vsync: this,
    )..repeat(reverse: true);
    _animation = CurvedAnimation(
      parent: _controller,
      curve: Curves.easeInOut,
    );
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Team Members'),
      ),
      body: GridView.builder(
        padding: EdgeInsets.all(16.0),
        itemCount: widget.members.length,
        gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
          crossAxisCount: 2,
          crossAxisSpacing: 16.0,
          mainAxisSpacing: 16.0,
        ),
        itemBuilder: (BuildContext context, int index) {
          return ScaleTransition(
            scale: _animation,
            child: Container(
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(8.0),
                color: Colors.grey[300],
              ),
              child: Center(
                child: Text(
                  widget.members[index],
                  style: TextStyle(
                    fontSize: 24.0,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
            ),
          );
        },
      ),
    );
  }
}
