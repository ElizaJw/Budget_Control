import 'dart:async';
import 'package:flutter/material.dart';
import 'package:budget_control/pages/home_page.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:date_field/date_field.dart';
import 'package:budget_control/Util/Utilities.dart';
import 'package:budget_control/styles/styleForm.dart';

class Incomes extends StatefulWidget {
  @override
  State<StatefulWidget> createState() => PageCreateIncome();
}

class PageCreateIncome extends State<Incomes> {
  Utilities util = new Utilities();
  StyleForm style = new StyleForm();
  var _valorIngresado = "";
  var _descripcion = "";
  //var _fecha = "";
  var _firstValue = 'Seleccionar tipo ingreso';
  DateTime _fecha;
  final _keyForm = GlobalKey<FormState>();

  //String _firstValue = 'Seleccionar tipo ingreso';

  List<String> typeIncomes = <String>[
    'Seleccionar tipo ingreso',
    'Trasnferencia',
    'Efectivo',
    'Nequi'
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
      child: Form(
        key: _keyForm,
        child: Column(children: <Widget>[
          style.SizeSpace(20.0),
          style.StyleTitle('Nuevo Ingreso'),
          style.SizeSpace(20.0),
          TextFormField(
              controller:
                  TextEditingController(text: _valorIngresado.toString()),
              validator: (value) {
                if (value.isEmpty || null == value) {
                  return 'El valor no puede estar vacío.';
                }
              },
              decoration: style.StyleInput('Valor Ingresado *',
                  'Ingresa cuánto recibiste', Icon(Icons.money_outlined)),
              keyboardType: TextInputType.number,
              onChanged: (String valor) async {
                _valorIngresado = valor;
                print(
                    "el valor del campo [Valor Ingresado] es: $_valorIngresado ...");
              }),
          TextFormField(
              controller: TextEditingController(text: _descripcion.toString()),
              validator: (value) {
                if (value.isEmpty || value == "Seleccionar categoría") {
                  return 'La descripción no puede estar vacía';
                }
              },
              decoration: style.StyleInput('Descripción *',
                  '¿En qué consistió el ingreso?', Icon(Icons.description)),
              keyboardType: TextInputType.text,
              onChanged: (String valor) async {
                _descripcion = valor;
                print("el valor del campo [Descripción] es: $_descripcion ...");
              }),
          DateTimeFormField(
            validator: (value) {
              if (value == null) {
                return 'La fecha no puede estar vacía';
              }
            },
            decoration: style.StyleInput('Fecha *',
                '¿Cuándo se recibió el ingreso?', Icon(Icons.calendar_today)),
            firstDate: _fecha,
            onDateSelected: (DateTime value) {
              setState(() {
                _fecha = value;
              });
            },
          ),
          style.SizeSpace(15.0),
          DropdownButtonFormField<String>(
            isExpanded: true,
            icon: Icon(Icons.arrow_downward),
            value: _firstValue,
            iconSize: 24,
            elevation: 16,
            style: TextStyle(color: Colors.black),
            items: typeIncomes.map<DropdownMenuItem<String>>((String value) {
              return DropdownMenuItem(value: value, child: Text(value));
            }).toList(),
            onChanged: (String value) {
              setState(() {
                _firstValue = value;
              });
            },
            validator: (value) {
              if (value.isEmpty || value == "Seleccionar tipo ingreso") {
                return 'Debe seleccionar un tipo de ingreso.';
              }
            },
          ),
          style.SizeSpace(30.0),
          MaterialButton(
            minWidth: 150.0,
            height: 40.0,
            onPressed: () {
              if (_keyForm.currentState.validate()) {
                util.showWindowDialog(
                  context,
                  titulo: "Datos Ingresados",
                  mensaje:
                      "Valor Gastado : $_valorIngresado \nDescripción: $_descripcion \nFecha: $_fecha \nCategoría: $_firstValue",
                  boton: "Ok",
                );
                _addIncome();
              }
            },
            color: Colors.lightBlue,
            child: Text('Registrar', style: TextStyle(color: Colors.black)),
          ),
        ]),
      ),
    );
  }

  Future<void> _addIncome() {
    CollectionReference coleccion =
        FirebaseFirestore.instance.collection('Income');
    return coleccion
        .add({
          'valorIngresado': this._valorIngresado,
          'descripcion': this._descripcion,
          'fecha': this._fecha,
          'tipoIngreso': this._firstValue
        })
        .then((value) => util.showToast(context,
            mensaje: 'Datos registrados con éxito', boton: 'Ok'))
        .catchError((error) =>
            util.showToast(context, mensaje: 'Error: $error', boton: 'Ok'));
  }

  /*bool _validateButton() {
    if (_valorIngresado.isEmpty) {
      util.toastError('Debe agregar un valor');
      return false;
    } else if (_descripcion.isEmpty) {
      util.toastError('Debe agregar una descripción');
      return false;
    } else if (_fecha == null) {
      util.toastError('Debe agregar una fecha');
      return false;
    } else if (_firstValue == 'Seleccionar tipo ingreso') {
      util.toastError('Debe agregar un tipo de ingreso');
      return false;
    }
  }*/
}
