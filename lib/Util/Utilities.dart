import 'package:budget_control/pages/home_page.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';

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

  void toastError(String msg) {
    Fluttertoast.showToast(
      msg: msg,
      toastLength: Toast.LENGTH_SHORT,
      gravity: ToastGravity.BOTTOM,
      timeInSecForIosWeb: 1,
      backgroundColor: Colors.red,
      textColor: Colors.white,
      fontSize: 16.0,
    );
  }

  @override
  Widget btnReturn(BuildContext context) {
    return Container(
        alignment: Alignment.bottomLeft,
        padding: EdgeInsets.all(15),
        child: FloatingActionButton(
          onPressed: () {
            //Go back to the specified screen
            Navigator.of(context)
                .push(MaterialPageRoute(builder: (context) => HomePage()));
          },
          backgroundColor: Colors.blueGrey,
          child: Icon(Icons.keyboard_backspace),
        ));
  }
}
