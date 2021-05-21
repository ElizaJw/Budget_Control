import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

Future<void> newBalance(
    double actualBalance, double value, tipoOperacion) async {
  CollectionReference coleccion =
      FirebaseFirestore.instance.collection('Balance');
  double newValue;
  if (tipoOperacion == "Ingreso") {
    newValue = actualBalance + value;
  } else if (tipoOperacion == "Egreso") {
    newValue = actualBalance - value;
  }
  return await coleccion.add({
    'newBalance': newValue,
  });
}
