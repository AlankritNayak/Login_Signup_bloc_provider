abstract class StringValidator{
  bool isValid(String value);
}

class NonEmptyStringValidator implements StringValidator{
  @override
  bool isValid(String value) {
    if(value.isNotEmpty){
      return true;
    }else{
      return false;
    }
  }
}

class EmailAndPasswordValidators{
  final StringValidator emailValidator = NonEmptyStringValidator();
  final StringValidator passwordValidator = NonEmptyStringValidator();
  final String emptyEmailErrorText = 'Email can\'t be empty';
  final String emptyPasswordErrorText = 'Password can\'t be empty';
}

