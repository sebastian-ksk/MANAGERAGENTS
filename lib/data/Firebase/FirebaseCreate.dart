import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:managents/models/FirebaseModels/RegisterAgentModel.dart';
import 'package:managents/models/FirebaseModels/agentModel.dart';

class FirebaseCreate {
  FirebaseFirestore firestore = FirebaseFirestore.instance;

  Future<bool> checkRegisterAgent(String agent) async {
    DocumentSnapshot agentReg;
    print('buscando');
    print('${agent}');
    agentReg = await FirebaseFirestore.instance
        .collection('RegAgents')
        .doc(agent)
        .get();

    print(' existe: ${agentReg.exists}');
    if (agentReg.exists) {
      print('el agente ya existe');
      return true;
    } else {
      print('el agente no  existe ');
      return false;
    }
  }

  Future<bool> registerNameAgent(String user, String agent) async {
    CollectionReference agentReg = FirebaseFirestore.instance.collection(user);
    bool deviceRegister;
    await agentReg.doc(agent).set({}).then((value) {
      print("Agent Added");
      deviceRegister = true;
    }).catchError((error) {
      print("Failed to add Agent: $error");
      deviceRegister = false;
    });
    return deviceRegister;
  }

  Future<bool> createDataBase(String nameAgent, AgentModel parameters) async {
    CollectionReference refCollection =
        FirebaseFirestore.instance.collection(nameAgent);
    bool collectionCrop;
    bool collectionParameters;

    await refCollection.doc('Crop').set(parameters.crop.toJson()).then((value) {
      print("Agent Added");
      collectionCrop = true;
    }).catchError((error) {
      print("Failed to add Agent: $error");
      collectionCrop = false;
    });

    await refCollection
        .doc('Irrigation-Properties')
        .set(parameters.irrigationProperties.toJson())
        .then((value) {
      print("Agent Added");
      collectionParameters = true;
    }).catchError((error) {
      print("Failed to add Agent: $error");
      collectionParameters = false;
    });

    await refCollection
        .doc('Irrigation-Prescription')
        .set(parameters.irrigationPrescription.toJson())
        .then((value) {
      print("Agent Added");
      collectionParameters = true;
    }).catchError((error) {
      print("Failed to add Agent: $error");
      collectionParameters = false;
    });

    await refCollection
        .doc('ResultIrrigation-Prescription')
        .set(parameters.resultIrrigationPrescription.toJson())
        .then((value) {
      print("Agent Added");
      collectionParameters = true;
    }).catchError((error) {
      print("Failed to add Agent: $error");
      collectionParameters = false;
    });

    await refCollection.doc('Sensors').set({}).then((value) {
      print("Agent Added");
      collectionParameters = true;
    }).catchError((error) {
      print("Failed to add Agent: $error");
      collectionParameters = false;
    });

    return collectionCrop && collectionParameters;
  }
}
