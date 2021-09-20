import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:creativedata_app/AllScreens/registerScreen.dart';
import 'package:creativedata_app/Services/auth.dart';
import 'package:creativedata_app/Services/database.dart';
import 'package:creativedata_app/Services/helperFunctions.dart';
import 'package:creativedata_app/Widgets/customBottomNavBar.dart';
import 'package:creativedata_app/sizeConfig.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:fluttertoast/fluttertoast.dart';
/*
* Created by Mujuzi Moses
*/

class LoginScreen extends StatelessWidget {
  static const String screenId = "loginScreen";
  
  AuthMethods authMethods = new AuthMethods();
  DatabaseMethods databaseMethods = new DatabaseMethods();
  TextEditingController emailTEC = TextEditingController();
  TextEditingController passwordTEC = TextEditingController();
  QuerySnapshot snapshot;
  String regId;
  String hospital;

  @override
  Widget build(BuildContext context) {
    SizeConfig().init(context);
    return Scaffold(
      backgroundColor: Colors.grey[200],
      body: SingleChildScrollView(
        child: Padding(
          padding: EdgeInsets.all(8.0),
          child: Column(
            children: <Widget>[
              SizedBox(
                height: 35.0,
              ),
              Image(
                image: AssetImage("images/logo.png"),
                width: 39 * SizeConfig.widthMultiplier,
                height: 25 * SizeConfig.heightMultiplier,
                alignment: Alignment.center,
              ),
              SizedBox(
                height: 1.0,
              ),
              Text(
                "Login here",
                style: TextStyle(fontSize: 3.5 * SizeConfig.textMultiplier, fontFamily: "Brand Bold"),
                textAlign: TextAlign.center,
              ),
              Padding(
                padding: EdgeInsets.all(20.0),
                child: Column(
                  children: [
                    SizedBox(
                      height: 1.0,
                    ),
                    TextField(
                      controller: emailTEC,
                      keyboardType: TextInputType.emailAddress,
                      decoration: InputDecoration(
                        labelText: "Email",
                        labelStyle: TextStyle(
                          fontSize: 2 * SizeConfig.textMultiplier,
                        ),
                        hintStyle: TextStyle(
                          color: Colors.grey,
                          fontSize: 1.5 * SizeConfig.textMultiplier,
                        ),
                      ),
                      style: TextStyle(fontSize: 2 * SizeConfig.textMultiplier),
                    ),
                    SizedBox(
                      height: 1.0,
                    ),
                    TextField(
                      controller: passwordTEC,
                      obscureText: true,
                      decoration: InputDecoration(
                        labelText: "Password",
                        labelStyle: TextStyle(
                          fontSize: 2 * SizeConfig.textMultiplier,
                        ),
                        hintStyle: TextStyle(
                          color: Colors.grey,
                          fontSize: 1.5 * SizeConfig.textMultiplier,
                        ),
                      ),
                      style: TextStyle(fontSize: 2 * SizeConfig.textMultiplier),
                    ),
                    SizedBox(
                      height: 10.0,
                    ),
                    RaisedButton(
                      color: Colors.red[300],
                      textColor: Colors.white,
                      child: Container(
                        height: 6.5 * SizeConfig.heightMultiplier,
                        child: Center(
                          child: Text(
                            "Login",
                            style: TextStyle(fontSize: 2.5 * SizeConfig.textMultiplier, fontFamily: "Brand Bold"),
                          ),
                        ),
                      ),
                      shape: new RoundedRectangleBorder(
                        borderRadius: new BorderRadius.circular(24.0),
                      ),
                      onPressed: () {
                        if (!emailTEC.text.contains("@")) {
                          displayToastMessage("Email address is Void", context);
                        } else if (passwordTEC.text.isEmpty) {
                          displayToastMessage("Input Password", context);
                        } else {
                          HelperFunctions.saveUserEmailSharedPref(emailTEC.text.trim());
                          databaseMethods.getUserByUserEmail(emailTEC.text).then((val) {
                            snapshot = val;
                            HelperFunctions.saveUserNameSharedPref(snapshot.docs[0].get("name"));
                            regId = snapshot.docs[0].get("regId");
                            authMethods.signInWithEmailAndPassword(context, emailTEC.text, passwordTEC.text)
                                .then((val) {
                              if (val != null) {
                                switch (regId) {
                                  case "Doctor":
                                    HelperFunctions.saveUserLoggedInSharedPref(true);
                                    Navigator.pushReplacement(context, MaterialPageRoute(
                                        builder: (context) => CustomBottomNavBar(isDoctor: true,)
                                    ));
                                    displayToastMessage("Logged in Successfully", context);
                                    break;
                                  case "User":
                                    HelperFunctions.saveUserLoggedInSharedPref(true);
                                    Navigator.pushReplacement(context, MaterialPageRoute(
                                        builder: (context) => CustomBottomNavBar(isDoctor: false,)
                                    ));
                                    displayToastMessage("Logged in Successfully", context);
                                    break;
                                }
                              } else {
                                displayToastMessage("Login Failed", context);
                              }
                            });
                          });
                        }
                      },
                    ),
                  ],
                ),
              ),
              SizedBox(height: 22 * SizeConfig.heightMultiplier,),
              TextButton(
                onPressed: () {
                },
                child: Text(
                  "Forgot Password?!",

                ),
              ),
              TextButton(
                onPressed: () {
                 Navigator.pushNamedAndRemoveUntil(context, RegisterScreen.screenId, (route) => false);
                },
                child: Text(
                    "Don't have an Account? Register Here", style: TextStyle(decoration: TextDecoration.underline),
                  ),
              ),

            ],
          ),
        ),
      ),
    );
  }

}

displayToastMessage(String message, BuildContext context) {
  Fluttertoast.showToast(msg: message);
}
