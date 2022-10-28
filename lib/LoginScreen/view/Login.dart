import 'package:bloc_practice/LoginScreen/viewmodel/LoginCubit.dart';
import 'package:bloc_practice/LoginScreen/viewmodel/states.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class Login extends StatelessWidget {
  final _formKey = GlobalKey<FormState>();
  final TextEditingController userNameController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();



  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => LoginViewModel(),
      child:
          BlocConsumer<LoginViewModel, LoginStates>(listener: (context, state) {
        if (state is LoginLoadingState) {
          showDialog(barrierDismissible: false  ,context: context, builder: (context){
            return AlertDialog(title: Text("Logging"),content:LinearProgressIndicator(),);
          });

        }
        if(state is LoginSuccessState){
          Navigator.pop(context);

        }
        if(state is LoginFailedState) {
          Navigator.pop(context);

            showDialog(barrierDismissible: true,
                context: context,
                builder: (context) {
                  return AlertDialog(
                    title: Text("Logging"), content: Text("wrong password"),);
                });

        }
      }, builder: (context, state) {
        return Scaffold(
          appBar: AppBar(
            title: Text("Bloc Practice"),
            centerTitle: true,
            backgroundColor: Colors.teal,
          ),
          body: Container(
            padding: EdgeInsets.all(30),
            child: Center(
              child:
                  Column(mainAxisAlignment: MainAxisAlignment.start, children: [
                Expanded(
                    child: Image.asset("assets/login.jpg", fit: BoxFit.fill)),
                Expanded(
                  child: Form(
                      key: _formKey,
                      child: Column(
                        children: [
                          TextFormField(
                              controller: userNameController,
                              decoration: InputDecoration(labelText: "Username")),
                          TextFormField(
                            controller: passwordController,
                            decoration: InputDecoration(
                                labelText: "Password",
                                suffixIcon: IconButton(
                                  icon: LoginViewModel.getViewModel(context).icon,onPressed: (){
                                    LoginViewModel.getViewModel(context).changePasswordicon();
                                },
                                )),
                            obscureText: LoginViewModel.getViewModel(context).obsecure,
                          ),
                          SizedBox(height: 30,),
                          ElevatedButton(onPressed: () {
                            LoginViewModel.getViewModel(context).login(userNameController.text, passwordController.text);
                          }, child: Text("Login"))
                        ],
                      )),
                )
              ]),
            ),
          ),
        );
      }),
    );
  }
}
