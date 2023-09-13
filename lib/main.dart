import 'package:brew__crew/models/user.dart';
// import 'package:brew__crew/screens/authenticate/authenticate.dart';
import 'package:brew__crew/screens/wrapper.dart';
import 'package:brew__crew/services/auth.dart';
import 'package:flutter/material.dart';
// import 'package:brew__crew/screens/home/home.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:provider/provider.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return StreamProvider<AppUser?>.value(
      initialData: null,
      value: AuthService().user_,
      child: MaterialApp(
        home: Wrapper(),
      ),
    // return MaterialApp(
    //   home: Authenticate(),
    );
  }
}
