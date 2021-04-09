import 'package:flutter/material.dart';
import 'package:budget_control/pages/home_page.dart';
import 'package:budget_control/model/modelCategories.dart';

class Catergories extends StatefulWidget {
  @override
  State<StatefulWidget> createState() => ManageCategories();
}

class ManageCategories extends State<Catergories> {
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
        _dataTableCategories(),
      ],
    );
  }

  Widget _btnReturn() {
    return Container(
        padding: EdgeInsets.all(15),
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
          "Administrar Categorías",
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
            labelText: 'Descripción Categoria *',
          ),
          keyboardType: TextInputType.text,
        ),
        TextFormField(
          decoration: const InputDecoration(
            border: UnderlineInputBorder(),
            filled: true,
            icon: Icon(Icons.description),
            labelText: 'Tope Categoria *',
          ),
          keyboardType: TextInputType.number,
        ),
        SizedBox(
          height: 25.0,
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

  Widget _dataTableCategories() {
    List<modelCategories> categ = fetchCategories();
    return DataTable(
      columns: const <DataColumn>[
        DataColumn(
          label: Text(
            'Descripción',
            style: TextStyle(fontStyle: FontStyle.italic),
          ),
        ),
        DataColumn(
          label: Text(
            'Tope',
            style: TextStyle(fontStyle: FontStyle.italic),
          ),
        ),
      ],
      rows: categ
          .map((modelCategories) => DataRow(
                cells: [
                  DataCell(
                    Text(
                      modelCategories.descripcion,
                    ),
                  ),
                  DataCell(
                    Text(
                      modelCategories.tope.toString(),
                    ),
                  ),
                ],
              ))
          .toList(),
    );
  }

  List<modelCategories> fetchCategories() {
    modelCategories mc = new modelCategories(50000, 'Ropa');
    modelCategories mc2 = new modelCategories(70000, 'Estudios');
    modelCategories mc3 = new modelCategories(30000, 'Entretenimiento');
    modelCategories mc4 = new modelCategories(60000, 'Facturas');
    var categories = <modelCategories>[];
    categories.add(mc);
    categories.add(mc2);
    categories.add(mc3);
    categories.add(mc4);

    return categories;
  }
}
