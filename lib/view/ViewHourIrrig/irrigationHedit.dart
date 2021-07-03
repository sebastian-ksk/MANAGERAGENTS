import 'package:dotted_border/dotted_border.dart';
import 'package:flutter/material.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:intl/intl.dart';
import 'package:managents/data/sql/Irrighoursdb.dart';
import 'package:managents/models/irrigHoursModel.dart';
import 'package:managents/util/constans/theme_data.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class IrrigationHoursEdit extends StatefulWidget {
  @override
  _IrrigationHoursEditState createState() => _IrrigationHoursEditState();
}

class _IrrigationHoursEditState extends State<IrrigationHoursEdit> {
  DateTime _hourTime;
  String _hourTimeString;
  HourIrrigDB _hourIrrigDB = HourIrrigDB();
  Future<List<IrrigHoursModel>> _hoursIrrig;
  List<IrrigHoursModel> _currentHoursI;
  CollectionReference prescIrrData =
      FirebaseFirestore.instance.collection('Tibasosa_3');
  @override
  void initState() {
    _hourTime = DateTime.now();
    _hourIrrigDB.initializeDatabase().then((value) {
      print('------database intialized');
      loadIrrigHours();
    });
    super.initState();
  }

  void loadIrrigHours() {
    _hoursIrrig = _hourIrrigDB.getAlarms();
    if (mounted) setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 32, vertical: 64),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          Text(
            'Irrigation Hours',
            style: TextStyle(
                fontFamily: 'avenir',
                fontWeight: FontWeight.w700,
                color: CustomColors.primaryTextColor,
                fontSize: 24),
          ),
          Expanded(
            child: FutureBuilder<List<IrrigHoursModel>>(
              future: _hoursIrrig,
              builder: (context, snapshot) {
                if (snapshot.hasData) {
                  _currentHoursI = snapshot.data;
                  return ListView(
                    children: snapshot.data.map<Widget>((alarm) {
                      var alarmTime = DateFormat('hh:mm aa')
                          .format(alarm.IrrigHourDateTime);
                      var gradientColor = GradientTemplate
                          .gradientTemplate[alarm.gradientColorIndex].colors;
                      return Container(
                        margin: const EdgeInsets.only(bottom: 32),
                        padding: const EdgeInsets.symmetric(
                            horizontal: 16, vertical: 8),
                        decoration: BoxDecoration(
                          gradient: LinearGradient(
                            colors: gradientColor,
                            begin: Alignment.centerLeft,
                            end: Alignment.centerRight,
                          ),
                          boxShadow: [
                            BoxShadow(
                              color: gradientColor.last.withOpacity(0.4),
                              blurRadius: 8,
                              spreadRadius: 2,
                              offset: Offset(4, 4),
                            ),
                          ],
                          borderRadius: BorderRadius.all(Radius.circular(24)),
                        ),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: <Widget>[
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: <Widget>[
                                Row(
                                  children: <Widget>[
                                    Icon(
                                      Icons.label,
                                      color: Colors.white,
                                      size: 24,
                                    ),
                                    SizedBox(width: 8),
                                    Text(
                                      alarm.title,
                                      style: TextStyle(
                                          color: Colors.white,
                                          fontFamily: 'avenir'),
                                    ),
                                  ],
                                ),
                                Switch(
                                  onChanged: (bool value) {
                                    print('change state');
                                  },
                                  value: true,
                                  activeColor: Colors.white,
                                ),
                              ],
                            ),
                            Text(
                              'Mon-Fri',
                              style: TextStyle(
                                  color: Colors.white, fontFamily: 'avenir'),
                            ),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: <Widget>[
                                Text(
                                  alarmTime,
                                  style: TextStyle(
                                      color: Colors.white,
                                      fontFamily: 'avenir',
                                      fontSize: 24,
                                      fontWeight: FontWeight.w700),
                                ),
                                IconButton(
                                    icon: Icon(Icons.delete),
                                    color: Colors.white,
                                    onPressed: () {
                                      deleteAlarm(alarm.id);
                                    }),
                              ],
                            ),
                          ],
                        ),
                      );
                    }).followedBy([
                      if (_currentHoursI.length < 2)
                        DottedBorder(
                          strokeWidth: 2,
                          color: CustomColors.clockOutline,
                          borderType: BorderType.RRect,
                          radius: Radius.circular(24),
                          dashPattern: [5, 4],
                          child: Container(
                            width: double.infinity,
                            decoration: BoxDecoration(
                              color: CustomColors.clockBG,
                              borderRadius:
                                  BorderRadius.all(Radius.circular(24)),
                            ),
                            // ignore: deprecated_member_use
                            child: FlatButton(
                              padding: const EdgeInsets.symmetric(
                                  horizontal: 32, vertical: 16),
                              onPressed: () {
                                _hourTimeString =
                                    DateFormat('HH:mm').format(DateTime.now());
                                showModalBottomSheet(
                                  useRootNavigator: true,
                                  context: context,
                                  clipBehavior: Clip.antiAlias,
                                  shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.vertical(
                                      top: Radius.circular(24),
                                    ),
                                  ),
                                  builder: (context) {
                                    return StatefulBuilder(
                                      builder: (context, setModalState) {
                                        return Center(
                                          child: Container(
                                            padding: const EdgeInsets.all(32),
                                            child: Column(
                                              children: [
                                                // ignore: deprecated_member_use
                                                FlatButton(
                                                  onPressed: () async {
                                                    var selectedTime =
                                                        await showTimePicker(
                                                      context: context,
                                                      initialTime:
                                                          TimeOfDay.now(),
                                                    );
                                                    if (selectedTime != null) {
                                                      final now =
                                                          DateTime.now();
                                                      var selectedDateTime =
                                                          DateTime(
                                                              now.year,
                                                              now.month,
                                                              now.day,
                                                              selectedTime.hour,
                                                              selectedTime
                                                                  .minute);
                                                      _hourTime =
                                                          selectedDateTime;
                                                      setModalState(() {
                                                        _hourTimeString =
                                                            DateFormat('HH:mm')
                                                                .format(
                                                                    selectedDateTime);
                                                      });
                                                    }
                                                  },
                                                  child: Text(
                                                    _hourTimeString,
                                                    style:
                                                        TextStyle(fontSize: 30),
                                                  ),
                                                ),

                                                FloatingActionButton.extended(
                                                  onPressed: onSaveAlarm,
                                                  icon: Icon(
                                                    Icons.alarm,
                                                    size: 20,
                                                  ),
                                                  label: Text(
                                                    'Save',
                                                    style:
                                                        TextStyle(fontSize: 20),
                                                  ),
                                                ),
                                                Expanded(
                                                  child: Image.asset(
                                                    'assets/img/irrig.png',
                                                    scale: 0.1,
                                                  ),
                                                ),
                                              ],
                                            ),
                                          ),
                                        );
                                      },
                                    );
                                  },
                                );
                                // scheduleAlarm();
                              },
                              child: Column(
                                children: <Widget>[
                                  Image.asset(
                                    'assets/img/add_alarm.png',
                                    scale: 1.5,
                                  ),
                                  SizedBox(height: 8),
                                  Text(
                                    'Add Alarm',
                                    style: TextStyle(
                                        color: Colors.white,
                                        fontFamily: 'avenir'),
                                  ),
                                ],
                              ),
                            ),
                          ),
                        )
                      else
                        Center(
                            child: Text(
                          'Only 2 Irrigation Hours  allowed!',
                          style: TextStyle(color: Colors.white),
                        )),
                    ]).toList(),
                  );
                }
                return Center(
                  child: Text(
                    'Loading..',
                    style: TextStyle(color: Colors.white),
                  ),
                );
              },
            ),
          ),
        ],
      ),
    );
  }

  void scheduleAlarm(DateTime scheduledNotificationDateTime,
      IrrigHoursModel IrrigHoursModel) async {
    var androidPlatformChannelSpecifics = AndroidNotificationDetails(
      'alarm_notif',
      'alarm_notif',
      'Channel for Alarm notification',
      icon: 'codex_logo',
      sound: RawResourceAndroidNotificationSound('a_long_cold_sting'),
      largeIcon: DrawableResourceAndroidBitmap('codex_logo'),
    );
    var iOSPlatformChannelSpecifics = IOSNotificationDetails(
        sound: 'a_long_cold_sting.wav',
        presentAlert: true,
        presentBadge: true,
        presentSound: true);
  }

  Future<void> updateData(variable, value) {
    return prescIrrData
        .doc('Irrigation-Prescription')
        .update({variable: value})
        .then((value) => print("User Updated"))
        .catchError((error) => print("Failed to update user: $error"));
  }

  void onSaveAlarm() {
    DateTime scheduleIrrigHourDateTime;
    if (_hourTime.isAfter(DateTime.now()))
      scheduleIrrigHourDateTime = _hourTime;
    else
      scheduleIrrigHourDateTime = _hourTime.add(Duration(days: 365));

    if (_currentHoursI.length % 2 == 1) {
      updateData('IrrigationTime_1', _hourTimeString);
    } else {
      updateData('IrrigationTime_2', _hourTimeString);
    }

    var irrigHoursModel = IrrigHoursModel(
      IrrigHourDateTime: scheduleIrrigHourDateTime,
      gradientColorIndex: _currentHoursI.length,
      title: 'Irr.Hour',
    );
    _hourIrrigDB.insertAlarm(irrigHoursModel);
    scheduleAlarm(scheduleIrrigHourDateTime, irrigHoursModel);
    Navigator.pop(context);
    loadIrrigHours();
  }

  void deleteAlarm(int id) {
    _hourIrrigDB.delete(id);
    //unsubscribe for notification
    loadIrrigHours();
  }
}
