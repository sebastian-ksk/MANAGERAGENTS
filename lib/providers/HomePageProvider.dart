import 'package:flutter/material.dart';

class HomePageProvider with ChangeNotifier {
  String irrigation;
  String prescription;
  String vwc;
  String crop;
  List<String> listAgents = [];
  String actualAgentUser;

  get actualAgen {
    return actualAgentUser;
  }

  set actualAgen(String agent) {
    this.actualAgentUser = agent;
    notifyListeners();
  }

  get listAgentUser {
    return listAgents;
  }

  set listAgentUser(List<String> agents) {
    this.listAgents = agents;
    notifyListeners();
  }

  get irrigationApplied {
    return irrigation;
  }

  set irrigationApplied(String option) {
    this.irrigation = option;
    notifyListeners();
  }

/*-------------------------- */
  get prescriptionApplied {
    return prescription;
  }

  set prescriptionApplied(String option) {
    this.prescription = option;
    notifyListeners();
  }

  get vwcCrop {
    return vwc;
  }

  set vwcCrop(String option) {
    this.vwc = option;
    notifyListeners();
  }

  get typeCrop {
    return crop;
  }

  set typeCrop(String option) {
    this.crop = option;
    notifyListeners();
  }
}
