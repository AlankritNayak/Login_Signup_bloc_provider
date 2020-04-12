import 'dart:async';
import 'package:time_tracker/app/sign_in/email_sign_in_model.dart';
import 'package:time_tracker/services/auth.dart';
import 'package:flutter/foundation.dart';
import 'package:rxdart/rxdart.dart';


class EmailSignInBloc{
  EmailSignInBloc({@required this.auth});
  final AuthBase auth;
  final BehaviorSubject<EmailSignInModel> _modelSubject = BehaviorSubject<EmailSignInModel>.seeded(EmailSignInModel());
  Stream<EmailSignInModel> get modelStream => _modelSubject.stream;
  EmailSignInModel get _model => _modelSubject.value;
  void dispose(){
    _modelSubject.close();
  }

 Future<void> submit() async {
    updateWith(submitted: true, isLoading: true);
    try {
      if (_model.formType == EmailFormType.signIn) {
        await auth.signInWithEmailAndPassword(_model.email, _model.password);
      } else {
        await auth.createUserWithEmailAndPassword(_model.email, _model.password);
      }
    } catch (e) {
       updateWith(isLoading: false);
      rethrow;
    }
  }

  void updateEmail(String email)=> updateWith(email: email);

  void updatePassword(String password)=> updateWith(password: password);

  void toggleFormType() {
     updateWith(
        email: '',
        password: '',
        formType: _model.formType == EmailFormType.signIn
          ? EmailFormType.register
          : EmailFormType.signIn,
        isLoading: false,
        submitted: false,
      );
  }


  void updateWith({
   String email,
   String password,
   EmailFormType formType,
   bool isLoading,
   bool submitted,
  }){
    // _modelSubject.add(_model.copyWith(
    // email : email,
    // password : password,
    // formType : formType,
    // isLoading : isLoading,
    // submitted : submitted,
    // ));
    //below is the same thing as above 
      _modelSubject.value =_model.copyWith(
    email : email,
    password : password,
    formType : formType,
    isLoading : isLoading,
    submitted : submitted,
    );
  }
}