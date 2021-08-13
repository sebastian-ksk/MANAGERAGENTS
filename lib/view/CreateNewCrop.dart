import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:managents/data/Firebase/FirebaseCreate.dart';
import 'package:managents/models/FirebaseModels/CropModel.dart';
import 'package:managents/models/FirebaseModels/IrrigationPropertiesModel.dart';
import 'package:managents/models/FirebaseModels/RegisterAgentModel.dart';
import 'package:managents/models/FirebaseModels/ResultPrescIrrModel.dart';
import 'package:managents/models/FirebaseModels/agentModel.dart';
import 'package:managents/models/FirebaseModels/irrigationPrescModel.dart';
import 'package:managents/models/authentication/user.dart';
import 'package:managents/util/colors.dart';
import 'package:managents/view/widgets/dialogs.dart';
import 'package:numberpicker/numberpicker.dart';
import 'dart:async';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'dart:convert';

class CreateNewCrop extends StatefulWidget {
  UserApp currentUser;
  CreateNewCrop({
    Key key,
    @required this.currentUser,
  });
  @override
  _CreateNewCropState createState() => _CreateNewCropState();
}

class _CreateNewCropState extends State<CreateNewCrop> {
  List<String> _pumStations = [
    'Tibasosa',
    'SanRafael',
    'Monquira',
    'Holanda',
    'Surba',
    'Pant.Vargas',
    'Ayalas',
    'Duitama',
    'Las  Vueltas',
    'Cuche',
    'Ministerio'
  ];
  String _pumStationSelect;

  List<String> _crops = [
    'Potato',
    'Maize',
    'Tomato',
    'Barley',
    'Wheat',
    'Quinoa',
    'Onion'
  ];
  String _crop;

  DateTime currentDate = DateTime.now();
  DateFormat formatter = DateFormat('dd/MM/yyyy');
  TextEditingController _numberPumpStation = new TextEditingController();
  TextEditingController _croppedarea = new TextEditingController();
  TextEditingController _efficiency = new TextEditingController();
  TextEditingController _nominalDischarge = new TextEditingController();
  TextEditingController _drippers = new TextEditingController();
  TextEditingController _pwp = new TextEditingController();
  TextEditingController _fieldCapacity = new TextEditingController();
  double _currentDoubleValue = 2.0;
  int _currentIntValue = 0;

  AgentModel agentToregister = AgentModel();
  @override
  final GlobalKey<State> _keyLoader = new GlobalKey<State>();
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        resizeToAvoidBottomInset: false,
        body: Column(
          children: <Widget>[
            Stack(
              children: <Widget>[
                Container(
                  height: MediaQuery.of(context).size.height * 1 / 7,
                  width: MediaQuery.of(context).size.width,
                  padding: EdgeInsets.only(
                      top: MediaQuery.of(context).padding.top + 10,
                      bottom: 25,
                      left: 30,
                      right: 30.0),
                  decoration: BoxDecoration(
                      gradient: LinearGradient(
                          begin: Alignment.topCenter,
                          end: Alignment.bottomCenter,
                          colors: [colorAzulApp, Color(0xff4e80f3)]),
                      borderRadius: BorderRadius.only(
                          bottomLeft: Radius.circular(30),
                          bottomRight: Radius.circular(30))),
                ),
                //APPBAR invisible
                Positioned(
                    child: AppBar(
                  title: Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Text(
                      'NEW AGENT/NEW CROP',
                      style: TextStyle(
                        color: Colors.white,
                        fontWeight: FontWeight.bold,
                        fontFamily: 'OpenSans',
                        fontSize: 20,
                      ),
                    ),
                  ),
                  backgroundColor: Colors.transparent,
                  elevation: 0,
                )),
              ],
            ),
            SizedBox(
              height: 10,
            ),
            Container(
              height: MediaQuery.of(context).size.height * 0.65,
              width: MediaQuery.of(context).size.width - 10,
              decoration: BoxDecoration(
                  gradient: LinearGradient(
                      begin: Alignment.topCenter,
                      end: Alignment.bottomCenter,
                      colors: [Color(0xff4e80f3), colorAzulApp]),
                  borderRadius: BorderRadius.all(Radius.circular(30))),
              child: ListView(
                children: <Widget>[
                  Center(
                    child: Text(
                      'CROP DATA',
                      style: TextStyle(
                        color: Colors.white,
                        fontWeight: FontWeight.bold,
                        fontFamily: 'OpenSans',
                        fontSize: 20,
                      ),
                    ),
                  ),
                  Row(
                    children: [
                      _downMenuList(
                          Icons.speed_rounded, 'STATION', _pumStations,
                          (value) {
                        setState(() {
                          _pumStationSelect = value;
                        });
                      }, _pumStationSelect),
                      _tesxtInputData(Icons.format_list_numbered, 'No.',
                          _numberPumpStation, ''),
                    ],
                  ),
                  SizedBox(height: 5),
                  Row(
                    children: [
                      _downMenuList(FontAwesomeIcons.seedling, 'CROP', _crops,
                          (value) {
                        setState(() {
                          _crop = value;
                        });
                      }, _crop),
                    ],
                  ),
                  Row(
                    children: [
                      Container(
                        padding: EdgeInsets.only(
                          left: 10,
                        ),
                        child: Icon(Icons.calendar_today,
                            color: Colors.amberAccent, size: 30),
                      ),
                      SizedBox(
                        width: 5,
                      ),
                      Container(
                        width: 240,
                        // ignore: deprecated_member_use
                        child: FlatButton(
                            color: Colors.white,
                            onPressed: () => _selectDate(context),
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(20.0),
                            ),
                            child: Text(
                              'SEED DATE: ' + formatter.format(currentDate),
                              style: TextStyle(
                                  color: Colors.black,
                                  fontSize: 16,
                                  fontWeight: FontWeight.w600),
                            )),
                      ),
                    ],
                  ),
                  _tesxtInputData(Icons.crop_3_2_outlined, 'CROPPED AREA',
                      _croppedarea, 'm²'),
                  SizedBox(height: 5),
                  _tesxtInputData(
                      Icons.check_circle, 'EFFICIENCY', _efficiency, '%'),
                  SizedBox(height: 5),
                  _tesxtInputData(FontAwesomeIcons.tachometerAlt,
                      'NOM DISCHARGE', _nominalDischarge, 'L/s'),
                  SizedBox(height: 5),
                  _tesxtInputData(FontAwesomeIcons.eyeDropper, 'NUM DRIPERS',
                      _drippers, 'U'),
                  SizedBox(height: 5),
                  _tesxtInputData(
                      FontAwesomeIcons.levelDownAlt, 'PWP %', _pwp, '%'),
                  SizedBox(height: 5),
                  _tesxtInputData(FontAwesomeIcons.levelUpAlt,
                      'FIELD CAPACITY %', _fieldCapacity, '%'),
                  SizedBox(height: 5),
                ],
              ),
            ),
            SizedBox(height: 20),
            _buildRegisterBtn(context),
          ],
        ),
      ),
    );
  }

//widgets

//=====================widget boton de registro=================================
  Widget _buildRegisterBtn(BuildContext context) {
    final GlobalKey<State> _keyLoader = new GlobalKey<State>();
    return Container(
      padding: EdgeInsets.symmetric(vertical: 5.0),
      width: 200,
      height: 70,

      // ignore: deprecated_member_use
      child: RaisedButton(
        elevation: 5.0,
        onPressed: () {
          // verificacion de campos Vacios
          if (_crop == null ||
              _pumStationSelect == null ||
              _numberPumpStation.text.isEmpty ||
              _croppedarea.text.isEmpty ||
              _efficiency.text.isEmpty ||
              _nominalDischarge.text.isEmpty ||
              _drippers.text.isEmpty ||
              _pwp.text.isEmpty ||
              _fieldCapacity.text.isEmpty) {
            Dialogs.dialogBox(context, 'Error! Campo vacio', _keyLoader);
          } else {
            _handleSubmit(context, _keyLoader);
          }
        },
        padding: EdgeInsets.all(15.0),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(10.0),
        ),
        color: colorAzulApp,
        child: Text(
          'REGISTRAR',
          style: TextStyle(
            color: Colors.white,
            fontWeight: FontWeight.bold,
            fontFamily: 'OpenSans',
            fontSize: 25,
          ),
        ),
      ),
    );
  }

  Future<void> _handleSubmit(
    BuildContext context,
    GlobalKey<State> _keyLoader,
  ) async {
    bool agentexist;
    bool agentcreate;
    bool agentcreateGeneral;
    String _agentToRegister =
        '${_pumStationSelect}_${_numberPumpStation.text.split('.')[0]}';
    String _nameUser = widget.currentUser.name;
    bool resultCreateCollection;
    print(_agentToRegister);
    agentexist = await FirebaseCreate().checkRegisterAgent(_agentToRegister);
    print('ok');

    if (agentexist) {
      Dialogs.dialogBox(
          context,
          "El dispositivo ${_pumStationSelect}_${_numberPumpStation.text.split('.')[0]} ya existe",
          _keyLoader);
    } else {
      print('create new agent in user list');
      agentcreateGeneral = await FirebaseCreate()
          .registerNameAgent('RegAgents', _agentToRegister);
      print('$agentcreateGeneral');

      agentcreate = await FirebaseCreate()
          .registerNameAgent('${_nameUser}', _agentToRegister);

      if (agentcreateGeneral && agentcreate) {
        print('create');

        agentToregister = AgentModel(
            crop: CropModel(
                daysCrop: 0,
                typeCrop: _crop.toString(),
                fieldCapacity: double.parse(_fieldCapacity.text),
                pwp: double.parse(_pwp.text),
                seedDate: formatter.format(currentDate)),
            irrigationProperties: IrrigationPModel(
                area: double.parse(_croppedarea.text),
                drippers: double.parse(_drippers.text),
                efficiency: double.parse(_efficiency.text),
                nominalDischarge: double.parse(_nominalDischarge.text)),
            irrigationPrescription: IrrPrescModel(
              irrigationMethod: 'drip',
              firstIrrigationTime: '--:--',
              secondIrrigationTime: '--:--',
              negotiation: 'true',
              prescriptionMethod: 'Better',
              prescriptionTime: '--:--',
              constanFlow: 0,
              manualValves: 'OFF',
            ),
            resultIrrigationPrescription: ResultPrescIrrModel(
                irrigationState: 'OFF',
                irrigationTime: 0,
                lastIrrigationDate: '-/-/-',
                lastPrescriptionDate: '-/-/-',
                netPrescription: 0,
                irrigationApplied: 0));
        try {
          Dialogs.showLoadingDialog(context, _keyLoader); //invoking login

          resultCreateCollection = await FirebaseCreate().createDataBase(
            '${_nameUser}.${_agentToRegister}',
            agentToregister,
          );
          Navigator.of(_keyLoader.currentContext, rootNavigator: true).pop();
          if (resultCreateCollection) {
            Dialogs.dialogBox(
                context,
                "El Agente ${_nameUser}.${_agentToRegister} fue creado}",
                _keyLoader);
            setState(() {
              _crop = null;
              _pumStationSelect = null;
              _numberPumpStation.clear();
              _croppedarea.clear();
              _efficiency.clear();
              _nominalDischarge.clear();
              _drippers.clear();
              _pwp.clear();
              _fieldCapacity.clear();
            });
          } else {
            Dialogs.dialogBox(context,
                "Error al crear ${_nameUser}.${_agentToRegister}", _keyLoader);
          }
        } catch (e) {
          print(e);
        }
      }
    }
  }

  Future<void> _selectDate(BuildContext context) async {
    final DateTime pickedDate = await showDatePicker(
        context: context,
        initialDate: currentDate,
        firstDate: DateTime(2015),
        lastDate: DateTime(2050));
    if (pickedDate != null && pickedDate != currentDate)
      setState(() {
        currentDate = pickedDate;
      });
  }

  Widget _tesxtInputData(IconData iconItem, String name,
      TextEditingController controltext, String units) {
    //widget para ingresar datos
    return Row(
      children: [
        //container de logo/icono
        Container(
          padding: EdgeInsets.only(
            left: 10,
          ),
          child: Align(
            alignment: Alignment.centerLeft,
            child: Icon(
              iconItem,
              color: Colors.amberAccent,
              size: 30,
            ),
          ),
        ),
        //espacio entre ambas
        SizedBox(
          width: 5,
        ),
        //box para ingreso de datos
        Container(
          width: name == 'No.' ? 80 : 240,
          height: 40,
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(30),
          ),
          child: Padding(
            padding: const EdgeInsets.only(left: 20, bottom: 20),
            child: TextFormField(
              controller: controltext,
              onChanged: (text) {
                name = text
                    .replaceAll('-', '')
                    .replaceAll(' ', '')
                    .replaceAll(',', '.');
              },
              onFieldSubmitted: (text) {
                var value;
                final newValue = text
                    .replaceAll('-', '')
                    .replaceAll(' ', '')
                    .replaceAll(',', '.');

                try {
                  value = double.parse(newValue);
                } on FormatException {
                  print('no es un numero');
                } finally {
                  print('si es un numero');
                  if (value > 100 && units == '%') {
                    value = 100.0;
                  }
                  setState(() {
                    name = value.toString();
                    controltext.text = value.toString();
                  });
                }
              },
              // ignore: deprecated_member_use
              autovalidate: true,
              keyboardType: TextInputType.number,
              style: TextStyle(
                  color: Colors.black,
                  fontSize: 16,
                  fontWeight: FontWeight.w600),
              decoration: InputDecoration(
                border: InputBorder.none,
                contentPadding: EdgeInsets.only(top: 14.0),
                hintText: name,
              ),
            ),
          ),
        ),
        SizedBox(
          width: 5,
        ),
        Container(
          width: name == 'No.' ? 0 : 40,
          height: 40,
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(10),
          ),
          child: Center(
            child: Text(
              units,
              style: TextStyle(
                  color: Colors.black,
                  fontSize: 16,
                  fontWeight: FontWeight.w600),
            ),
          ),
        )
      ],
    );
  }

//=======================widget lista desplegable=============================
  Widget _downMenuList(IconData iconItem, String name, List<String> menu,
      Function onChange, String valued) {
    return Center(
      child: Row(
        children: [
          Container(
            padding: EdgeInsets.only(
              left: 10,
            ),
            child: Icon(iconItem, color: Colors.amberAccent, size: 30),
          ),
          SizedBox(
            width: 5,
          ),
          Container(
            width: name != 'CROP' ? 150 : 240,
            height: 40,
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(30),
            ),
            child: Padding(
              padding: const EdgeInsets.only(left: 20, right: 10),
              child: DropdownButton<String>(
                value: valued,
                isExpanded: true,
                style: TextStyle(color: Colors.black),
                items: menu.map<DropdownMenuItem<String>>((String value) {
                  return DropdownMenuItem<String>(
                    value: value,
                    child: Text(value,
                        style: TextStyle(
                            color: Colors.black,
                            fontSize: 16,
                            fontWeight: FontWeight.w600)),
                  );
                }).toList(),
                hint: Text(
                  name,
                  style: TextStyle(
                      color: Colors.black,
                      fontSize: 16,
                      fontWeight: FontWeight.w600),
                ),
                onChanged: onChange,
              ),
            ),
          ),
        ],
      ),
    );
  }

//para usar despues
//=================widget para number Piker =====================
  Future<void> _showIntegerDialog(
      BuildContext context, double currentDoubleValue) async {
    double doubleVal = currentDoubleValue;
    await showDialog(
      barrierDismissible: false,
      useSafeArea: true,
      context: context,
      builder: (context) {
        return StatefulBuilder(
          builder: (context, setState) {
            return AlertDialog(
              title: Text(
                'Efficiency',
                style: TextStyle(
                  color: Colors.black54,
                  fontSize: 15,
                ),
              ),
              content: DecimalNumberPicker(
                value: currentDoubleValue,
                minValue: 0,
                maxValue: 10,
                decimalPlaces: 2,
                onChanged: (value) => setState(() {
                  doubleVal = value;
                  currentDoubleValue = value;
                }),
              ),
              actions: <Widget>[
                // ignore: deprecated_member_use
                FlatButton(
                  onPressed: () {
                    setState(() {
                      currentDoubleValue = doubleVal;
                    });

                    Navigator.pop(context);
                  },
                  child: Text('OK'),
                ),
                // ignore: deprecated_member_use
                FlatButton(
                  onPressed: () => Navigator.pop(context),
                  child: Text('Cancel'),
                ),
              ],
            );
          },
        );
      },
    );
  }
}
