import 'package:brew__crew/models/user.dart';
import 'package:flutter/material.dart';
import 'package:brew__crew/screens/authenticate/authenticate.dart';
import 'package:brew__crew/screens/home/home.dart';
import 'package:provider/provider.dart';

class Wrapper extends StatelessWidget {
  const Wrapper({super.key});

  @override
  Widget build(BuildContext context) {
    final user = Provider.of<AppUser?>(context);

    // Returns either AUthenticate or Home widget.
    if (user == null) {
      return Authenticate();
    } else {
      return Home(uid: user.uid);
    
    }
  }
}
