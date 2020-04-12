import 'package:flutter/material.dart';
import 'package:time_tracker/app/sign_in/email_sign_in_form_blockBased.dart';



class EmailSignInPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Sign In'),
        elevation: 2.0,
      ),
      body: _buildContent(context),
      backgroundColor: Color(0xFF88c7bc),
    );
  }

  Widget _buildContent(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 5, vertical: 10),
      child: Card(
        child: EmailSignInFormBlocBased.create(context),
      ),
    );
  }
}
