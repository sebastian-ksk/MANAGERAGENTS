import 'package:dotted_border/dotted_border.dart';
import 'package:flutter/material.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:intl/intl.dart';
import 'package:managents/data/sql/preschoursdb.dart';
import 'package:managents/models/PrescHoursModel.dart';
import 'package:managents/util/constans/theme_data.dart';

class PrescriptionHoursEdit extends StatefulWidget {
  @override
  _PrescriptionHoursEditState createState() => _PrescriptionHoursEditState();
}

class _PrescriptionHoursEditState extends State<PrescriptionHoursEdit> {
  DateTime _hourTime;
  String _hourTimeString;
  HourPrescDB _hourPrescDB = HourPrescDB();
  Future<List<PrescHoursModel>> _hoursIrrig;
  List<PrescHoursModel> _currentHoursI;

  @override
  void initState() {
    _hourTime = DateTime.now();
    _hourPrescDB.initializeDatabase().then((value) {
      print('------database intialized');
      loadPrescHours();
    });
    super.initState();
  }

  void loadPrescHours() {
    _hoursIrrig = _hourPrescDB.getHoursPresc();
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
            child: FutureBuilder<List<PrescHoursModel>>(
              future: _hoursIrrig,
              builder: (context, snapshot) {
                if (snapshot.hasData) {
                  _currentHoursI = snapshot.data;
                  return ListView(
                    children: snapshot.data.map<Widget>((alarm) {
                      var alarmTime = DateFormat('hh:mm aa')
                          .format(alarm.PrescHourDateTime);
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
                      if (_currentHoursI.length < 1)
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
                          'Only 1 Prescription Hour allowed!',
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
      PrescHoursModel PrescHoursModel) async {
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
    // var platformChannelSpecifics = NotificationDetails(
    //     androidPlatformChannelSpecifics, iOSPlatformChannelSpecifics);

    // await flutterLocalNotificationsPlugin.schedule(0, 'Office', PrescHoursModel.title,
    //     scheduledNotificationDateTime, platformChannelSpecifics);
  }

  Widget _cropProperties(idgradient, title, subtitle) {
    var gradientColor = GradientTemplate.gradientTemplate[idgradient].colors;
    return Container(
      margin: const EdgeInsets.only(bottom: 10),
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
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
                offset: Offset(4, 4))
          ],
          borderRadius: BorderRadius.all(Radius.circular(25))),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          Row(children: <Widget>[
            Icon(
              Icons.label,
              color: Colors.white,
              size: 24,
            ),
            SizedBox(width: 8),
            _textToInfo(title)
          ]),
          Row(mainAxisAlignment: MainAxisAlignment.center, children: <Widget>[
            _textToInfo(subtitle),
          ]),
        ],
      ),
    );
  }

  Widget _textToInfo(String message) {
    return Text(
      message,
      style: TextStyle(
          fontFamily: 'avenir',
          fontWeight: FontWeight.w700,
          color: CustomColors.primaryTextColor,
          fontSize: 15),
    );
  }

  void onSaveAlarm() {
    DateTime schedulePrescHourDateTime;
    if (_hourTime.isAfter(DateTime.now()))
      schedulePrescHourDateTime = _hourTime;
    else
      schedulePrescHourDateTime = _hourTime.add(Duration(days: 1));

    var prescHoursModel = PrescHoursModel(
      PrescHourDateTime: schedulePrescHourDateTime,
      gradientColorIndex: _currentHoursI.length,
      title: 'Irr.Hour',
    );
    _hourPrescDB.insertAlarm(prescHoursModel);
    scheduleAlarm(schedulePrescHourDateTime, prescHoursModel);
    Navigator.pop(context);
    loadPrescHours();
  }

  void deleteAlarm(int id) {
    _hourPrescDB.delete(id);
    //unsubscribe for notification
    loadPrescHours();
  }
}
