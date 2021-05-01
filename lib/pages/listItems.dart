import 'package:flutter/material.dart';
import 'package:budget_control/pages/home_page.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:date_field/date_field.dart';
import 'package:budget_control/Util/Utilities.dart';

class ListData extends StatefulWidget {
  @override
  State<StatefulWidget> createState() => ListAllItems();
}

class ListAllItems extends State<ListData> {
  Utilities util = new Utilities();

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
        _list(),
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

  Widget _list() {
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 10),
      child: Column(children: <Widget>[
        SizedBox(
          height: 20.0,
        ),
        Text(
          "Datos ingresados",
          textAlign: TextAlign.center,
          style: TextStyle(
              color: Colors.blue, fontSize: 20.0, fontStyle: FontStyle.normal),
        ),
        ListView(children: [
          _buildItem('Primer elemento!'),
          _buildItem('Segundo elemento!'),
          _buildItem('Tercer elemento!'),
          _buildItem('Cuarto elemento!')
        ])
      ]),
    );
  }

  Widget _buildItem(String textTitle) {
    return new ListTile(
      title: new Text(textTitle),
      subtitle: new Text('Subtitulo ejemplo'),
      leading: new Icon(Icons.map),
    );
  }
}
