import 'package:brew__crew/models/user.dart';
import 'package:brew__crew/services/database.dart';
import 'package:brew__crew/shared/loading.dart';
import 'package:flutter/material.dart';
import 'package:brew__crew/shared/constants.dart';
import 'package:provider/provider.dart';

class SettingsForm extends StatefulWidget {
  const SettingsForm({super.key});

  @override
  State<SettingsForm> createState() => _SettingsFormState();
}

class _SettingsFormState extends State<SettingsForm> {
  final _formkey = GlobalKey<FormState>();
  final List<String> sugars = ['0', '1', '2', '3', '4'];
  bool _has_changed = false;

  late String? _currentName;
  late String? _currentSugars = null;
  late int? _currentStrength = null;
  @override
  Widget build(BuildContext context) {
    final user = Provider.of<AppUser>(context);
    return StreamBuilder<UserData>(
      stream: DataBaseService(uid: user.uid).userData,
      builder: (context, snapshot) {
        if (snapshot.hasData) {
          UserData? userdata = snapshot.data;
          return Form(
            key: _formkey,
            child: Column(
              children: <Widget>[
                SizedBox(
                  height: 20,
                ),
                Text(
                  "Update your Brew Settings.",
                  style: TextStyle(fontSize: 18),
                ),
                SizedBox(
                  height: 20,
                ),
                Padding(
                  padding: const EdgeInsets.all(30.0),
                  child: TextFormField(
                    initialValue: userdata?.name,
                    decoration: textInputDecoration,
                    validator: (val) =>
                        val!.isEmpty ? 'Please Enter a Name' : null,
                    onChanged: (val) => setState(() {
                      _currentName = val;
                      _has_changed = true;
                    }),
                  ),
                ),
                //DropDown
                Padding(
                  padding: const EdgeInsets.fromLTRB(30, 0, 30, 0),
                  child: DropdownButtonFormField(
                    value: _currentSugars ?? userdata!.sugars,
                    onChanged: (val) => setState(() {
                      _currentSugars = val;
                      _has_changed = true;
                    }),
                    decoration: textInputDecoration,
                    items: sugars.map((sugar) {
                      return DropdownMenuItem(
                        value: sugar,
                        child: Text("$sugar sugars"),
                      );
                    }).toList(),
                  ),
                ),

                //Slider
                Slider(
                  value: (_currentStrength ?? userdata!.strength).toDouble(),
                  onChanged: (val) => setState(() {
                    _has_changed = true;
                    _currentStrength = val.round();
                  }),
                  activeColor:
                      Colors.brown[_currentStrength ?? userdata!.strength],
                  inactiveColor:
                      Colors.brown[_currentStrength ?? userdata!.strength],
                  min: 100.0,
                  max: 900.0,
                  divisions: 8,
                ),

                ElevatedButton(
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.pink[400],
                  ),
                  onPressed: () async {
                    if (_has_changed == true || _formkey.currentState!.validate()) {
                      await DataBaseService(uid: user.uid).UpdateUserData(
                        _currentName ?? userdata!.name,
                        _currentSugars ?? userdata!.sugars,
                        _currentStrength ?? userdata!.strength,
                      );
                      Navigator.pop(context);
                    }
                  },
                  child: Text(
                    "Update",
                    style: TextStyle(color: Colors.white),
                  ),
                )
              ],
            ),
          );
        } else {
          return Loading();
        }
      },
    );
  }
}
