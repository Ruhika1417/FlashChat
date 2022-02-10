import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flash_chat/components/rounded_button.dart';
import 'package:flash_chat/constants.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:modal_progress_hud/modal_progress_hud.dart';
import 'chat_screen.dart';







class LoginScreen extends StatefulWidget {

  static String iddd='login_screen';
  @override
  _LoginScreenState createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
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
              textAlign: TextAlign.center,
              onChanged: (value) {
                email= value; //Do something with the user input.
              },
              decoration:  KtextfieldDecoration.copyWith(
                hintText: 'Enter your Email',
              ),
            ),


            SizedBox(
              height: 8.0,
            ),
            TextField(

              textAlign: TextAlign.center,
              obscureText: true,
              onChanged: (value) {
                password=value;//Do something with the user input.
              },
              decoration:  KtextfieldDecoration.copyWith(
                hintText: 'Enter your Password',
              ),
            ),


            SizedBox(
              height: 24.0,
            ),

            RoundedButton(colour: Colors.lightBlueAccent, text: 'Log In',
                onPressed: () async {

              setState(() {
                saving=true;
              });


              // print(email);
              // print(password);

                try {

                  final User= await _auth.signInWithEmailAndPassword(email: email, password: password);

                  if (User!=null){
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
      ),
    );
  }
}
