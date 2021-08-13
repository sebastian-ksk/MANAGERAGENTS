import 'dart:async';
import 'dart:math';

import 'package:flutter/material.dart';
import 'package:managents/data/Firebase/ApiServiceAuth.dart';
import 'package:managents/models/authentication/user.dart';
import 'package:managents/providers/HomePageProvider.dart';
import 'package:managents/splash/splash_page.dart';
import 'package:managents/util/constans/enumMenuLateral.dart';
import 'package:managents/models/menu_info.dart';
import 'package:managents/view/UserProfilePage.dart';
import 'package:managents/view/ViewHourIrrig/homepageIrrigation.dart';
import 'package:managents/view/loginPage.dart';
import 'package:managents/view/widgets/homePageCrop.dart';
import 'package:provider/provider.dart';
//import the firebase_core plugiin
import 'package:firebase_core/firebase_core.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  runApp(MyApp());
}

// clase principal
class MyApp extends StatefulWidget {
  @override
  _MyAppState createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  //  final Future<FirebaseApp> _initialization = Firebase.initializeApp();
  String route = '/Login';

  // @override
  // void initState() {
  //   checkLoginStatus();
  //   super.initState();
  // }

  @override
  Widget build(BuildContext context) {
    return MultiProvider(providers: [
      ChangeNotifierProvider(create: (context) => MenuInfo(MenuType.clock)),
      ChangeNotifierProvider(create: (context) => Authentication()),
      ChangeNotifierProvider(create: (context) => HomePageProvider())
    ], child: InitApp());
  }
}

class InitApp extends StatefulWidget {
  @override
  _InitAppState createState() => _InitAppState();
}

class _InitAppState extends State<InitApp> {
  Future<UserApp> checkLoginStatus() async {
    UserApp user = await Authentication().isSignedIn();
    print('user: ${user.email}');
    return user;
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Manager Agents',
      home: FutureBuilder<UserApp>(
          future: Authentication().isSignedIn(),
          builder: (context, snapshot) {
            if (snapshot.hasData) {
              return HomePageCrop(
                currentUser: snapshot.data,
              );
            } else if (snapshot.hasError) {
              print(snapshot.error);
              return LoginPage();
            }
            return SplashPage();
          }),
    );
  }
}
