import 'package:fluttermessengerapp/models/chat.dart';
import 'package:fluttermessengerapp/models/user.dart';
import 'package:fluttermessengerapp/screens/chat_screen.dart';
import 'package:fluttermessengerapp/widgets/user_widget.dart';
import 'package:flutter/material.dart';
import 'package:fluttermessengerapp/databases/user_database.dart';

class RecentChatWidget extends StatefulWidget {
  final Chat chat;

  const RecentChatWidget({Key key, this.chat}) : super(key: key);
  @override
  State<StatefulWidget> createState() => _RecentChatWidgetState();

}

class _RecentChatWidgetState extends State<RecentChatWidget> {
  @override
  Widget build(BuildContext context) {
    return ListTile(
      onTap: (){
        Navigator.of(context).push(MaterialPageRoute(builder: (context)=>ChatScreen(friend: friend,)));
      },
      leading: UserWidget(user: friend,),
      title: Text(friend.displayName,style: TextStyle(fontWeight: FontWeight.w600),),
      subtitle: Text(widget.chat.content,maxLines: 1,overflow: TextOverflow.ellipsis,),
    );
  }

  User get friend=>widget.chat.from.id==UserDatabase.user.id?widget.chat.to:widget.chat.from;
}