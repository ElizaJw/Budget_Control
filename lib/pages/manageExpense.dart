import 'package:flutter/material.dart';

class Expenses extends StatefulWidget {
  @override
  State<StatefulWidget> createState() => PageCreateExpense();
}

class PageCreateExpense extends State<Expenses> {
  String firstValue = 'Seleccionar categoría';

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
      body: _body(),
      //bottomNavigationBar: _menu(),
    );
  }

  Widget _body() {
    return Column(
      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
      children: <Widget>[_formExpense(), _btnSave()],
    );
  }

  Widget _formExpense() {
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 10),
      margin: EdgeInsets.symmetric(vertical: 10),
      child: Column(children: <Widget>[
        TextFormField(
          decoration: const InputDecoration(
            border: UnderlineInputBorder(),
            filled: true,
            icon: Icon(Icons.money_outlined),
            hintText: '¿Cuánto gastaste?',
            labelText: 'Valor Gastado *',
          ),
          keyboardType: TextInputType.number,
        ),
        TextFormField(
          decoration: const InputDecoration(
            border: UnderlineInputBorder(),
            filled: true,
            icon: Icon(Icons.description),
            hintText: '¿En qué te lo gastaste?',
            labelText: 'Descripción *',
          ),
          keyboardType: TextInputType.text,
        ),
        TextFormField(
          decoration: const InputDecoration(
            border: UnderlineInputBorder(),
            filled: true,
            icon: Icon(Icons.calendar_today),
            hintText: '¿Cuándo fue eso?',
            labelText: 'Fecha *',
          ),
          keyboardType: TextInputType.datetime,
        ),
        DropdownButton<String>(
          icon: Icon(Icons.arrow_downward),
          value: firstValue,
          iconSize: 24,
          elevation: 16,
          style: TextStyle(color: Colors.black),
          underline: Container(
            height: 1,
            color: Colors.black,
          ),
          items: categories.map<DropdownMenuItem<String>>((String value) {
            return DropdownMenuItem(value: value, child: Text(value));
          }).toList(),
          onChanged: (String value) {
            setState(() {
              firstValue = value;
            });
          },
        ),
      ]),
    );
  }

  Widget _btnSave() {
    return Container(
      //padding: EdgeInsets.all(20),
      // margin: EdgeInsets.only(bottom: 20),
      child: RaisedButton(
        child: Text(
          'Guardar',
          style: TextStyle(fontSize: 17),
        ),
        //padding: EdgeInsets.symmetric(vertical: 10, horizontal: 30),
        color: Color.fromRGBO(86, 226, 151, 1),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(10),
        ),
      ),
    );
  }
}
