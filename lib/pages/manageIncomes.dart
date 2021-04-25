import 'package:flutter/material.dart';
import 'package:budget_control/pages/home_page.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:date_field/date_field.dart';
import 'package:budget_control/Util/Utilities.dart';

class Incomes extends StatefulWidget {
  @override
  State<StatefulWidget> createState() => PageCreateIncome();
}

class PageCreateIncome extends State<Incomes> {
  Utilities util = new Utilities();
  var _valorIngresado = "";
  var _descripcion = "";
  //var _fecha = "";
  var _firstValue = 'Seleccionar tipo ingreso';
  DateTime _fecha;

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
            onChanged: (String valor) async {
              _valorIngresado = valor;
              print(
                  "el valor del campo [Valor Ingresado] es: $_valorIngresado ...");
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
        DateTimeField(
            decoration: const InputDecoration(
              border: UnderlineInputBorder(),
              filled: true,
              icon: Icon(Icons.calendar_today),
              hintText: '¿Cuándo fue eso?',
              labelText: 'Fecha *',
            ),
            selectedDate: _fecha,
            onDateSelected: (DateTime value) {
              setState(() {
                _fecha = value;
              });
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
            util.verVentanaDialogo(
              context,
              titulo: "Datos Ingresados",
              mensaje:
                  "Valor Gastado : $_valorIngresado \nDescripción: $_descripcion \nFecha: $_fecha \nCategoría: $_firstValue",
              boton: "Ok",
            );
            _addIncome();
          },
          color: Colors.lightBlue,
          child: Text('Registrar', style: TextStyle(color: Colors.black)),
        ),
      ]),
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
        .then((value) => util.verToast(context,
            mensaje: 'Datos registrados con éxito', boton: 'Ok'))
        .catchError((error) =>
            util.verToast(context, mensaje: 'Error: $error', boton: 'Ok'));
  }
}
