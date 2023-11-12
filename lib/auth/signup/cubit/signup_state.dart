abstract class SignUpState{}

class SignUpLoadingState extends SignUpState{}

class SignUpFieldSaveState extends SignUpState{
  final String email;
  final String password;
  SignUpFieldSaveState(this.email,this.password);
}

class SignUpSubmitState extends SignUpState{
  final String email;
  final String password;
  SignUpSubmitState(this.email,this.password);
}

class SignUpInvalidState extends SignUpState{
  final String error;
  SignUpInvalidState(this.error);
}