import 'package:flutter/material.dart';
import 'package:managents/data/Firebase/ApiServiceAuth.dart';
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
  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (context) => MenuInfo(MenuType.clock)),
        ChangeNotifierProvider(create: (context) => Authentication())
      ],
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        title: 'Manager Agents',
        theme: ThemeData(
          primarySwatch: Colors.blue,
          visualDensity: VisualDensity.adaptivePlatformDensity,
        ),
        initialRoute: route,
        onGenerateRoute: (settings) {
          switch (settings.name) {
            case '/Login':
              return MaterialPageRoute(builder: (context) => new LoginPage());
            case '/user': //pagina de login
              return MaterialPageRoute(
                  builder: (context) => new UserProfilePage());
            case '/HomeCrop':
              return MaterialPageRoute(
                  builder: (context) => new HomePageCrop());
            case '/IrrigProg':
              return MaterialPageRoute(
                  builder: (context) => new HomePageIrrPresc());
            default:
              return null;
          }
        },
      ),
    );
  }
}
