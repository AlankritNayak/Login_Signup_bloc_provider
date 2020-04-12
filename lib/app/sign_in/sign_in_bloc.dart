import 'dart:async';
import 'package:flutter/foundation.dart';
import 'package:time_tracker/services/auth.dart';


class SignInBloc {
  SignInBloc({@required this.auth});
  final AuthBase auth;

  final StreamController _isLoadingContorller = StreamController<bool>();
  Stream get loadingStream => _isLoadingContorller.stream;

  void _setIsLoading(bool isLoading) => _isLoadingContorller.add(isLoading);

  void dispose(){
    _isLoadingContorller.close();
  }


  Future<User> _signIn(Future<User> Function() signInMethod) async {
    try {
      _setIsLoading(true);
      return await signInMethod();
    } catch (e) {
      _setIsLoading(false);
      rethrow;
    }
  }

  Future<User> signInAnonymously() async => await _signIn(auth.signInAnonymously);

  Future<User> signInWithGoogle() async => await _signIn(auth.signInWithGoogle);

}
