import 'package:flutter/material.dart';
import 'package:budget_control/pages/home_page.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class Expenses extends StatefulWidget {
  @override
  State<StatefulWidget> createState() => PageCreateExpense();
}

class PageCreateExpense extends State<Expenses> {
  var _valorGastado = "";
  var _descripcion = "";
  var _fecha = "";

  String _firstValue = 'Seleccionar categoría';

  List<String> categories = <String>[
    'Seleccionar categoría',
    'Ropa',
    'Estudios',
    'Entretenimiento',
    'Facturas'
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color.fromRGBO(239, 240, 236, 3),
      body: SingleChildScrollView(child: _body()),
    );
  }

  Widget _body() {
    return Column(
      //mainAxisAlignment: MainAxisAlignment.spaceEvenly,
      children: <Widget>[
        _btnReturn(),
        _formExpense(),
      ],
    );
  }

  Widget _btnReturn() {
    return Container(
        alignment: Alignment.bottomLeft,
        padding: EdgeInsets.all(15),
        child: FloatingActionButton(
          onPressed: () {
            //Volver ir a la pantalla especificada
            Navigator.of(context)
                .push(MaterialPageRoute(builder: (context) => HomePage()));
          },
          backgroundColor: Colors.blueGrey,
          child: Icon(Icons.keyboard_backspace),
        ));
  }

  Widget _formExpense() {
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 10),
      child: Column(children: <Widget>[
        SizedBox(
          height: 20.0,
        ),
        Text(
          "Nuevo Gasto",
          textAlign: TextAlign.center,
          style: TextStyle(
              color: Colors.blue, fontSize: 20.0, fontStyle: FontStyle.normal),
        ),
        SizedBox(
          height: 20.0,
        ),
        TextFormField(
            controller: TextEditingController(text: _valorGastado.toString()),
            decoration: const InputDecoration(
              border: UnderlineInputBorder(),
              filled: true,
              icon: Icon(Icons.money_outlined),
              hintText: '¿Cuánto gastaste?',
              labelText: 'Valor Gastado *',
            ),
            keyboardType: TextInputType.number,
            onChanged: (String valor) async {
              _valorGastado = valor;
              print(
                  "el valor del campo [Valor Gastado] es: $_valorGastado ...");
            }),
        TextFormField(
            controller: TextEditingController(text: _descripcion.toString()),
            decoration: const InputDecoration(
              border: UnderlineInputBorder(),
              filled: true,
              icon: Icon(Icons.description),
              labelText: 'Descripción *',
            ),
            keyboardType: TextInputType.text,
            onChanged: (String valor) async {
              _descripcion = valor;
              print("el valor del campo [Descripción] es: $_descripcion ...");
            }),
        TextFormField(
            controller: TextEditingController(text: _fecha.toString()),
            decoration: const InputDecoration(
              border: UnderlineInputBorder(),
              filled: true,
              icon: Icon(Icons.calendar_today),
              hintText: '¿Cuándo fue eso?',
              labelText: 'Fecha *',
            ),
            keyboardType: TextInputType.datetime,
            onChanged: (String valor) async {
              _fecha = valor;
              print("el valor del campo [Fecha] es: $_fecha ...");
            }),
        SizedBox(
          height: 15.0,
        ),
        DropdownButton<String>(
          isExpanded: true,
          icon: Icon(Icons.arrow_downward),
          value: _firstValue,
          iconSize: 24,
          elevation: 16,
          style: TextStyle(color: Colors.black),
          underline: Container(
            height: 1,
            color: Colors.blue,
          ),
          items: categories.map<DropdownMenuItem<String>>((String value) {
            return DropdownMenuItem(value: value, child: Text(value));
          }).toList(),
          onChanged: (String value) {
            setState(() {
              _firstValue = value;
            });
          },
        ),
        SizedBox(
          height: 30.0,
        ),
        MaterialButton(
          minWidth: 150.0,
          height: 40.0,
          onPressed: () {
            _addExpense();
            _verVentanaDialogo(
              titulo: "Datos Ingresados",
              mensaje:
                  "Valor Gastado : $_valorGastado \nDescripción: $_descripcion \nFecha: $_fecha \nCategoría: $_firstValue",
              boton: "Ok",
            );
          },
          color: Colors.lightBlue,
          child: Text('Registrar', style: TextStyle(color: Colors.black)),
        ),
      ]),
    );
  }

  Future<void> _addExpense() {
    CollectionReference coleccion =
        FirebaseFirestore.instance.collection('Expense');
    return coleccion
        .add({
          'valorGastado': this._valorGastado,
          'descripcion': this._descripcion,
          'fecha': this._fecha,
          'categoria': this._firstValue
        })
        .then((value) => _verToast(context,
            mensaje: 'Datos adicionados con éxito', boton: 'Ok'))
        .catchError((error) =>
            _verToast(context, mensaje: 'Error: $error', boton: 'Ok'));
  }

  void _verToast(BuildContext context,
      {mensaje = 'Accion Ok', boton = 'Action'}) {
    final scaffold = Scaffold.of(context);
    scaffold.showSnackBar(
      SnackBar(
        content: Text(mensaje),
        action: SnackBarAction(
            label: boton, onPressed: scaffold.hideCurrentSnackBar),
      ),
    );
  }

  void getDropDownItem() {
    setState(() {
      _holder = _firstValue;
    });
  }

  void _verVentanaDialogo({titulo, mensaje, boton}) {
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
                  style: TextStyle(color: Colors.blue),
                ),
                onPressed: () {
                  Navigator.of(context).pop();
                },
              )
            ],
          );
        });
  }
}
