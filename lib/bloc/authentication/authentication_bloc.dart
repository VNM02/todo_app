

import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:todo_app/bloc/authentication/authentication_event.dart';
import 'package:todo_app/bloc/authentication/authentication_state.dart';

class AuthenticationBloc extends Bloc<AuthenticationEvent,AuthenticationState>{
  AuthenticationBloc():super(AuthenticationInitialState())
  {
    on<AuthenticationSignUpEvent>((event, emit) => emit(AuthenticationSignUpState()));
    on<AuthenticationLoginEvent>((event,emit) =>  emit(AuthenticationLoginState()));

  }

}