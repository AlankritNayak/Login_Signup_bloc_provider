import 'package:flutter/material.dart';
import 'package:time_tracker/app/home_page.dart';
import 'package:time_tracker/app/sign_in/sign_in_page.dart';
import 'package:time_tracker/services/auth.dart';
import 'package:provider/provider.dart';

class LandingPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final AuthBase auth = Provider.of<AuthBase>(context);
    return StreamBuilder<User>(
      stream: auth.onAuthStateChanged,
      builder: (context, snapshot) {
        auth.onAuthStateChanged.listen((value) => print(value));
        if (snapshot.connectionState == ConnectionState.active) {
          User user = snapshot.data;
          if (user == null) {
            return SignInPage.create(context);
          }
          return HomePage();
        } else {
          return Scaffold(body: Center(child: CircularProgressIndicator()));
        }
      },
    );
  }
}
