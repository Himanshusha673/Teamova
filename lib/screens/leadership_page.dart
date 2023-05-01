import 'package:flutter/material.dart';
import 'package:animated_text_kit/animated_text_kit.dart';

class LeaderboardPage extends StatefulWidget {
  @override
  _LeaderboardPageState createState() => _LeaderboardPageState();
}

class _LeaderboardPageState extends State<LeaderboardPage>
    with SingleTickerProviderStateMixin {
  late AnimationController _controller;
  final List<String> _users = [
    'John Doe',
    'Jane Smith',
    'Bob Johnson',
    'Alice Williams',
    'Mike Brown',
  ];

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      vsync: this,
      duration: Duration(seconds: 2),
    )..repeat();
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
        title: Text('Leaderboard'),
      ),
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          SizedBox(height: 16.0),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16.0),
            child: TypewriterAnimatedTextKit(
              text: ['Leaderboard'],
              textStyle: TextStyle(
                fontWeight: FontWeight.bold,
                fontSize: 32.0,
              ),
              speed: Duration(milliseconds: 200),
            ),
          ),
          SizedBox(height: 16.0),
          Expanded(
            child: ListView.builder(
              itemCount: _users.length,
              itemBuilder: (context, index) {
                final user = _users[index];
                final rank = index + 1;

                return Padding(
                  padding: const EdgeInsets.symmetric(
                      horizontal: 16.0, vertical: 8.0),
                  child: Row(
                    children: [
                      ScaleTransition(
                        scale: Tween(begin: 0.0, end: 1.0).animate(_controller),
                        child: Container(
                          width: 50.0,
                          height: 50.0,
                          decoration: BoxDecoration(
                            color: Colors.blue,
                            borderRadius: BorderRadius.circular(25.0),
                          ),
                          child: Center(
                            child: Text(
                              '$rank',
                              style: TextStyle(
                                fontWeight: FontWeight.bold,
                                fontSize: 20.0,
                                color: Colors.white,
                              ),
                            ),
                          ),
                        ),
                      ),
                      SizedBox(width: 16.0),
                      Expanded(
                        child: Text(
                          user,
                          style: TextStyle(fontSize: 18.0),
                        ),
                      ),
                    ],
                  ),
                );
              },
            ),
          ),
        ],
      ),
    );
  }
}
