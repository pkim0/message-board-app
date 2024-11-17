import 'package:flutter/material.dart';
import 'chat_page.dart';
import 'profile_page.dart';
import 'settings_page.dart';

class HomePage extends StatelessWidget {
  final List<Map<String, String>> messageBoards = [
    {'name': 'General', 'image': 'assets/images/general.png'},
    {'name': 'Sports', 'image': 'assets/images/sports.png'},
    {'name': 'Technology', 'image': 'assets/images/technology.png'},
    {'name': 'Movies', 'image': 'assets/images/movies.png'},
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Message Boards')),
      drawer: Drawer(
        child: ListView(
          padding: EdgeInsets.zero,
          children: [
            DrawerHeader(
              decoration: BoxDecoration(color: Colors.blue),
              child: Text(
                'Menu',
                style: TextStyle(color: Colors.white, fontSize: 24),
              ),
            ),
            ListTile(
              leading: Icon(Icons.home),
              title: Text('Message Boards'),
              onTap: () {
                Navigator.pop(context);
              },
            ),
            ListTile(
              leading: Icon(Icons.person),
              title: Text('Profile'),
              onTap: () {
                Navigator.push(context, MaterialPageRoute(builder: (context) => ProfilePage()));
              },
            ),
            ListTile(
              leading: Icon(Icons.settings),
              title: Text('Settings'),
              onTap: () {
                Navigator.push(context, MaterialPageRoute(builder: (context) => SettingsPage()));
              },
            ),
          ],
        ),
      ),
      body: ListView.builder(
        itemCount: messageBoards.length,
        itemBuilder: (context, index) {
          return ListTile(
            leading: Image.asset(
              messageBoards[index]['image']!,
              width: 24,
              height: 24,
            ),
            title: Text(messageBoards[index]['name']!),
            onTap: () {
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => ChatPage(boardName: messageBoards[index]['name']!)),
              );
            },
          );
        },
      ),
    );
  }
}