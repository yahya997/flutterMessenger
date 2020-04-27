import 'package:fluttermessengerapp/databases/user_database.dart';
import 'package:fluttermessengerapp/widgets/login_button.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_facebook_login/flutter_facebook_login.dart';
import 'package:firebase_auth/firebase_auth.dart';

class SplashScreen extends StatefulWidget {
  @override
  State<StatefulWidget> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  bool isLoggedIn;
  @override
  void initState() {
    super.initState();
    SystemChrome.setSystemUIOverlayStyle(SystemUiOverlayStyle.dark.copyWith(statusBarColor: Colors.white,statusBarBrightness: Brightness.dark));
    UserDatabase.isLoggedIn().then((val){
      setState(() {
        isLoggedIn=val;
      });
      if(isLoggedIn){
        Navigator.of(context).pushNamed('/main');
      }
    });

  }
  @override
  Widget build(BuildContext context) {
    double imageSize = MediaQuery.of(context).size.width / 3;
    return Scaffold(
      body: Center(
        child: Image.asset(
          "images/logo.png",
          width: imageSize,
          height: imageSize,
          fit: BoxFit.cover,
        ),
      ),
      bottomNavigationBar: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 16.0,vertical: 16.0),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: <Widget>[
            isLoggedIn==null?CircularProgressIndicator():!isLoggedIn?LoginButton("Continue with Facebook",
                color: Color(0xff3b5998),
                onPressed: initiateFacebookLogin,
                leading: Image.network(
                  "http://www.logospng.com/images/16/social-facebook-1489-1488-1494-1500-1497-1491-1505-1493-1499-1504-1493-1514-1508-1512-1505-1493-1501-1491-1497-1490-1497-1496-1500-1497-buzzlead-16424.png",
                  color: Colors.white,
                  width: 24.0,
                  height: 24.0,
                )):Container(width: 0.0,height: 0.0,),
            Padding(
              padding: const EdgeInsets.only(top:20.0),
              child: Text("By continuing, You agree to our Private Policy.",style: TextStyle(color: Colors.black45,fontSize: 14.0,fontWeight: FontWeight.w500),textAlign: TextAlign.center,),
            )
          ],
        ),
      ),
    );
  }
  void initiateFacebookLogin() async {
    var facebookLogin = FacebookLogin();
    var result =
    await facebookLogin.logIn(['email']);
    switch (result.status) {
      case FacebookLoginStatus.error:
        print("Error");
        break;
      case FacebookLoginStatus.cancelledByUser:
        print("CancelledByUser");
        break;
      case FacebookLoginStatus.loggedIn:
        final token = result.accessToken.token;
        final AuthCredential credential=FacebookAuthProvider.getCredential(accessToken: token);
        print("Success");
        final AuthResult authResult = await FirebaseAuth.instance.signInWithCredential(credential);
        FirebaseUser user=authResult.user;
        print("User $user");
        setState(() {
          isLoggedIn=true;
        });
        await UserDatabase.updateUser(true);
        if(user!=null){
          Navigator.of(context).pushNamed('/main');
        }
        break;
    }
  }

}
