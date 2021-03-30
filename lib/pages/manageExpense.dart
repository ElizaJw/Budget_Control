import 'package:flutter/material.dart';
import 'package:budget_control/pages/home_page.dart';

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
        SizedBox(
          height: 15.0,
        ),
        DropdownButton<String>(
          isExpanded: true,
          icon: Icon(Icons.arrow_downward),
          value: firstValue,
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
              firstValue = value;
            });
          },
        ),
        SizedBox(
          height: 20.0,
        ),
        MaterialButton(
          minWidth: 150.0,
          height: 40.0,
          onPressed: () {},
          color: Colors.lightBlue,
          child: Text('Registrar', style: TextStyle(color: Colors.black)),
        ),
      ]),
    );
  }
}
