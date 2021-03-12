import 'package:flutter/material.dart';
import 'package:high_chart/high_chart.dart';
import 'package:credit_card/flutter_credit_card.dart';
import 'package:credit_card/credit_card_form.dart';
import 'package:credit_card/credit_card_model.dart';

class HomePage extends StatefulWidget {
  @override
  State<StatefulWidget> createState() => _CounterPage();
}

class _CounterPage extends State<HomePage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: _appBar(),
      body: SingleChildScrollView(
        child: _body(),
      ),
      floatingActionButton: _menu(),
    );
  }

  Widget _appBar() {
    return AppBar(
      backgroundColor: Color.fromRGBO(12, 90, 190, 1),
      toolbarHeight: 80,
      actions: <Widget>[
        IconButton(
          icon: const Icon(Icons.settings),
          onPressed: () => {},
        ),
      ],
      centerTitle: false,
      title: Text('CONTROL BUDGET'),
    );
  }

  Widget _body() {
    return Column(
      children: <Widget>[
        Container(
          // color: Color.fromRGBO(251, 234, 206, 1),
          child: Column(
            children: [
              _balance(),
              _group(),
              _chart(),
            ],
          ),
        ),
      ],
    );
  }

  Widget _balance() {
    /*return Image(
      image: AssetImage('assets/tarjeta.png'),
      width: 250.0,
    );*/
    return Container(
      width: 300,
      height: 50,
      child: Row(
        children: <Widget>[
          CreditCardWidget(
            cardNumber: balance,
            expiryDate: '',
            cardHolderName: '',
            cvvCode: '',
            showBackView: false,
          ),
          Expanded(
            child: SingleChildScrollView(
              child: CreditCardForm(
                onCreditCardModelChange: onCreditCardModelChange,
              ),
            ),
          )
        ],
      ),
    );
  }

  Widget _group() {
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 28),
      margin: EdgeInsets.symmetric(vertical: 20),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        children: [
          // _balance(),
          FloatingActionButton(
              onPressed: () {},
              backgroundColor: Colors.green,
              child: Icon(Icons.account_balance_wallet)),
        ],
      ),
    );
  }

  Widget _chart() {
    return Image(
      image: AssetImage('assets/chart.png'),
      width: 250.0,
    );
    /* return Container(
      child: HighCharts(
        data: _chart_data,
      ),
    );*/
  }

  void onCreditCardModelChange(CreditCardModel creditCardModel) {
    setState(() {
      name = creditCardModel.cardHolderName;
      balance = creditCardModel.cardNumber;
    });
  }

  String name = 'Elizabeth Gonzalez';
  String balance = '34000';

  Widget _menu() {
    return Container(
      //color: Colors.pink,
      height: 60,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        children: <Widget>[
          FloatingActionButton(
              onPressed: () {},
              backgroundColor: Colors.blue,
              child: Icon(Icons.archive)),
          FloatingActionButton(
              onPressed: () {},
              backgroundColor: Colors.red,
              child: Icon(Icons.money_off)),
          FloatingActionButton(
              onPressed: () {},
              backgroundColor: Colors.purple,
              child: Icon(Icons.list)),
        ],
      ),
    );
  }

  static const _chart_data = '''{
      title: {
          text: 'Combination chart'
      },
      xAxis: {
          categories: ['Apples', 'Oranges', 'Pears', 'Bananas', 'Plums']
      },
      series: [{
          type: 'pie',
          name: 'Total consumption',
          data: [{
              name: 'Jane',
              y: 13,
              color: Highcharts.getOptions().colors[0] // Jane's color
          }, {
              name: 'John',
              y: 23,
              color: Highcharts.getOptions().colors[1] // John's color
          }, {
              name: 'Joe',
              y: 19,
              color: Highcharts.getOptions().colors[2] // Joe's color
          }],
          center: [100, 80],
          size: 100,
          showInLegend: false,
          dataLabels: {
              enabled: false
          }
        }]
    }''';
}
