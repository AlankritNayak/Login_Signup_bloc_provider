import 'package:time_tracker/app/sign_in/validators.dart';

enum EmailFormType { signIn, register }

class EmailSignInModel with EmailAndPasswordValidators {
  EmailSignInModel(
      {this.email = '',
      this.password = '',
      this.formType = EmailFormType.signIn,
      this.isLoading = false,
      this.submitted = false});
  final String email;
  final String password;
  final EmailFormType formType;
  final bool isLoading;
  final bool submitted;

  bool get submittEnabled =>
      emailValidator.isValid(email) &&
      passwordValidator.isValid(password) &&
      !isLoading;

  String get emailErrorText {
    return submitted && !emailValidator.isValid(email)
        ? emptyEmailErrorText
        : null;
  }

  String get passwordErrorText {
    return submitted && !passwordValidator.isValid(password)
        ? emptyPasswordErrorText
        : null;
  }

  String get primaryButtonText {
    return formType == EmailFormType.signIn ? 'Sign In' : 'Create an Account';
  }

  String get secondaryButtonText {
    return formType == EmailFormType.signIn
        ? 'Need an account? Register!'
        : 'Already have an account?';
  }

  EmailSignInModel copyWith({
    String email,
    String password,
    EmailFormType formType,
    bool isLoading,
    bool submitted,
  }) {
    return EmailSignInModel(
      email: email ?? this.email,
      password: password ?? this.password,
      formType: formType ?? this.formType,
      isLoading: isLoading ?? this.isLoading,
      submitted: submitted ?? this.submitted,
    );
  }
}
