import 'package:flutter/material.dart';
import 'package:flash_chat/screens/welcome_screen.dart';
import 'package:flash_chat/screens/login_screen.dart';
import 'package:flash_chat/screens/registration_screen.dart';



class RoundedButton extends StatelessWidget {
  RoundedButton(
      { @required this.colour, @required this.onPressed, @required this.text });

  final Color colour;
  final Function onPressed;
  final String text;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.symmetric(vertical: 16.0),
      child: Material(
        elevation: 5.0,
        //color: Colors.lightBlueAccent,
        borderRadius: BorderRadius.circular(30.0),
        color: colour,
        child: MaterialButton(
          onPressed: onPressed,
          minWidth: 200.0,
          height: 42.0,
          child: Text(
            text,
            style: TextStyle(
              color: Colors.white
                  //fontcolour for text
            ),
          ),
        ),
      ),
    );
  }
}