import 'package:flutter/material.dart';

class HelpAndSupportPage extends StatelessWidget {
  const HelpAndSupportPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Help & Support'),
      ),
      body: Container(
        padding: const EdgeInsets.all(20.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: const [
            Text(
              'Contact Us',
              style: TextStyle(
                fontSize: 20.0,
                fontWeight: FontWeight.bold,
              ),
            ),
            SizedBox(height: 10.0),
            Text(
              'Email: support@teambuildingapp.com',
              style: TextStyle(fontSize: 16.0),
            ),
            SizedBox(height: 10.0),
            Text(
              'Phone: 555-123-4567',
              style: TextStyle(fontSize: 16.0),
            ),
            SizedBox(height: 20.0),
            Text(
              'FAQs',
              style: TextStyle(
                fontSize: 20.0,
                fontWeight: FontWeight.bold,
              ),
            ),
            SizedBox(height: 10.0),
            Text(
              'Q: How do I create a team?',
              style: TextStyle(fontSize: 16.0),
            ),
            SizedBox(height: 5.0),
            Text(
              'A: To create a team, go to the Teams page and click on the "Create Team" button. You will be prompted to enter the team name and description.',
              style: TextStyle(fontSize: 16.0),
            ),
            SizedBox(height: 10.0),
            Text(
              'Q: How do I invite members to my team?',
              style: TextStyle(fontSize: 16.0),
            ),
            SizedBox(height: 5.0),
            Text(
              'A: To invite members to your team, go to the Teams page and click on the team you want to invite members to. Then, click on the "Invite Members" button and enter the email addresses of the people you want to invite.',
              style: TextStyle(fontSize: 16.0),
            ),
          ],
        ),
      ),
    );
  }
}
