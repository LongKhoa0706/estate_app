import 'package:estate_app/src/model/message.dart';
import 'package:estate_app/src/repositories/repositories/user_repositories.dart';
import 'package:flutter/material.dart';

class ChatScreen extends StatefulWidget {
  @override
  _ChatScreenState createState() => _ChatScreenState();
}

class _ChatScreenState extends State<ChatScreen> {
  final textController = TextEditingController();

  UserRepositories userRepositories = UserRepositories();

  @override
  void initState() {
    userRepositories.getMessage();
    // TODO: implement initState
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    userRepositories.getMessage();
    return Scaffold(
      body: Container(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Expanded(
              child: ListView.builder(
                shrinkWrap: true,
                itemCount: userRepositories.listMessage.length,
                itemBuilder: (_,index){
                  Message mes = userRepositories.listMessage[index];

                  return Text(mes.message);
                },
              ),
            ),
            TextFormField(
              controller: textController,
            ),
            RaisedButton(
              onPressed: (){
                setState(() {
                  userRepositories.sendMessage(textController.text);

                });
              },
            )
          ],
        ),
      ),
    );
  }
}
