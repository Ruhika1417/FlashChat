import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flash_chat/components/rounded_button.dart';
import 'package:flash_chat/constants.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flash_chat/screens/chat_screen.dart';
import 'package:modal_progress_hud/modal_progress_hud.dart';


class RegistrationScreen extends StatefulWidget {
   //final _auth = FirebaseAuth.instance;

  static String idddd= 'registration';
  @override
  _RegistrationScreenState createState() => _RegistrationScreenState();
}

class _RegistrationScreenState extends State<RegistrationScreen> {
  final _auth = FirebaseAuth.instance;
  String email;
  String password;
  bool saving=false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body:ModalProgressHUD(
          inAsyncCall:saving ,
          child:Padding(
          padding: EdgeInsets.symmetric(horizontal: 24.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: <Widget>[
            Flexible(
            child:Hero(
              tag: 'logo',
              child: Container(
                height: 200.0,
                child: Image.asset('images/logo.png'),
              ),
            ),
            ),
            SizedBox(
              height: 48.0,
            ),
            TextField(
              keyboardType: TextInputType.emailAddress,
              textAlign:TextAlign.center ,
              onChanged: (value) {
                 email= value;//Do something with the user input.
              },
                decoration:
                KtextfieldDecoration.copyWith(
                  hintText: 'Enter your Email',
                ),
      ),

            SizedBox(
              height: 8.0,
            ),

            TextField(

              obscureText: true,
              textAlign:TextAlign.center ,
              onChanged: (value) {
                password= value; //Do something with the user input.
              },
                decoration: KtextfieldDecoration.copyWith(
                    hintText: 'Enter your Password '
                ),
            ),

              //},
            SizedBox(
              height: 24.0,
            ),

            RoundedButton(text: 'Register', colour:Colors.blueAccent,
                onPressed: () async{
              // print(email);
              // print(password);
                  // this could fail for a number of reasons like invalid email/pw or using already registered email so tryncatch
              setState(() {
                saving=true;
              });
                  try {
                    final newUser = await _auth.createUserWithEmailAndPassword(
                        email: email, password: password);
                     if (newUser!=null){
                       Navigator.pushNamed(context, ChatScreen.idd );

                     }
                   setState(() {
                     saving=false;
                   });

                  }
                  catch(e){
                    print(e);
                  }





                }
                ),

            ],
        ),


        ),
      ),);

  }
}
