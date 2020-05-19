import 'package:flutter/material.dart';
import 'package:personal_expenses/models/transactions.dart';

class Summary extends StatefulWidget {
  final List<Transactions> txs;
  const Summary(this.txs);

  @override
  _SummaryState createState() => _SummaryState();
}

class _SummaryState extends State<Summary> {
  String dropDownValue = 'Monthly';
  List<DropdownMenuItem<String>> _items = <String>[
    'Monthly',
    'Weekly',
    'Yearly',
    'All'
  ].map<DropdownMenuItem<String>>((String value) {
    return DropdownMenuItem<String>(
      value: value,
      child: Text(value),
    );
  }).toList();

  double totalSum = 0.0;

  double generateTotalSpending(range) {
    totalSum = 0.0;
    print('total 0');
    switch (range) {
      case 'Monthly':
        {
          for (var i = 0; i < widget.txs.length; i++) {
            if (widget.txs[i].txDate.month == DateTime.now().month) {
              totalSum += widget.txs[i].txAmt;
            }
          }
          break;
        }
      case 'Yearly':
        {
          for (var i = 0; i < widget.txs.length; i++) {
            if (widget.txs[i].txDate.year == DateTime.now().year) {
              totalSum += widget.txs[i].txAmt;
            }
          }
          break;
        }
      case 'Weekly':
        {
          for (var i = 0; i < widget.txs.length; i++) {
            if (DateTime.now().day - widget.txs[i].txDate.day <= 7 &&
                widget.txs[i].txDate.month == DateTime.now().month &&
                widget.txs[i].txDate.year == DateTime.now().year) {
              totalSum += widget.txs[i].txAmt;
            }
          }
          break;
        }
      case 'All':
        {
          for (var i = 0; i < widget.txs.length; i++) {
            totalSum += widget.txs[i].txAmt;
          }
        }
        break;
    }
    print('total calculated');
    return totalSum;
  }

  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 2,
      margin: EdgeInsets.only(left: 15, right: 15),
      child: Column(
        children: <Widget>[
          Row(
            children: <Widget>[
              Container(
                padding: EdgeInsets.all(15),
                child: Text(
                  'Summary:',
                  style: TextStyle(
                    fontSize: 20,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
              Container(
                padding: EdgeInsets.all(10),
                child: DropdownButton(
                    underline: Container(
                      height: 2,
                      color: Theme.of(context).accentColor,
                    ),
                    value: dropDownValue,
                    items: _items,
                    onChanged: (String value) {
                      setState(() {
                        dropDownValue = value;
                        totalSum = 0.0;
                      });
                    }),
              )
            ],
          ),
          Column(
            children: <Widget>[
              Container(
                alignment: Alignment.topLeft,
                padding: EdgeInsets.all(10),
                margin: EdgeInsets.only(left: 5),
                child: Text(
                  'Total Amount Spent: ${generateTotalSpending(dropDownValue).toStringAsFixed(0)}',
                  style: TextStyle(
                    fontSize: 18,
                    fontWeight: FontWeight.w600,
                  ),
                ),
              ),
              Container(
                alignment: Alignment.topLeft,
                padding: EdgeInsets.all(10),
                margin: EdgeInsets.only(left: 5),
                child: Text(
                  'Total Savings: ',
                  style: TextStyle(
                    color: Colors.green,
                    fontSize: 18,
                    fontWeight: FontWeight.w600,
                  ),
                ),
              )
            ],
          ),
        ],
      ),
    );
  }
}
