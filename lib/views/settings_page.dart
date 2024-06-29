import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:task_app/core/constants/app_colors.dart';

class SettingsPage extends StatefulWidget {
  @override
  _SettingsPageState createState() => _SettingsPageState();
}

class _SettingsPageState extends State<SettingsPage> {
  bool _darkModeEnabled = false;
  bool _notificationsEnabled = true;
  bool _remindersEnabled = true;
  bool _highPriorityTasksFirst = false;

  @override
  void initState() {
    super.initState();
    _loadPreferences();
  }

  void _loadPreferences() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    setState(() {
      _darkModeEnabled = prefs.getBool('darkMode') ?? false;
      _notificationsEnabled = prefs.getBool('notificationsEnabled') ?? true;
      _remindersEnabled = prefs.getBool('remindersEnabled') ?? true;
      _highPriorityTasksFirst = prefs.getBool('highPriorityTasksFirst') ?? false;
    });
  }

  void _toggleDarkMode(bool value) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    setState(() {
      _darkModeEnabled = value;
      prefs.setBool('darkMode', value);
    });
  }

  void _toggleNotifications(bool value) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    setState(() {
      _notificationsEnabled = value;
      prefs.setBool('notificationsEnabled', value);
    });
  }

  void _toggleReminders(bool value) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    setState(() {
      _remindersEnabled = value;
      prefs.setBool('remindersEnabled', value);
    });
  }

  void _toggleHighPriorityTasksFirst(bool value) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    setState(() {
      _highPriorityTasksFirst = value;
      prefs.setBool('highPriorityTasksFirst', value);
    });
  }

  Widget _buildSwitchListTile(String title, bool value, Function(bool) onChanged) {
    return ListTile(
      title: Text(
        title,
        style: TextStyle(
          color: _darkModeEnabled ? Colors.white : Colors.black,
        ),
      ),
      trailing: Switch(
        value: value,
        onChanged: onChanged,
        activeColor: Colors.blue,
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          'Settings',
          style: TextStyle(
            color: _darkModeEnabled ? Colors.white : Colors.black,
          ),
        ),
        backgroundColor: AppColors.primary,
      ),
      body: Stack(
        children: [
          Container(
            color: _darkModeEnabled ? Colors.grey.shade900 : Colors.white,
            child: ListView(
              children: <Widget>[
                                SizedBox(height: 20,),

                _buildSwitchListTile('Dark Mode', _darkModeEnabled, _toggleDarkMode),
                SizedBox(height: 20,),
                _buildSwitchListTile('Enable Notifications', _notificationsEnabled, _toggleNotifications),
                                SizedBox(height: 20,),

                _buildSwitchListTile('Enable Reminders', _remindersEnabled, _toggleReminders),
                                SizedBox(height: 20,),

                _buildSwitchListTile('High Priority Tasks First', _highPriorityTasksFirst, _toggleHighPriorityTasksFirst),
              ],
            ),
          ),
          Positioned(
            right: 10,
            bottom: 10,
            child: Image.asset(
              'assets/images/onBoarding/settings.png',
              height: 200,
              fit: BoxFit.cover,
            ),
          ),
        ],
      ),
    );
  }
}
