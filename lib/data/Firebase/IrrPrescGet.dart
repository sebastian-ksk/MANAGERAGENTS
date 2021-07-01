import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:managents/models/FirebaseModels/ResultPrescIrrModel.dart';
import 'package:managents/models/FirebaseModels/irrigationPrescModel.dart';

class GetFirebaseIrrPresc {
  FirebaseFirestore firestore = FirebaseFirestore.instance;

  ResultPrescIrrModel presultIrrpresmodel;

  Future<IrrPrescModel> ConsultIrrPresc() async {
    DocumentSnapshot data = null;
    data = await FirebaseFirestore.instance
        .collection('Tibasosa_3')
        .doc('Irrigation-Prescription')
        .get();
    if (data.exists) {
      return IrrPrescModel.fromJson(data.data());
    }
  }

  Future<ResultPrescIrrModel> ConsultResultIrrPresc() async {
    ResultPrescIrrModel resultIrrpresmodel;
    DocumentSnapshot data = null;
    data = await FirebaseFirestore.instance
        .collection('Tibasosa_3')
        .doc('ResultIrrigation-Prescription')
        .get();
    if (data.exists) {
      return ResultPrescIrrModel.fromJson(data.data());
    }
  }
}
