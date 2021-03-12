import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:high_chart/high_chart.dart';

class HomePage extends StatefulWidget {
  @override
  State<StatefulWidget> createState() => _CounterPage();
}

class _CounterPage extends State<HomePage> {
  String name = 'Elizabeth Gonzalez';
  String balance = '34000';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: _body(),
      bottomNavigationBar: _menu(),
      floatingActionButton: FloatingActionButton(
        onPressed: () {},
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
      children: [
        Container(
          padding: EdgeInsets.only(left: 30.0),
          width: 300,
          height: 150,
          decoration: BoxDecoration(
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
              Text('340.000'),
              Text('Eliza Pinguina')
            ],
          ),
        ),
        FloatingActionButton(
          onPressed: () {},
          backgroundColor: Colors.green,
          child: Icon(Icons.account_balance_wallet),
        )
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
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: <Widget>[
            IconButton(
              //update the bottom app bar view each time an item is clicked
              onPressed: () {},
              iconSize: 27.0,
              icon: Icon(
                Icons.home,
                //darken the icon if it is selected or else give it a different color
              ),
            ),
            IconButton(
              onPressed: () {},
              iconSize: 27.0,
              icon: Icon(
                Icons.call_made,
              ),
            ),
            //to leave space in between the bottom app bar items and below the FAB
            SizedBox(
              width: 50.0,
            ),
            IconButton(
              onPressed: () {},
              iconSize: 27.0,
              icon: Icon(
                Icons.call_received,
              ),
            ),
            IconButton(
              onPressed: () {},
              iconSize: 27.0,
              icon: Icon(
                Icons.settings,
              ),
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
