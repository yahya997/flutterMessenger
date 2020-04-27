import 'package:fluttermessengerapp/databases/user_database.dart';
import 'package:fluttermessengerapp/models/user.dart';
import 'package:fluttermessengerapp/widgets/wave_user_widget.dart';
import 'package:flutter/material.dart';

class PeopleScreen extends StatefulWidget {
  @override
  State<StatefulWidget> createState() => _PeopleScreenState();

}

class _PeopleScreenState extends State<PeopleScreen> {
  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[

        Padding(
          padding: const EdgeInsets.symmetric(vertical: 8.0,horizontal: 20.0),
          child: Text("Active",style: TextStyle(fontSize: 16.0,color: Colors.black54),),
        ),
        FutureBuilder(
          future: UserDatabase.getActiveUsers(),
          builder: (context,snapshot){
            if(!snapshot.hasData){
              return Center(
                child: CircularProgressIndicator(),
              );
            }
            List<User> data=snapshot.data;
            if(data.length==0){
              return Center(
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: <Widget>[
                    Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Text("Want to connect with developers",style: TextStyle(fontSize: 16.0),textAlign: TextAlign.center,),
                    ),
                    FlatButton(onPressed: (){}, child: Text("Invite Here"))
                  ],
                ),
              );
            }
            return ListView.builder(
              padding: EdgeInsets.symmetric(horizontal: 8.0),
              itemBuilder: (context, index) => WaveUserWidget(
                user:data[index],
              ),
              itemCount: data.length,
              shrinkWrap: true,
              physics: ClampingScrollPhysics(),
            );
          },
        )
      ],
    );
  }

}