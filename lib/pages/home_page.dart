import 'package:budget_control/pages/manageIncomes.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:high_chart/high_chart.dart';
import 'package:budget_control/pages/manageExpense.dart';
import 'package:budget_control/pages/manageCategories.dart';
import 'package:budget_control/pages/listItems.dart';

class HomePage extends StatefulWidget {
  @override
  State<StatefulWidget> createState() => _CounterPage();
}

class _CounterPage extends State<HomePage> {
  String name = 'Elizabeth Gonzalez';
  String balance = '100.000';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: _body(),
      bottomNavigationBar: _menu(),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          //Volver ir a la pantalla especificada
          Navigator.of(context)
              .push(MaterialPageRoute(builder: (context) => Expenses()));
        },
        backgroundColor: Colors.redAccent,
        child: Icon(Icons.money_off),
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
    );
  }

  Widget _body() {
    return Column(
      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
      children: <Widget>[
        _balance(),
        _chart(),
      ],
    );
  }

  Widget _balance() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceAround,
      children: [
        Padding(padding: EdgeInsets.all(3)),
        Container(
          padding: EdgeInsets.only(left: 40.0),
          width: 300,
          height: 150,
          decoration: BoxDecoration(
            image: DecorationImage(
              image: AssetImage('assets/background.jpg'),
            ),
            color: Colors.grey,
            borderRadius: BorderRadius.circular(20.0),
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Container(
                width: 30.0,
                height: 30.0,
                child: FaIcon(FontAwesomeIcons.ccVisa),
              ),
              Text(
                balance,
                style: TextStyle(
                    color: Colors.black,
                    fontSize: 17.0,
                    fontStyle: FontStyle.normal),
              ),
              Text(
                name,
                style: TextStyle(
                    color: Colors.black,
                    fontSize: 17.0,
                    fontStyle: FontStyle.normal),
              )
            ],
          ),
        ),
        FloatingActionButton(
          backgroundColor: Colors.green,
          child: Icon(Icons.account_balance_wallet),
          onPressed: () {
            //Volver ir a la pantalla especificada
            Navigator.of(context)
                .push(MaterialPageRoute(builder: (context) => Incomes()));
          },
        ),
      ],
    );
  }

  Widget _chart() {
    const _chart_data = '''{
      title: {
          text: ''
      },
      xAxis: {
          categories: ['Apples', 'Oranges', 'Pears', 'Bananas', 'Plums']
      },
      series: [{
          type: 'column',
          name: 'Jane',
          data: [3, 2, 1, 3, 4]
      }, {
          type: 'column',
          name: 'John',
          data: [2, 3, 5, 7, 6]
      }, {
          type: 'column',
          name: 'Joe',
          data: [4, 3, 3, 9, 0]
      }, {
          type: 'spline',
          name: 'Average',
          data: [3, 2.67, 3, 6.33, 3.33],
          marker: {
              lineWidth: 2,
              lineColor: Highcharts.getOptions().colors[3],
              fillColor: 'white'
          }
      }, 
    ]
    }''';

    return Container(
      child: HighCharts(
        data: _chart_data,
      ),
      width: 350,
      height: 350,
    );
  }

  Widget _menu() {
    return BottomAppBar(
      child: Container(
        margin: EdgeInsets.only(left: 12.0, right: 12.0),
        child: Row(
          mainAxisSize: MainAxisSize.max,
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: <Widget>[
            IconButton(
              //update the bottom app bar view each time an item is clicked
              iconSize: 27.0,
              icon: Icon(
                Icons.list,
                //darken the icon if it is selected or else give it a different color
              ),
              onPressed: () {
                //Volver ir a la pantalla especificada
                Navigator.of(context)
                    .push(MaterialPageRoute(builder: (context) => ListData()));
              },
            ),
            IconButton(
              iconSize: 27.0,
              icon: Icon(
                Icons.category_sharp,
              ),
              onPressed: () {
                //Volver ir a la pantalla especificada
                Navigator.of(context).push(
                    MaterialPageRoute(builder: (context) => Catergories()));
              },
            ),
          ],
        ),
      ),
      //to add a space between the FAB and BottomAppBar
      shape: CircularNotchedRectangle(),
      //color of the BottomAppBar
      color: Colors.white,
    );
  }
}
