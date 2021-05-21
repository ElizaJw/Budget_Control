import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class LogicBalance extends ChangeNotifier {
  double newValue = 0;
  void newBalance(double actualBalance, double value, tipoOperacion) async {
    if (tipoOperacion == "Ingreso") {
      newValue = actualBalance + value;
    } else if (tipoOperacion == "Egreso") {
      newValue = actualBalance - value;
    }
    notifyListeners();
  }
}
