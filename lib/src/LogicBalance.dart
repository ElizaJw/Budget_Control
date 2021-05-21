import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

double value;

void newBalance(double actualBalance, double value, tipoOperacion) {
  double newValue;
  if (tipoOperacion == "Ingreso") {
    newValue = actualBalance + value;
  } else if (tipoOperacion == "Egreso") {
    newValue = actualBalance - value;
  }
  value = newValue;
  addBalance();
  print("valor calculado $value");
}

Future<void> addBalance() {
  CollectionReference coleccion =
      FirebaseFirestore.instance.collection('Balance');
  return coleccion.add({
    'valorGastado': value,
  });
}
