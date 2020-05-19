import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:personal_expenses/models/transactions.dart';
import './chartBar.dart';

class Chart extends StatelessWidget {
  final List<Transactions> recentTransactions;
  const Chart(this.recentTransactions);

  List<Map<String, Object>> get groupedTransactions {
    return List.generate(7, (index) {
      final weekDay = DateTime.now().subtract(
        Duration(days: index),
      );

      var dayTotalAmt = 0.0;

      for (var i = 0; i < recentTransactions.length; i++) {
        if (recentTransactions[i].txDate.day == weekDay.day &&
            recentTransactions[i].txDate.month == weekDay.month &&
            recentTransactions[i].txDate.year == weekDay.year) {
          dayTotalAmt += recentTransactions[i].txAmt;
        }
      }

      return {
        'day': DateFormat.E().format(weekDay).substring(0, 1),
        'amount': dayTotalAmt,
      };
    }).reversed.toList();
  }

  double get weekTotalAmt {
    return groupedTransactions.fold(0.0, (sum, item) {
      return sum + item['amount'];
    });
  }

  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 2,
      margin: EdgeInsets.all(15),
      child: Column(
        children: <Widget>[
          Container(
            child: Text(
              'This Week:',
              style: TextStyle(
                fontWeight: FontWeight.bold,
                color: Theme.of(context).accentColor,
                fontSize: 25
              ),
            ),
          ),
          SizedBox(
          height: 8,
        ),
          Container(
            padding: EdgeInsets.all(10),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: groupedTransactions.map((data) {
                return Flexible(
                  fit: FlexFit.tight,
                  child: ChartBar(
                    data,
                    weekTotalAmt != 0
                        ? (data['amount'] as double) / weekTotalAmt
                        : 0.0,
                  ),
                );
              }).toList(),
            ),
          ),
        ],
      ),
    );
  }
}
