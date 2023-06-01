import 'package:flutter/material.dart';

class SettingsScreen extends StatefulWidget {
  const SettingsScreen({Key? key}) : super(key: key);

  @override
  _SettingsScreenState createState() => _SettingsScreenState();
}

class _SettingsScreenState extends State<SettingsScreen> {
  bool _isDarkModeOn = false;
  bool _isNotificationOn = true;
  double _sliderValue = 0.5;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Settings'),
      ),
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const SizedBox(height: 20),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20),
              child: Text(
                'General',
                style: Theme.of(context).textTheme.titleLarge,
              ),
            ),
            const Divider(),
            ListTile(
              leading: const CircleAvatar(
                radius: 18,
                backgroundImage: AssetImage('assets/images/notifications.png'),
              ),
              title: const Text('Notifications'),
              subtitle: const Text('Turn on/off notifications'),
              trailing: Switch(
                value: _isNotificationOn,
                onChanged: (value) {
                  setState(() {
                    _isNotificationOn = value;
                  });
                },
              ),
            ),
            ListTile(
              leading: const CircleAvatar(
                radius: 18,
                backgroundImage: AssetImage('assets/images/moon.png'),
              ),
              title: const Text('Dark Mode'),
              subtitle: const Text('Turn on/off dark mode'),
              trailing: Switch(
                value: _isDarkModeOn,
                onChanged: (value) {
                  setState(() {
                    _isDarkModeOn = value;
                  });
                },
              ),
            ),
            const SizedBox(height: 20),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20),
              child: Text(
                'Preferences',
                style: Theme.of(context).textTheme.titleLarge,
              ),
            ),
            const Divider(),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20),
              child: Text(
                'Font Size',
                style: Theme.of(context).textTheme.titleMedium,
              ),
            ),
            Slider(
              value: _sliderValue,
              onChanged: (newValue) {
                setState(() {
                  _sliderValue = newValue;
                });
              },
              min: 0,
              max: 1,
              divisions: 10,
              label: _sliderValue.toStringAsFixed(1),
            ),
            const SizedBox(height: 20),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20),
              child: Text(
                'Security',
                style: Theme.of(context).textTheme.titleLarge,
              ),
            ),
            const Divider(),
            ListTile(
              leading: const CircleAvatar(
                radius: 18,
                backgroundImage:
                    AssetImage('assets/images/change_password.png'),
              ),
              title: const Text('Change Password'),
              onTap: () {
                // Navigate to change password screen
              },
            ),
            ListTile(
              leading: const CircleAvatar(
                radius: 18,
                backgroundImage: AssetImage('assets/images/logout.png'),
              ),
              title: const Text('Logout'),
              onTap: () {
                // Logout the user
              },
            ),
            const SizedBox(height: 20),
          ],
        ),
      ),
    );
  }
}
