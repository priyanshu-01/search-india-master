import 'dart:developer';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';
import 'package:search_india/about_us.dart';
import 'package:search_india/chat.dart';
import 'package:search_india/make_add.dart';
import 'package:search_india/my_adds.dart';
import 'package:search_india/profile.dart';
import 'mpage.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:easy_localization/easy_localization.dart';
import 'dart:io';

class MainPage extends StatefulWidget {
  @override
  _MainPageState createState() => _MainPageState();
}

class _MainPageState extends State<MainPage> {

  FirebaseMessaging _firebaseMessaging;

  void setUpFirebase() {
    _firebaseMessaging = FirebaseMessaging();
    firebaseCloudMessaging_Listeners();

  }

  void firebaseCloudMessaging_Listeners() {
    if (Platform.isIOS) iOS_Permission();

    _firebaseMessaging.getToken().then((token) {
      print(token);
    });

    _firebaseMessaging.configure(
      onMessage: (Map<String, dynamic> message) async {
        print('on message $message');
      },
      onResume: (Map<String, dynamic> message) async {
        print('on resume $message');
      },
      onLaunch: (Map<String, dynamic> message) async {
        print('on launch $message');
      },
    );
  }

  void iOS_Permission() {
    _firebaseMessaging.requestNotificationPermissions(
        IosNotificationSettings(sound: true, badge: true, alert: true));
    _firebaseMessaging.onIosSettingsRegistered
        .listen((IosNotificationSettings settings) {
      print("Settings registered: $settings");
    });
  }

  int num = 0;
  final widgets = [MainPage2(),CreateAdd(),MyAdds(),Container(),AboutUs()];


  @override
  void initState() {
    super.initState();
    setUpFirebase();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomPadding: false,
      body: widgets[num],
      bottomNavigationBar: BottomNavigationBar(

        showUnselectedLabels: true,
        backgroundColor: Colors.white,
        items:  <BottomNavigationBarItem>[
          BottomNavigationBarItem(

            icon: Icon(
              Icons.home,
              color: Colors.black,
            ),
            title: Text('home',style: TextStyle(color: Colors.black)).tr(context: context),
          ),
          BottomNavigationBarItem(
            icon: Icon(
              Icons.view_quilt,
              color: Colors.black,
            ),
            title: Text('new_ad',style: TextStyle(color: Colors.black)).tr(),
          ),
          BottomNavigationBarItem(
            icon: Icon(
              Icons.menu,
              color: Colors.black,
            ),
            title: Text('our_ads',style: TextStyle(color: Colors.black)).tr(),
          ),
          BottomNavigationBarItem(
            icon: Icon(
              Icons.person,
              color: Colors.black,
            ),
            title: Text('person',style: TextStyle(color: Colors.black)).tr(),
          ),
          BottomNavigationBarItem(
            icon: Icon(
              Icons.info,
              color: Colors.black,
            ),
            title: Text('about', style: TextStyle(color: Colors.black),).tr()
          )
        ],
        onTap: (a){
          setState(() {
            if(a == 3){
              num = 0;
              Navigator.push(context, MaterialPageRoute(builder: (context)=>Profile()));
            }else
              num = a;
          });
        },
        currentIndex: num,
        //selectedItemColor: Colors.greenAccent,
        type: BottomNavigationBarType.fixed,
        selectedLabelStyle: TextStyle(color: Colors.greenAccent),
      ),
    );
  }
}
