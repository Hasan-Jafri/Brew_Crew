import 'package:brew__crew/models/brew.dart';
import 'package:brew__crew/screens/home/brew_list.dart';
import 'package:brew__crew/screens/home/settings_form.dart';
import 'package:brew__crew/services/auth.dart';
import 'package:brew__crew/services/database.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class Home extends StatelessWidget {
  final AuthService _auth = AuthService();
  final String uid;
  Home({required this.uid});
  @override
  Widget build(BuildContext context) {
    void _showSettingsPanel() {
      showModalBottomSheet(
          context: context,
          builder: (context) {
            return SettingsForm();
          });
    }

    return StreamProvider<List<Brew>>.value(
      value: DataBaseService(uid: uid).brews,
      initialData: [],
      child: Scaffold(
        backgroundColor: Colors.brown[50],
        appBar: AppBar(
          title: Text("Brew Crew"),
          backgroundColor: Colors.brown[400],
          elevation: 0,
          actions: <Widget>[
            TextButton.icon(
              onPressed: () async {
                await _auth.SignOut();
              },
              icon: Icon(
                Icons.person,
                color: Colors.black,
              ),
              label: Text(
                "Logout",
                style: TextStyle(color: Colors.black),
              ),
            ),
            TextButton.icon(
              onPressed: () => _showSettingsPanel(),
              icon: Icon(
                Icons.settings,
                color: Colors.black,
              ),
              label: Text(
                "Settings",
                style: TextStyle(
                  color: Colors.black,
                ),
              ),
            ),
          ],
        ),
        body: Container(
          decoration: BoxDecoration(
            image: DecorationImage(
              image: AssetImage('assets/coffee_bg.png'),
              fit: BoxFit.cover,
              )
          ),
          child: BrewList()
          ),
      ),
    );
  }
}
