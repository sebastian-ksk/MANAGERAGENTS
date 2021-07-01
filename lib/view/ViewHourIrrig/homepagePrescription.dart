import 'package:flutter/material.dart';
import 'package:managents/util/constans/PrescHoursmenu.dart';
import 'package:managents/util/constans/enumMenuLateral.dart';
import 'package:managents/models/menu_info.dart';
import 'package:managents/util/constans/theme_data.dart';
import 'package:managents/view/ViewHourIrrig/IrrigState.dart';
import 'package:managents/view/ViewHourIrrig/PrescriptHedit.dart';
import 'package:managents/view/ViewHourIrrig/PrescriptState.dart';
import 'package:managents/view/ViewHourIrrig/irrigationHedit.dart';
import 'package:managents/view/ViewHourIrrig/clock_page.dart';
import 'package:provider/provider.dart';
import '../../util/constans/IrrigHoursmenu.dart';

class HomePagePrescription extends StatefulWidget {
  @override
  _HomePagePrescriptionState createState() => _HomePagePrescriptionState();
}

class _HomePagePrescriptionState extends State<HomePagePrescription> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: CustomColors.pageBackgroundColor,
      body: Row(
        children: <Widget>[
          Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: menuItemsPresc
                .map((currentMenuInfo) => buildMenuButton(currentMenuInfo))
                .toList(),
          ),
          VerticalDivider(
            color: CustomColors.dividerColor,
            width: 1,
          ),
          Expanded(
            child: Consumer<MenuInfo>(
              builder: (BuildContext context, MenuInfo value, Widget child) {
                if (value.menuType == MenuType.clock)
                  return ClockPage();
                else if (value.menuType == MenuType.hourIrrig)
                  return PrescriptionHoursEdit();
                else if (value.menuType == MenuType.generaldata)
                  return PrescriptionState();
                else
                  return Container(
                    child: RichText(
                      text: TextSpan(
                        style: TextStyle(fontSize: 20),
                        children: <TextSpan>[
                          TextSpan(text: 'Upcoming Tutorial\n'),
                          TextSpan(
                            text: value.title,
                            style: TextStyle(fontSize: 48),
                          ),
                        ],
                      ),
                    ),
                  );
              },
            ),
          ),
        ],
      ),
    );
  }

  Widget buildMenuButton(MenuInfo currentMenuInfo) {
    return Consumer<MenuInfo>(
      builder: (BuildContext context, MenuInfo value, Widget child) {
        return FlatButton(
          shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.only(topRight: Radius.circular(32))),
          padding: const EdgeInsets.symmetric(vertical: 16.0, horizontal: 0),
          color: currentMenuInfo.menuType == value.menuType
              ? CustomColors.menuBackgroundColor
              : Colors.transparent,
          onPressed: () {
            var menuInfo = Provider.of<MenuInfo>(context, listen: false);
            menuInfo.updateMenu(currentMenuInfo);
          },
          child: Column(
            children: <Widget>[
              Image.asset(
                currentMenuInfo.imageSource,
                scale: 1.5,
              ),
              SizedBox(height: 16),
              Text(
                currentMenuInfo.title ?? '',
                style: TextStyle(
                    fontFamily: 'avenir',
                    color: CustomColors.primaryTextColor,
                    fontSize: 14),
              ),
            ],
          ),
        );
      },
    );
  }
}
