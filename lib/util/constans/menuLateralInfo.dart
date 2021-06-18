import 'package:managents/util/constans/enumMenuLateral.dart';
import '../../models/irrigHoursModel.dart';
import '../../models/menu_info.dart';

List<MenuInfo> menuItems = [
  MenuInfo(MenuType.clock,
      title: 'Clock', imageSource: 'assets/img/clock_icon.png'),
  MenuInfo(MenuType.alarm,
      title: 'IrrigHour', imageSource: 'assets/img/alarm_icon.png'),
];

List<IrrigHoursModel> alarms = [
  IrrigHoursModel(
      IrrigHourDateTime: DateTime.now().add(Duration(hours: 1)),
      title: 'Office',
      gradientColorIndex: 0),
  IrrigHoursModel(
      IrrigHourDateTime: DateTime.now().add(Duration(hours: 2)),
      title: 'Sport',
      gradientColorIndex: 1),
];
