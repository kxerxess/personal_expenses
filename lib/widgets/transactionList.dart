import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:personal_expenses/models/transactions.dart';

class TransactionsList extends StatelessWidget {
  final List<Transactions> txs;
  const TransactionsList(this.txs);

  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 2,
      margin: EdgeInsets.all(15),
          child: Column(
        children: <Widget>[
          Container(
            padding: EdgeInsets.all(10),
            width: double.infinity,
            child: Text(
              'Transaction History:',
              textAlign: TextAlign.start,
              style: TextStyle(
                fontSize: 20,
                fontWeight: FontWeight.bold,
              ),
            ),
          ),
          Container(
            height: 240,
            width: double.infinity,
            child: ListView.builder(
              itemBuilder: (ctx, index) {
                return ListTile(
                    leading: Column(
                      children: <Widget>[
                        SizedBox(
                          height: 15,
                        ),
                        Text(
                          '₹${txs[index].txAmt.toStringAsFixed(0)}',
                          style: TextStyle(
                            color: Theme.of(context).accentColor,
                            fontSize: 18,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ],
                    ),
                    title: Text(
                      '${txs[index].txName}',
                      style: TextStyle(fontWeight: FontWeight.bold),
                    ),
                    subtitle: Text(
                      DateFormat.yMMMd().format(txs[index].txDate),
                    ),
                  );
              },
              itemCount: txs.length,
            ),
          ),
        ],
      ),
    );
  }
}
