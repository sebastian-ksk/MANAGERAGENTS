import 'dart:convert';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:managents/models/FirebaseModels/CropModel.dart';
import 'package:managents/models/FirebaseModels/IrrigationPropertiesModel.dart';
import 'package:managents/models/FirebaseModels/RegisterAgentModel.dart';
import 'package:managents/models/FirebaseModels/ResultPrescIrrModel.dart';
import 'package:managents/models/FirebaseModels/agentModel.dart';
import 'package:managents/models/FirebaseModels/irrigationPrescModel.dart';

class ConsultFirebaseHomePage {
  FirebaseFirestore firestore = FirebaseFirestore.instance;

  Future<List<String>> consultAgentsuser(String username) async {
    QuerySnapshot registeredAgents;
    print('buscando');
    List<String> allAgents = [];
    registeredAgents =
        await FirebaseFirestore.instance.collection(username).get();
    print(' existe: ${registeredAgents.size}');

    for (int i = 0; i < registeredAgents.docs.length; i++) {
      var a = registeredAgents.docs[i];
      allAgents.add('${a.id}');
    }
    print(allAgents);
    return allAgents;
  }

  Future<AgentModel> consultMode(String nameAgent) async {
    CollectionReference _collectionRef =
        FirebaseFirestore.instance.collection(nameAgent);

    print('buscando');
    AgentModel agentmodel = AgentModel();
    QuerySnapshot querySnapshot = await _collectionRef.get();

    final allData = querySnapshot.docs.map((doc) => doc.data()).toList();
    print('decode ');

    agentmodel = AgentModel(
        crop: CropModel.fromJson(allData[0]),
        irrigationPrescription: IrrPrescModel.fromJson(allData[1]),
        irrigationProperties: IrrigationPModel.fromJson(allData[2]),
        resultIrrigationPrescription: ResultPrescIrrModel.fromJson(allData[3]));

    return agentmodel;
  }
}
