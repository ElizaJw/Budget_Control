import 'package:flutter/material.dart';
import 'package:budget_control/pages/home_page.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class Incomes extends StatefulWidget {
  @override
  State<StatefulWidget> createState() => PageCreateIncome();
}

class PageCreateIncome extends State<Incomes> {
  var _valorIngresado = "";
  var _descripcion = "";
  var _fecha = "";
  var _holder = '';

  String _firstValue = 'Seleccionar tipo ingreso';

  List<String> typeIncomes = <String>[
    'Seleccionar tipo ingreso',
    'Trasnferencia',
    'Efectivo',
    'Nequi',
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
        _formIncome(),
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

  Widget _formIncome() {
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 10),
      child: Column(children: <Widget>[
        SizedBox(
          height: 20.0,
        ),
        Text(
          "Nuevo Ingreso",
          textAlign: TextAlign.center,
          style: TextStyle(
              color: Colors.blue, fontSize: 20.0, fontStyle: FontStyle.normal),
        ),
        SizedBox(
          height: 20.0,
        ),
        TextFormField(
            controller: TextEditingController(text: _valorIngresado.toString()),
            decoration: const InputDecoration(
              border: UnderlineInputBorder(),
              filled: true,
              icon: Icon(Icons.money_outlined),
              hintText: '¿Cuánto ingresaste?',
              labelText: 'Valor Ingresado *',
            ),
            keyboardType: TextInputType.number,
            onFieldSubmitted: (String valor) async {
              _valorIngresado = valor;
              print(
                  "el valor del campo [Valor Gastado] es: $_valorIngresado ...");
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
            onFieldSubmitted: (String valor) async {
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
            onFieldSubmitted: (String valor) async {
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
            items: typeIncomes.map<DropdownMenuItem<String>>((String value) {
              return DropdownMenuItem(value: value, child: Text(value));
            }).toList(),
            onChanged: (String value) {
              setState(() {
                _firstValue = value;
              });
            }),
        SizedBox(
          height: 30.0,
        ),
        MaterialButton(
          minWidth: 150.0,
          height: 40.0,
          onPressed: () {
            _addExpense();
            /*  _verVentanaDialogo(
              titulo: "Datos Ingresados",
              mensaje:
                  "Valor Gastado : $_valorIngresado \nDescripción: $_descripcion \nFecha: $_fecha \nCategoría: $_holder",
              boton: "Ok",
            );*/
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
          'valorGastado': this._valorIngresado,
          'descripcion': this._descripcion,
          'fecha': this._fecha,
          'categoria': this._holder
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
