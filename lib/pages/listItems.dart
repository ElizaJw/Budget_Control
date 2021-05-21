import 'package:budget_control/Util/Utilities.dart';
import 'package:budget_control/styles/styleForm.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

class ListItems extends StatefulWidget {
  @override
  _ListData createState() => _ListData();
}

class _ListData extends State<ListItems> {
  CollectionReference coleccion =
      FirebaseFirestore.instance.collection('expense');

  StyleForm style = new StyleForm();
  Utilities util = new Utilities();
  PageController _controller;
  int currentPage = 9;

  @override
  void initState() {
    super.initState();

    _controller = PageController(
      initialPage: currentPage,
      viewportFraction: 0.4,
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: _body(),
    );
  }

  Widget _head() {
    return Container(
        child: Column(
      children: <Widget>[
        util.btnReturn(context),
        style.StyleTitle('Lista registros'),
        style.SizeSpace(20.0)
      ],
    ));
  }

  Widget _body() {
    return SafeArea(
      child: Column(
        children: <Widget>[
          // _selector(),
          //_expenses(),
          _head(),
          Container(
            color: Colors.blueAccent.withOpacity(0.15),
            height: 24.0,
          ),

          _list(),
        ],
      ),
    );
  }

  Widget _item(IconData icon, String name, int percent, double value) {
    return ListTile(
      leading: Icon(
        icon,
        size: 32.0,
      ),
      title: Text(
        name,
        style: TextStyle(fontWeight: FontWeight.bold, fontSize: 20.0),
      ),
      subtitle: Text(
        "$percent% of expenses",
        style: TextStyle(
          fontSize: 16.0,
          color: Colors.blueGrey,
        ),
      ),
      trailing: Container(
        decoration: BoxDecoration(
          color: Colors.blueAccent.withOpacity(0.2),
          borderRadius: BorderRadius.circular(5.0),
        ),
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Text(
            "\$$value",
            style: TextStyle(
              color: Colors.blueAccent,
              fontWeight: FontWeight.w500,
              fontSize: 16.0,
            ),
          ),
        ),
      ),
    );
  }

  Widget _list() {
    return Expanded(
      child: ListView.separated(
        itemCount: 10,
        itemBuilder: (BuildContext context, int index) =>
            _item(FontAwesomeIcons.shoppingCart, "Shopping", 14, 145.12),
        separatorBuilder: (BuildContext context, int index) {
          return Container(
            color: Colors.blueAccent.withOpacity(0.15),
            height: 8.0,
          );
        },
      ),
    );
  }
}
