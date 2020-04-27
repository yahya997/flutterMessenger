import 'package:fluttermessengerapp/databases/chats_database.dart';
import 'package:fluttermessengerapp/databases/user_database.dart';
import 'package:fluttermessengerapp/models/chat.dart';
import 'package:fluttermessengerapp/widgets/recent_chat_widget.dart';
import 'package:flutter/material.dart';

class ChatsScreen extends StatefulWidget {
  @override
  State<StatefulWidget> createState() => _ChatsScreenState();
}

class _ChatsScreenState extends State<ChatsScreen> {
  @override
  void initState() {
    super.initState();
  }
  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      children: <Widget>[
        StreamBuilder(
          stream: ChatsDatabase.getChats(),
          builder: (context,snapshot){
            if(!snapshot.hasData){
              return Center(child: CircularProgressIndicator(),);
            }
            List<Chat>chats=snapshot.data;
            return ListView.builder(
              itemBuilder: (context, index) =>RecentChatWidget(
                chat: chats[index],
              ),
              itemCount:chats.length,
              shrinkWrap: true,
              physics: ClampingScrollPhysics(),
            );
          },
        )
      ],
    );
  }
}
