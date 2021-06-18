import 'package:flutter/material.dart';
import 'package:managents/util/constans/enumMenuLateral.dart';
import 'package:managents/models/menu_info.dart';
import 'package:managents/view/UserProfilePage.dart';
import 'package:managents/view/ViewHourIrrig/homepageIrrPresc.dart';
import 'package:managents/view/loginPage.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:managents/view/widgets/homePageCrop.dart';
import 'package:provider/provider.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  runApp(MyApp());
}

// clase principal
class MyApp extends StatefulWidget {
  @override
  _MyAppState createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (context) => MenuInfo(MenuType.clock)),
      ],
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        title: 'Manager Agents',
        theme: ThemeData(
          primarySwatch: Colors.blue,
          visualDensity: VisualDensity.adaptivePlatformDensity,
        ),
        initialRoute: '/IrrigProg',
        onGenerateRoute: (settings) {
          switch (settings.name) {
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
