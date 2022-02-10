
//import 'dart:html';

import 'package:animated_text_kit/animated_text_kit.dart';
import 'package:flash_chat/components/rounded_button.dart';
import 'package:flutter/material.dart';

import 'login_screen.dart';
import 'registration_screen.dart';


class WelcomeScreen extends StatefulWidget {
  static String id='welcome_screen';


  @override
  _WelcomeScreenState createState() => _WelcomeScreenState();
}

class _WelcomeScreenState extends State<WelcomeScreen> with TickerProviderStateMixin {

  AnimationController controller;
  Animation animation;


@override
  void initState() {
    // TODO: implement initState
    super.initState();



    controller= AnimationController(
      duration: Duration(seconds: 1),
        //upperBound: 100, while using  curves upperbound is 1
        vsync:this );



    animation=ColorTween(begin: Colors.white24,end:Colors.white).animate(controller);
    controller.forward();


    //  animation=
   //      CurvedAnimation(parent: controller, curve: Curves.easeInCubic);
   //   controller.addListener(() {
   //   setState(() {
   //
   //   });
   //   print(controller.value);
   // });//want to refer obj in classes own code



//     animation.addStatusListener((status) {
//       //print(status);
//      if ( status==AnimationStatus.completed){
//        controller.reverse(from:1.0);
//      }
//      else if ( status==AnimationStatus.dismissed) {controller.forward( );};
//     });

controller.addListener(() {
  setState(() { });
  print(animation.value);
});

  }



  @override
  void dispose() {
   controller.dispose();
    super.dispose();

  }


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: animation.value,

      body: Padding(
        padding: EdgeInsets.symmetric(horizontal: 24.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: <Widget>[
            Row(
              children: <Widget>[
                Hero(
                  tag: 'logo',
                  child: Container(
                    child: Image.asset('images/logo.png'),
                    height:60.0, // if you dont multiply u wont see the effect
                  ),
                ),

                TypewriterAnimatedTextKit(
                  text:['Flash Chat'],
                 //'${controller.value.toInt()}%',
                  textStyle: TextStyle(
                    fontSize: 45.0,
                    fontWeight: FontWeight.w900,
                  ),
                ),
              ],
            ),

            SizedBox(
              height: 48.0,
            ),

        RoundedButton(
          text: 'Login',
          colour: Colors.lightBlueAccent,
          onPressed: ()
        {
          Navigator.pushNamed(context,LoginScreen.iddd);

        },
        ),

            RoundedButton(
              text: 'Register',
              colour: Colors.blueAccent,
              onPressed: ()
              {
                Navigator.pushNamed(context,RegistrationScreen.idddd);
              },
            ),
            ],
        ),
      ),
    );
  }


  }






