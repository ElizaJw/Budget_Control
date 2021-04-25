import 'package:flutter/material.dart';

class Utilities {
  Utilities();
  void showWindowDialog(BuildContext context, {titulo, mensaje, boton}) {
    showDialog(
        context: context,
        barrierDismissible: false,
        builder: (buildcontext) {
          return AlertDialog(
            title: Text(titulo),
            content: Text(mensaje),
            actions: <Widget>[
              RaisedButton(
                child: Text(
                  boton,
                  style: TextStyle(color: Colors.blueAccent),
                ),
                onPressed: () {
                  Navigator.of(context).pop();
                },
              )
            ],
          );
        });
  }

  void showToast(BuildContext context,
      {mensaje = 'Accion Ok', boton = 'Action'}) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text(mensaje),
        action: SnackBarAction(
            label: boton,
            onPressed: ScaffoldMessenger.of(context).hideCurrentSnackBar),
      ),
    );
  }
}
