import 'package:flutter/material.dart';
import 'package:flash_chat/screens/welcome_screen.dart';
import 'package:flash_chat/screens/login_screen.dart';
import 'package:flash_chat/screens/registration_screen.dart';
import 'package:flash_chat/screens/chat_screen.dart';

import 'screens/chat_screen.dart';
import 'screens/login_screen.dart';
import 'screens/registration_screen.dart';
import 'screens/welcome_screen.dart';
import 'package:firebase_core/firebase_core.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  runApp(FlashChat());
}

class FlashChat extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      // to see the texts in text field gray in colour
              // theme: ThemeData.dark().copyWith(
              //   textTheme: TextTheme(
              //     body1: TextStyle(color: Colors.black54),
              //   ),
              // ),
              //dont use ' welcomescreen ' it gives global key prob

              initialRoute: WelcomeScreen.id,
              routes: {
              // '/': (context) => ChatScreen(),
              //   '/second': (context) => LoginScreen(),
              //   '/third': (context) => RegistrationScreen(),
              //   'welcome_screen': (context) => WelcomeScreen(),or
                  WelcomeScreen.id : (context)=> WelcomeScreen(),
                   ChatScreen.idd: (context) => ChatScreen(),
                  LoginScreen.iddd: (context) => LoginScreen(),
                  RegistrationScreen.idddd: (context) => RegistrationScreen(),

              });

  }
}