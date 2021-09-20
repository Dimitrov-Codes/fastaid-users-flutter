import 'package:creativedata_app/AllScreens/Chat/cachedImage.dart';
import 'package:creativedata_app/AllScreens/VideoChat/pickUpLayout.dart';
import 'package:creativedata_app/AllScreens/doctorProfileScreen.dart';
import 'package:creativedata_app/AllScreens/loginScreen.dart';
import 'package:creativedata_app/User/aboutScreen.dart';
import 'package:creativedata_app/User/helpScreen.dart';
import 'package:creativedata_app/User/personalDetails.dart';
import 'package:creativedata_app/Widgets/divider.dart';
import 'package:creativedata_app/sizeConfig.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
/*
* Created by Mujuzi Moses
*/

class UserAccount extends StatefulWidget {
  static const String screenId = "userAccount";

  final String name;
  final String userPic;
  final String email;
  final String phone;
  UserAccount({Key key,
    this.name,
    this.userPic,
    this.email,
    this.phone}) : super(key: key);
  @override
  _UserAccountState createState() => _UserAccountState();
}

class _UserAccountState extends State<UserAccount> {

  Future<bool> _onBackPressed() async {}

  @override
  Widget build(BuildContext context) {
    SizeConfig().init(context);
    return WillPopScope(
      onWillPop: _onBackPressed,
      child: PickUpLayout(
        scaffold: Scaffold(
          body: custom(
            isDoctor: false,
            body: _userAccBody(context),
            imageUrl: widget.userPic,
            doctorsName: widget.name,
            context: context,
          ),
        ),
      ),
    );
  }

  Widget _userAccBody(BuildContext context) {
    return Container(
      width: MediaQuery.of(context).size.width,
      decoration: BoxDecoration(
        color: Colors.grey[100],
      ),
      child: SingleChildScrollView(
        child: Column(
          children: <Widget>[
            Padding(
              padding: EdgeInsets.only(
                top: 2 * SizeConfig.heightMultiplier,
                left: 2 * SizeConfig.widthMultiplier,
                right: 2 * SizeConfig.widthMultiplier,
              ),
              child: GestureDetector(
                onTap: ()  => Navigator.push(
                  context, MaterialPageRoute(
                  builder: (context) => PersonalDetails(
                    name: widget.name,
                    phone: widget.phone,
                    userPic: widget.userPic,
                    email: widget.email,
                  ),
                ),),
                child: Container(
                  height: 12 * SizeConfig.heightMultiplier,
                  width: 88 * SizeConfig.widthMultiplier,
                  decoration: BoxDecoration(
                    boxShadow: [
                      BoxShadow(
                        offset: Offset(0, 2),
                        spreadRadius: 1,
                        blurRadius: 5,
                        color: Colors.black.withOpacity(0.1),
                      ),
                    ],
                  ),
                  child: Material(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(10),
                    child: InkWell(
                      splashColor: Colors.red[300],
                      highlightColor: Colors.grey.withOpacity(0.1),
                      radius: 800,
                      borderRadius: BorderRadius.circular(10),
                      onTap: () => Navigator.push(
                        context, MaterialPageRoute(
                        builder: (context) => PersonalDetails(
                          name: widget.name,
                          phone: widget.phone,
                          userPic: widget.userPic,
                          email: widget.email,
                        ),
                      ),),
                      child: Padding(
                          padding: EdgeInsets.all(8),
                          child: Row(
                            children: <Widget>[
                              CachedImage(
                                  imageUrl: widget.userPic,
                                  isRound: true,
                                  radius: 60,
                                  fit: BoxFit.cover,
                                ),
                              SizedBox(width: 5 * SizeConfig.widthMultiplier,),
                              Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: <Widget>[
                                  Spacer(),
                                  Expanded(
                                    flex: 0,
                                    child: Container(
                                      width: 50 * SizeConfig.widthMultiplier,
                                      child: Wrap(
                                        children: [Text(widget.name, style: TextStyle(
                                          color: Colors.red[300],
                                          fontFamily: "Brand Bold",
                                          fontSize: 3 * SizeConfig.textMultiplier,
                                          fontWeight: FontWeight.bold,
                                        ),),
                                        ],
                                      ),
                                    ),
                                  ),
                                  SizedBox(height: 0.5 * SizeConfig.heightMultiplier,),
                                  Text(widget.phone,style: TextStyle(
                                      color: Colors.black,
                                      fontWeight: FontWeight.w300,
                                      fontSize: 2.2 * SizeConfig.textMultiplier,
                                    ),
                                  ),
                                  Spacer(),
                                ],
                              ),
                              Spacer(),
                              Container(
                                height: 10 * SizeConfig.heightMultiplier,
                                width: 6 * SizeConfig.widthMultiplier,
                                child: GestureDetector(
                                  onTap: () => Navigator.push(
                                    context, MaterialPageRoute(
                                    builder: (context) => PersonalDetails(
                                      name: widget.name,
                                      phone: widget.phone,
                                      userPic: widget.userPic,
                                      email: widget.email,
                                    ),
                                  ),),
                                  child: Center(
                                    child: Icon(Icons.arrow_forward_ios_rounded,
                                      color: Colors.red,
                                      size: 4 * SizeConfig.imageSizeMultiplier,
                                    ),
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ),
                    ),
                  ),
                ),
              ),
            ),
            SizedBox(height: 3 * SizeConfig.heightMultiplier,),
            Padding(
              padding: EdgeInsets.only(
                left: 2 * SizeConfig.widthMultiplier,
                right: 2 * SizeConfig.widthMultiplier,
                bottom: 2 * SizeConfig.heightMultiplier,
              ),
              child: Container(
                height: 28 * SizeConfig.heightMultiplier,
                width: 88 * SizeConfig.widthMultiplier,
                decoration: BoxDecoration(
                  boxShadow: [
                    BoxShadow(
                      offset: Offset(0, 2),
                      spreadRadius: 1,
                      blurRadius: 5,
                      color: Colors.black.withOpacity(0.1),
                    ),
                  ],
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(10),
                ),
                child: Padding(
                  padding: EdgeInsets.all(8.0),
                  child: Column(
                    children: <Widget>[
                      _tiles(
                        icon: CupertinoIcons.question_circle,
                        message: "Help",
                        color: Colors.red[300],
                        onTap: () => Navigator.push(
                          context, MaterialPageRoute(
                          builder: (context) => HelpScreen(),
                        ),),
                      ),
                      SizedBox(height: 1 * SizeConfig.heightMultiplier,),
                      DividerWidget(),
                      SizedBox(height: 1 * SizeConfig.heightMultiplier,),
                      _tiles(
                        icon: CupertinoIcons.info_circle,
                        message: "About",
                        color: Colors.red[300],
                        onTap: () => Navigator.push(
                          context, MaterialPageRoute(
                          builder: (context) => AboutScreen(),
                        ),),
                      ),
                      SizedBox(height: 1 * SizeConfig.heightMultiplier,),
                      DividerWidget(),
                      SizedBox(height: 1 * SizeConfig.heightMultiplier,),
                      _tiles(
                        icon: Icons.logout,
                        message: "Log out",
                        color: Colors.red[300],
                        onTap: () {
                          FirebaseAuth.instance.signOut();
                          Navigator.pushReplacement(context, MaterialPageRoute(
                              builder: (context) => LoginScreen()
                          ));
                        },
                      ),
                    ],
                  ),
                ),
              ),
            ),
            SizedBox(height: 2 * SizeConfig.heightMultiplier,),
            Padding(
              padding: EdgeInsets.only(
                left: 2 * SizeConfig.widthMultiplier,
                right: 2 * SizeConfig.widthMultiplier,
                bottom: 2 * SizeConfig.heightMultiplier,
              ),
              child: Center(
                  child: Column(
                      children: <Widget>[
                        Image(
                          image: AssetImage("images/logo.png"),
                          width: 14 * SizeConfig.widthMultiplier,
                          height: 8 * SizeConfig.heightMultiplier,
                        ),
                        Row(
                          children: <Widget>[
                            Spacer(),
                            Text("Version:", style: TextStyle(
                              fontSize: 2 * SizeConfig.textMultiplier,
                              fontWeight: FontWeight.w500,
                              color: Colors.red[700],
                            ),),
                            Text("1.0.0", style: TextStyle(
                              fontSize: 2 * SizeConfig.textMultiplier,
                              fontWeight: FontWeight.w400,
                              color: Colors.red[900],
                            ),),
                            Spacer(),
                          ],
                        ),
                      ],
                    ),
                ),
            ),
            SizedBox(height: 23 * SizeConfig.heightMultiplier,),
          ],
        ),
      ),
    );
  }

  Widget _tiles({IconData icon, String message, Function onTap, Color color}) {
    return Material(
      color: Colors.white,
      child: InkWell(
        splashColor: Colors.red[300],
        highlightColor: Colors.grey.withOpacity(0.1),
        radius: 800,
        borderRadius: BorderRadius.circular(10),
        onTap: onTap,
        child: Container(
          height: 7 * SizeConfig.heightMultiplier,
          width: 84 * SizeConfig.widthMultiplier,
          child: Row(
            children: <Widget>[
              Icon(icon,
                color: color,
                size: 6 * SizeConfig.imageSizeMultiplier,
              ),
              SizedBox(width: 3 * SizeConfig.widthMultiplier,),
              Text(message, style: TextStyle(
                fontFamily: "Brand-Regular",
                  fontWeight: FontWeight.w400,
                  color: color,
                  fontSize: 2.5 * SizeConfig.textMultiplier,
                ),),
              Spacer(),
              Container(
                height: 5 * SizeConfig.heightMultiplier,
                width: 6 * SizeConfig.widthMultiplier,
                child: GestureDetector(
                  onTap: onTap,
                  child: Center(
                    child: Icon(Icons.arrow_forward_ios_rounded,
                      color: color,
                      size: 4 * SizeConfig.imageSizeMultiplier,
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
