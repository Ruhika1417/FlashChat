

import 'package:firebase_core/firebase_core.dart';
import 'package:flash_chat/main.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flash_chat/constants.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

final _firestore= FirebaseFirestore.instance;
User loggedInUser;



void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  runApp(ChatScreen());
}



class ChatScreen extends StatefulWidget {
  static String idd= 'chat_screen';
  @override
  _ChatScreenState createState() => _ChatScreenState();
}



class _ChatScreenState extends State<ChatScreen> {
  final _auth = FirebaseAuth.instance;
  String messagetext;
  final messageTextController= TextEditingController();


  @override
  void initState() {

    super.initState();
     getcurrentuser();

     Firebase.initializeApp();

  }

  void getcurrentuser()async {
    try {
      final user = await _auth.currentUser;
      if (user != null) {
        loggedInUser = user;
        print(loggedInUser.email);
      }
    }
    catch (e) {
      print(e);
    }
  }

//  void  getMessages()async{
//     final messages= await _firestore.collection('messages').get();
//     for (var messages in messages.docs){
//       print(messages.data());
//     }
// // need to call again n again to check messages!!!
//  }

 void messagesStream()async{
  await for ( var snapshot in _firestore.collection('messages').snapshots()){
    for (var messages in snapshot.docs){
     print(messages.data());                              // it will rerun if any changes or any collection is added automatically without the need to reru it
     }                                                     //snapshot is basically like a list of future objects
  }

 }


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: null,
        actions: <Widget>[
          IconButton(
              icon: Icon(Icons.close),
              onPressed: () {
                messagesStream();
                // _auth.signOut();
                // Navigator.pop(context);
                //Implement logout functionality
              }),
        ],
        title: Text('⚡️Chat'),
        backgroundColor: Colors.lightBlueAccent,
      ),
      body: SafeArea(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: <Widget>[
            MessagesStream(),


            Container(
              decoration: kMessageContainerDecoration,
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: <Widget>[
                  Expanded(
                    child: TextField(
                      controller: messageTextController,
                      onChanged: (value) {
                        messagetext=value;//Do something with the user input.
                      },
                      decoration: kMessageTextFieldDecoration,
                    ),
                  ),
                  FlatButton(
                    onPressed: () {
                      messageTextController.clear();
                     _firestore.collection('messages').add({
                       'text': messagetext,
                       'sender': loggedInUser.email,
                     });

                         //Implement send functionality.
                    },
                    child: Text(
                      'Send',
                      style: kSendButtonTextStyle,
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class MessagesStream extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return StreamBuilder<QuerySnapshot>(
      stream:_firestore.collection('messages').snapshots(),
      builder: ( context, snapshot) {
        if (!snapshot.hasData) {
          return Center(
            child: CircularProgressIndicator(),
          );
        }

        // final messages= snapshot.data.docs;
        // List<MessageBubble>  messageBubbles=[];
        // for (var message in messages) {
        //   final messageText = message.data();
        //   final messageSender = message.data();
        final messages = snapshot.data.docs.reversed;
        List<MessageBubble> messageBubbles = [];
        for (var message in messages) {
          final messageText = message.data()['text'];
          final messageSender = message.data()['sender'];
          final currentUser = loggedInUser.email;

          //using iternary fun isme rather than a loop
          //   Color a = Colors.lightBlueAccent;
          // else{Color a=Colors.white;};//the msg from logged in user;


          final messageBubble =
          MessageBubble(Sender: messageSender, text: messageText, IsMe: true);
          messageBubbles.add(messageBubble);
        }

          return Expanded(
            child: ListView(
              reverse: true,
              padding: EdgeInsets.symmetric(vertical: 10.0, horizontal: 10.0),
              children: messageBubbles,
            ),
          );
        }
      );
  }
}





class MessageBubble extends StatelessWidget {

   MessageBubble({ this.Sender, this.text, this.IsMe}) ;

  final String Sender;
  final String text;
  final bool IsMe;


  @override
  Widget build(BuildContext context) {
    return Padding(
        padding: EdgeInsets.all(10.0),

      child:Column(
        crossAxisAlignment: IsMe? CrossAxisAlignment.end :CrossAxisAlignment.start,
      children:[
        Text(Sender,
         style: TextStyle(
          fontSize: 14.0,
           color: Colors.black54
      )),
       Material(
        borderRadius: IsMe? BorderRadius.only( topLeft: Radius.circular(30.0),bottomLeft: Radius.circular(30.0),bottomRight: Radius.circular(30.0) ) :
            BorderRadius.only( topRight: Radius.circular(30.0),bottomLeft: Radius.circular(30.0),bottomRight: Radius.circular(30.0)
        ),

        elevation: 5.0,
         color: IsMe ?Colors.lightBlueAccent : Colors.white,
      // Colors.lightBlueAccent,
       child:Padding(
         padding: EdgeInsets.symmetric(vertical:10,horizontal: 10),
        child: Text('$text from $Sender',
        style:TextStyle(
          color: IsMe ?Colors.white : Colors.black54,
            fontSize: 20)
        ),
      ),
      ),
      ],
      ),
    );
  }
}
