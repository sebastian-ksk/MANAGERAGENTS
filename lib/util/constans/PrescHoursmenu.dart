import 'package:managents/models/PrescHoursModel.dart';
import 'package:managents/util/constans/enumMenuLateral.dart';
import '../../models/menu_info.dart';

List<MenuInfo> menuItemsPresc = [
  MenuInfo(MenuType.clock,
      title: 'Clock', imageSource: 'assets/img/clock_icon.png'),
  MenuInfo(MenuType.hourIrrig,
      title: 'PrescHour', imageSource: 'assets/img/alarm_icon.png'),
  MenuInfo(MenuType.generaldata,
      title: 'State', imageSource: 'assets/img/add_alarm.png'),
];

List<PrescHoursModel> alarms = [
  PrescHoursModel(
      PrescHourDateTime: DateTime.now().add(Duration(hours: 1)),
      title: 'Office',
      gradientColorIndex: 0),
  PrescHoursModel(
      PrescHourDateTime: DateTime.now().add(Duration(hours: 2)),
      title: 'Sport',
      gradientColorIndex: 1),
];
