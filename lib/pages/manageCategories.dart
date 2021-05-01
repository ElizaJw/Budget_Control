import 'package:budget_control/Util/Utilities.dart';
import 'package:budget_control/model/ModelCategories.dart';
import 'package:flutter/material.dart';
import 'package:budget_control/pages/home_page.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:budget_control/styles/styleForm.dart';

class Catergories extends StatefulWidget {
  @override
  State<StatefulWidget> createState() => ManageCategories();
}

class ManageCategories extends State<Catergories> {
  StyleForm style = new StyleForm();
  var _descripcion = "";
  var _tope = "";
  Utilities util = new Utilities();
  final _keyForm = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color.fromRGBO(239, 240, 236, 3),
      body: SingleChildScrollView(child: _body()),
    );
  }

  Widget _body() {
    return Column(
      children: <Widget>[
        btnReturn(),
        _formCategories(),
        _dataTableCategories(),
      ],
    );
  }

  Widget btnReturn() {
    return Container(
        padding: EdgeInsets.all(15),
        alignment: Alignment.bottomLeft,
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

  Widget _formCategories() {
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 10),
      child: Form(
        key: _keyForm,
        child: Column(children: <Widget>[
          style.SizeSpace(20.0),
          style.StyleTitle('Administrar Categorías'),
          style.SizeSpace(20.0),
          TextFormField(
              controller: TextEditingController(text: _descripcion.toString()),
              validator: (value) {
                if (value.isEmpty || null == value) {
                  return 'La descripción no puede estar vacia.';
                }
              },
              decoration: style.StyleInput('Descripción Categoría *',
                  'Ingresa la descripción', Icon(Icons.description)),
              keyboardType: TextInputType.text,
              onChanged: (String valor) async {
                _descripcion = valor;
                print(
                    "El valor del campo [Descripción Categoria] es: $_descripcion ...");
              }),
          TextFormField(
              controller: TextEditingController(text: _tope.toString()),
              validator: (value) {
                if (value.isEmpty || null == value) {
                  return 'El Tope no puede estar vacio.';
                }
              },
              decoration: style.StyleInput('Tope Categoría *',
                  'I¿Cuánto será el tope?', Icon(Icons.confirmation_number)),
              keyboardType: TextInputType.number,
              onChanged: (String valor) async {
                _tope = valor;
                print("El valor del campo [Tope Categoria] es: $_tope ...");
              }),
          style.SizeSpace(25.0),
          MaterialButton(
            minWidth: 150.0,
            height: 40.0,
            onPressed: () {
              if (_keyForm.currentState.validate()) {
                util.showWindowDialog(context,
                    titulo: "Datos Ingresados",
                    mensaje:
                        "Descripción: $_descripcion \nTope Categoria: $_tope",
                    boton: "Ok");
                _addCategory();
              }
            },
            color: Colors.lightBlue,
            child: Text('Registrar', style: TextStyle(color: Colors.black)),
          ),
        ]),
      ),
    );
  }

  Future<void> _addCategory() {
    CollectionReference coleccion =
        FirebaseFirestore.instance.collection('Categories');
    return coleccion
        .add({'descripcion': this._descripcion, 'tope': this._tope})
        .then((value) => util.showToast(context,
            mensaje: 'Datos adicionados con éxito', boton: 'Ok'))
        .catchError((error) =>
            util.showToast(context, mensaje: 'Error: $error', boton: 'Ok'));
  }

  Widget _dataTableCategories() {
    return StreamBuilder<QuerySnapshot>(
      stream: FirebaseFirestore.instance.collection('Categories').snapshots(),
      builder: (context, snapshot) {
        if (!snapshot.hasData) return LinearProgressIndicator();

        return DataTable(columns: [
          DataColumn(
              label: Text('Descripción',
                  style: TextStyle(fontStyle: FontStyle.italic))),
          DataColumn(
              label:
                  Text('Tope', style: TextStyle(fontStyle: FontStyle.italic)))
        ], rows: _buildList(context, snapshot.data.docs));
      },
    );
  }

  List<DataRow> _buildList(
      BuildContext context, List<DocumentSnapshot> snapshot) {
    return snapshot.map((data) => _buildListItem(context, data)).toList();
  }

  DataRow _buildListItem(BuildContext context, DocumentSnapshot data) {
    final records = ModelCategories.fromSnapshot(data);

    return DataRow(cells: [
      DataCell(Text(records.descripcion)),
      DataCell(Text(records.tope))
    ]);
  }
}
