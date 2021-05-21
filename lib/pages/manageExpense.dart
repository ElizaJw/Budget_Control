import 'package:flutter/material.dart';
import 'package:budget_control/pages/home_page.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:budget_control/Util/Utilities.dart';
import 'package:date_field/date_field.dart';
import 'package:budget_control/styles/styleForm.dart';
import 'package:budget_control/src/LogicBalance.dart';
import 'package:provider/provider.dart';

class Expenses extends StatefulWidget {
  @override
  State<StatefulWidget> createState() => PageCreateExpense();
}

class PageCreateExpense extends State<Expenses> {
  StyleForm style = new StyleForm();
  LogicBalance balan = new LogicBalance();
  var _valorGastado = "";
  var _descripcion = "";
  DateTime _fecha;
  var _firstValue = 'Seleccionar categoría';
  final _keyForm = GlobalKey<FormState>();

  Utilities util = new Utilities();
  List<String> categories = <String>[
    'Seleccionar categoría',
    'Ropa',
    'Estudios',
    'Entretenimiento',
    'Facturas'
  ];

  @override
  Widget build(BuildContext context) {
    LogicBalance logic = Provider.of<LogicBalance>(context, listen: false);
    double balance = logic.newValue;
    return Scaffold(
      backgroundColor: Color.fromRGBO(239, 240, 236, 3),
      body: SingleChildScrollView(child: _body(balance)),
    );
  }

  Widget _body(double balance) {
    return Column(
      children: <Widget>[
        util.btnReturn(context),
        _formExpense(balance),
      ],
    );
  }

  Widget _formExpense(double balance) {
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 10),
      child: Form(
        key: _keyForm,
        child: Column(children: <Widget>[
          style.SizeSpace(20.0),
          style.StyleTitle('Nuevo Gasto'),
          style.SizeSpace(20.0),
          TextFormField(
              controller: TextEditingController(text: _valorGastado.toString()),
              validator: (value) {
                if (value.isEmpty || null == value) {
                  return 'El valor no puede estar vacío.';
                }
              },
              decoration: style.StyleInput('Valor Gastado *',
                  'Ingresa cuánto gastaste', Icon(Icons.money_outlined)),
              keyboardType: TextInputType.number,
              onChanged: (String valor) async {
                _valorGastado = valor;
                print(
                    "El valor del campo [Valor Gastado] es: $_valorGastado ...");
              }),
          TextFormField(
              controller: TextEditingController(text: _descripcion.toString()),
              validator: (value) {
                if (value.isEmpty || null == value) {
                  return 'La descripción no puede estar vacía.';
                }
              },
              decoration: style.StyleInput('Descripción *',
                  '¿En qué consistió el gasto?', Icon(Icons.description)),
              keyboardType: TextInputType.text,
              onChanged: (String valor) async {
                _descripcion = valor;
                print("El valor del campo [Descripción] es: $_descripcion ...");
              }),
          DateTimeFormField(
              validator: (value) {
                if (value == null) {
                  return 'La fecha no puede estar vacía';
                }
              },
              decoration: style.StyleInput('Fecha *',
                  '¿Cuándo se hizo el gasto?', Icon(Icons.calendar_today)),
              initialValue: _fecha,
              onDateSelected: (DateTime value) {
                setState(() {
                  _fecha = value;
                });
              }),
          style.SizeSpace(15.0),
          //Falta realizar el ComboBox Dinamico.
          DropdownButtonFormField<String>(
            isExpanded: true,
            icon: Icon(Icons.arrow_downward),
            value: _firstValue,
            iconSize: 24,
            elevation: 16,
            style: TextStyle(color: Colors.black),
            items: categories.map<DropdownMenuItem<String>>((String value) {
              return DropdownMenuItem(value: value, child: Text(value));
            }).toList(),
            onChanged: (String value) {
              setState(() {
                _firstValue = value;
              });
            },
            validator: (value) {
              if (value.isEmpty || value == "Seleccionar categoría") {
                return 'Debe seleccionar una categoría.';
              }
            },
          ),
          style.SizeSpace(30.0),
          MaterialButton(
            minWidth: 150.0,
            height: 40.0,
            onPressed: () {
              if (_keyForm.currentState.validate()) {
                util.showWindowDialog(context,
                    titulo: "Datos Ingresados",
                    mensaje:
                        "Valor Gastado : $_valorGastado \nDescripción: $_descripcion \nFecha: $_fecha \nCategoría: $_firstValue",
                    boton: "Ok");
                _addExpense();
                balan.newBalance(
                    balance, double.parse(_valorGastado), "Egreso");
                print("valor a gastar $_valorGastado");
                //addBalance();
              }
            },
            color: Colors.lightBlue,
            child: Text('Registrar', style: TextStyle(color: Colors.black)),
          ),
        ]),
      ),
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
        .then((value) => util.showToast(context,
            mensaje: 'Datos adicionados con éxito', boton: 'Ok'))
        .catchError((error) =>
            util.showToast(context, mensaje: 'Error: $error', boton: 'Ok'));
  }
}
