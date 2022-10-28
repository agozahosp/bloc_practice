import 'package:bloc_practice/LoginScreen/viewmodel/states.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class LoginViewModel extends Cubit<LoginStates>{
  LoginViewModel(): super(LoginInitalState());

  static LoginViewModel getViewModel(context)=> BlocProvider.of(context);
bool obsecure=true ;
Icon icon = Icon(Icons.visibility_off);

  void login(String username,String password){
    emit(LoginLoadingState());
    if(username=="hossam"&& password=="1234"){
    new Future.delayed(Duration(seconds: 2),(){
      emit(LoginSuccessState());
    });
  }
    else{
      new Future.delayed(Duration(seconds: 2),(){
        emit(LoginFailedState());
      });
    }
  }
  void changePasswordicon(){

    if(state is LoginHidePassword || state is LoginInitalState){
      obsecure=false;
      icon= Icon(Icons.visibility);
      emit(LoginShowpassowrd());
    }
    else{
      obsecure=true;
      icon=Icon(Icons.visibility_off);
      emit(LoginHidePassword());

    }
  }

}