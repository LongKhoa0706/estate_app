import 'dart:async';
import 'package:bloc/bloc.dart';
import 'package:estate_app/src/model/users.dart';
import 'package:estate_app/src/repositories/repositories.dart';
import 'package:flutter/material.dart';
import 'package:meta/meta.dart';

part 'auth_event.dart';

part 'auth_state.dart';

class AuthBloc extends Bloc<AuthEvent, AuthState> {
  final Repositories repositories = Repositories();

  AuthBloc() : super(InitialAuthState());



  @override
  Stream<AuthState> mapEventToState(AuthEvent event) async* {
    try{
      if (event is AuthEventRegisterSubmit) {
        yield AuthStateLoading();
        try{
          await repositories.authRepositories.registerUser(event.user);
          yield AuthStateSuccess();
        }catch(e){
          yield AuthStateFaire(e.toString());
        }
      }
      if (event is AuthEventLogout) {
        yield AuthStateLoading();
        try{
          await repositories.authRepositories.logoutUser();
          yield AuthStateSuccess();
        }catch(e){
          yield AuthStateFaire(e.toString());
        }
      }

      if (event is AuthEventLogin) {
        yield AuthStateLoading();
        try{
          await repositories.authRepositories.loginUser(username: event.email, passwords: event.passwords);
          yield AuthStateSuccess();
        } catch (e){
          yield AuthStateFaire(e.toString());
        }
      }

      if (event is AuthEvenForgotPassword) {
        try{
          yield AuthStateLoading();
          await repositories.authRepositories.sendCodeToEmail(event.email);
          yield AuthStateSuccess();
        } catch(e){
          yield AuthStateFaire(e.toString());
        }
      }

      if (event is AuthEvenVerifyCodeEmail) {
        yield AuthStateLoading();
        try{
         await repositories.authRepositories.verifyCodeEmail(event.email, event.code);
         yield AuthStateSuccess();
       }catch(e){
         yield AuthStateFaire(e.toString());
       }
      }
    }catch(e){
      yield AuthStateFaire(e.toString());
    }
  }

}

