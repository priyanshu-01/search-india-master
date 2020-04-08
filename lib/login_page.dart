import 'package:flutter/material.dart';
import 'package:search_india/mobileLogin.dart';
import 'package:search_india/profile.dart';
import 'package:search_india/register_page.dart';
import 'package:modal_progress_hud/modal_progress_hud.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:search_india/secondLoginPhone.dart';

class LoginPage extends StatefulWidget {
  @override
  _LoginPageState createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  final key = new GlobalKey<ScaffoldState>();
  final _auth = FirebaseAuth.instance;
  bool loading = false;
  String email, password;

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: ModalProgressHUD(
        inAsyncCall: loading,
        child: Scaffold(
          key: key,
          resizeToAvoidBottomPadding: false,
          body: Container(
            height: double.infinity,
            decoration: BoxDecoration(
                image: DecorationImage(
                    image: AssetImage('images/login.jpeg'), fit: BoxFit.cover)),
            child: SingleChildScrollView(
              child: Column(
                children: <Widget>[
                  Row(
                    mainAxisAlignment: MainAxisAlignment.end,
                    children: <Widget>[
                      Container(
                          color: Colors.black,
                          height: 150,
                          width: 170,
                          child: Image(
                            image: AssetImage('images/splash.png'),
                            fit: BoxFit.cover,
                          )),
                    ],
                  ),
                  SizedBox(
                    height: 30,
                  ),
                  Text(
                    'WELCOME',
                    style: TextStyle(
                        fontSize: 32,
                        color: Colors.white.withAlpha(220),
                        fontWeight: FontWeight.bold,
                        letterSpacing: 2),
                  ),
                  SizedBox(
                    height: 10,
                  ),
                  Text(
                    'Login to Continue',
                    style: TextStyle(fontSize: 16),
                  ),
                  SizedBox(
                    height: 50,
                  ),
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 40.0),
                    child: TextField(
                      onChanged: (val) {
                        email = val;
                      },
                      style: TextStyle(color: Colors.white),
                      decoration: InputDecoration(
                        filled: true,
                        fillColor: Colors.white.withAlpha(125),
                        hintText: 'Email',
                        hintStyle: TextStyle(
                          color: Colors.white,
                        ),
                        icon: Icon(
                          Icons.person,
                          size: 40,
                          color: Colors.white,
                        ),
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(30),
                          borderSide: BorderSide.none,
                        ),
                      ),
                    ),
                  ),
                  SizedBox(
                    height: 10,
                  ),
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 40.0),
                    child: TextField(
                      obscureText: true,
                      onChanged: (val) {
                        password = val;
                      },
                      style: TextStyle(color: Colors.white),
                      decoration: InputDecoration(
                        filled: true,
                        fillColor: Colors.white.withAlpha(125),
                        hintText: 'Password',
                        hintStyle: TextStyle(
                          color: Colors.white,
                        ),
                        icon: Icon(
                          Icons.lock,
                          size: 40,
                          color: Colors.white,
                        ),
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(30),
                          borderSide: BorderSide.none,
                        ),
                      ),
                    ),
                  ),
                  SizedBox(
                    height: 10,
                  ),
                  InkWell(
                    onTap: () async {
                      if (email == null || email == "") {
                        final snackBar = new SnackBar(
                            content: new Text(
                              "Please fill your e-mail address above to get a password reset link",
                              style: TextStyle(fontSize: 15),
                            ),
                            duration: new Duration(milliseconds: 2800),
                            backgroundColor: Colors.grey.shade200);
                        key.currentState.showSnackBar(snackBar);
                      } else {
                        await _auth.sendPasswordResetEmail(email: email);
                        final snackBar = new SnackBar(
                            content: new Text(
                              "Check your e-mail to reset your password",
                              style: TextStyle(fontSize: 15),
                            ),
                            duration: new Duration(milliseconds: 2800),
                            backgroundColor: Colors.grey.shade200);
                        key.currentState.showSnackBar(snackBar);
                      }
                    },
                    child: Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Text('Forgot Password?'),
                    ),
                  ),
                  SizedBox(
                    height: 5,
                  ),
                  InkWell(
                    onTap: (){
                      Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) => MobileLogin()));

                    },
                    child: Padding(
                      padding: const EdgeInsets.all(5.0),
                      child: Text("Sign-up using Mobile"),
                    ),
                  ),
                  SizedBox(
                    height: 5,
                  ),
                  InkWell(
                    onTap: (){
                      Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) => OldLoginMobile()));

                    },
                    child: Padding(
                      padding: const EdgeInsets.all(5.0),
                      child: Text("Login using Mobile"),
                    ),
                  ),
                  SizedBox(
                    height: 40,
                  ),
                  GestureDetector(
                    onTap: () async {
                      try {
                        setState(() {
                          loading = true;
                        });
                        FirebaseUser user =
                            (await _auth.signInWithEmailAndPassword(
                                    email: email, password: password))
                                .user;
                        if (user.isEmailVerified) {
                          setState(() {
                            loading = false;
                          });
                          Navigator.push(
                              context,
                              MaterialPageRoute(
                                  builder: (context) => Profile()));
                        } else {
                          final snackBar = new SnackBar(
                              content: new Text(
                                "Please verify your account first",
                                style: TextStyle(fontSize: 15),
                              ),
                              duration: new Duration(milliseconds: 1800),
                              backgroundColor: Colors.grey.shade200);
                          key.currentState.showSnackBar(snackBar);
                        }
                      } catch (e) {
                        print(e);
                        final snackBar = new SnackBar(
                            content: new Text(
                              "An error has occured, please try again later.",
                              style: TextStyle(fontSize: 15),
                            ),
                            duration: new Duration(milliseconds: 1800),
                            backgroundColor: Colors.grey.shade200);
                        key.currentState.showSnackBar(snackBar);
                      }
                    },
                    child: Container(
                      width: 200,
                      height: 40,
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.all(Radius.circular(8)),
                        color: Colors.white.withAlpha(150),
                      ),
                      child: Center(
                        child: Text(
                          'LOGIN',
                          style: TextStyle(
                            color: Colors.black,
                          ),
                        ),
                      ),
                    ),
                  ),
                  SizedBox(
                    height: 20,
                  ),
                  GestureDetector(
                    onTap: () {
                      Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) => RegisterPage()));
                    },
                    child: Container(
                      width: 200,
                      height: 40,
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.all(Radius.circular(8)),
                        border: Border.all(width: 2, color: Colors.white),
                      ),
                      child: Center(
                        child: Text(
                          'REGISTER',
                          style: TextStyle(color: Colors.white),
                        ),
                      ),
                    ),
                  ),
                  SizedBox(
                    height: 40,
                  ),
                  GestureDetector(
                      onTap: () {
                        Navigator.pop(context);
                      },
                      child: Text(
                        'Back to Home',
                        style: TextStyle(fontSize: 18),
                      )),
                  SizedBox(
                    height: 20,
                  )
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
