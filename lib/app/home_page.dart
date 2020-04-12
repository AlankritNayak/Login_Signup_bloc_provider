import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:time_tracker/services/auth.dart';

class HomePage extends StatelessWidget {
 
  Future<void> _signOut(BuildContext context) async {
    final auth = Provider.of<AuthBase>(context, listen:  false);
    try {
      await auth.signOut();
    } catch (e) {
      print(e.toString());
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Home Page'),
        actions: <Widget>[
          FlatButton(
            child: Text(
              'Logout',
              style: TextStyle(
                fontSize: 18.0,
                color: Colors.white,
              ),
            ),
            onPressed: () =>  _signOut(context),
          ),
        ],
      ),
      body: Container(
        color: Color(0xFF88c7bc),
        child: Center(child: Text(" Welcome ",style: TextStyle(color: Colors.white, fontSize: 30),),)),
    );
  }
}
