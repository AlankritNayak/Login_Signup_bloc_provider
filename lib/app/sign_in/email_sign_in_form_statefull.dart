import 'package:flutter/material.dart';
import 'package:time_tracker/common_widgets/form_submit_button.dart';
import 'package:time_tracker/services/auth.dart';
import 'package:time_tracker/app/sign_in/validators.dart';
import 'package:time_tracker/common_widgets/platform_alert_dialog.dart';
import 'email_sign_in_model.dart';


class EmailSignInFormStateFull extends StatefulWidget with EmailAndPasswordValidators {
  EmailSignInFormStateFull(this._auth);
  final AuthBase _auth;
  @override
  _EmailSignInFormStateFullState createState() => _EmailSignInFormStateFullState();
}

class _EmailSignInFormStateFullState extends State<EmailSignInFormStateFull> {
  EmailFormType _emailFormType = EmailFormType.signIn;

  String get _email => _emailController.text;
  String get _password => _passwordController.text;

  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();

  final FocusNode _passwordFocusNode = FocusNode();
  final FocusNode _emailFocusNode = FocusNode();

  bool _submitted = false;
  bool _isloading = false;

  void _toggleFormType() {
    setState(() {
      _emailFormType = _emailFormType == EmailFormType.signIn
          ? EmailFormType.register
          : EmailFormType.signIn;
      _submitted = false;
    });
    _emailController.clear();
    _passwordController.clear();
  }

  void _submit() async {
    setState(() {
      _isloading = true;
      _submitted = true;
    });
    try {
      if (_emailFormType == EmailFormType.signIn) {
        await widget._auth.signInWithEmailAndPassword(_email, _password);
      } else {
        await widget._auth.createUserWithEmailAndPassword(_email, _password);
      }
      Navigator.of(context).pop();
    } catch (e) {
      PlatformAlertDialog(
              content: e.toString(),
              defaultActionText: 'Ok',
              title: 'sign in failed')
          .show(context);
    } finally {
      setState(() {
        _isloading = false;
      });
    }
  }

  void _onEditingComplete() {
    final FocusNode newFocus = widget.emailValidator.isValid(_email)
        ? _passwordFocusNode
        : _emailFocusNode;
    FocusScope.of(context).requestFocus(newFocus);
  }

  List<Widget> _buildChildren() {
    final primaryText =
        _emailFormType == EmailFormType.signIn ? 'Sign In' : 'Register';
    final secondartyText = _emailFormType == EmailFormType.signIn
        ? 'Need an account? Register!'
        : 'Already have an account?';

    bool submitEnabled = widget.emailValidator.isValid(_email) &&
        widget.passwordValidator.isValid(_password) &&
        !_isloading;

    return [
      _buildEmailTextFeild(),
      _buildPasswordTextFeild(),
      SizedBox(
        height: 10,
      ),
      FormSubmitButton(
        text: primaryText,
        onPressed: submitEnabled ? _submit : null,
        color: Colors.indigo,
        textColor: Colors.white,
      ),
      FlatButton(
        onPressed: _toggleFormType,
        child: Text(secondartyText),
      )
    ];
  }

  TextField _buildPasswordTextFeild() {
    bool showError = !widget.passwordValidator.isValid(_password);
    return TextField(
      controller: _passwordController,
      focusNode: _passwordFocusNode,
      decoration: InputDecoration(
        labelText: 'Password',
        errorText:
            _submitted && showError ? widget.emptyPasswordErrorText : null,
        enabled: !_isloading,
      ),
      obscureText: true,
      textInputAction: TextInputAction.done,
      onEditingComplete: _submit,
      onChanged: (password){_updateState();},
    );
  }

  TextField _buildEmailTextFeild() {
    bool showError = !widget.emailValidator.isValid(_email);
    return TextField(
      controller: _emailController,
      focusNode: _emailFocusNode,
      decoration: InputDecoration(
        labelText: 'Email',
        hintText: 'example@example.example',
        errorText: _submitted && showError ? widget.emptyEmailErrorText : null,
        enabled: !_isloading,
      ),
      keyboardType: TextInputType.emailAddress,
      textInputAction: TextInputAction.next,
      onEditingComplete: _onEditingComplete,
      onChanged: (email) => _updateState(),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 10),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        mainAxisSize: MainAxisSize.min,
        children: _buildChildren(),
      ),
    );
  }

  void _updateState() {
    print('update state called');
    setState(() {});
  }
}
