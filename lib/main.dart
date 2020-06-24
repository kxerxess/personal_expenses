import 'package:flutter/material.dart';
import 'package:personal_expenses/widgets/chart.dart';
import 'package:personal_expenses/widgets/summary.dart';
import 'package:personal_expenses/widgets/transactionInput.dart';
import './widgets/transactionList.dart';
import './models/transactions.dart';
import './widgets/stats.dart';

void main() => runApp(Expense());

class Expense extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: "Expense Manager",
      theme: ThemeData(
        primarySwatch: Colors.red,
      ),
      home: HomePage(),
      routes: {
        Statistics.routeName: (ctx) => Statistics(),
      },
    );
  }
}

class HomePage extends StatefulWidget {
  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  final List<Transactions> _txs = [
    Transactions(
        txId: '001', txName: 'Shoes', txAmt: 20.0, txDate: DateTime.now()),
    Transactions(
        txId: '002', txName: 'Phone cover', txAmt: 10.0, txDate: DateTime.now())
  ];

  List<Transactions> get _recentTransactions {
    return _txs.where((tx) {
      return tx.txDate.isAfter(
        DateTime.now().subtract(
          Duration(days: 7),
        ),
      );
    }).toList();
  }

  void _addTx(String name, double amount, DateTime selectedDate) {
    final newTx = Transactions(
      txName: name,
      txAmt: amount,
      txDate: selectedDate,
      txId: DateTime.now(),
    );

    setState(() {
      _txs.add(newTx);
    });
  }

  void _startAddTx(BuildContext ctx) {
    showModalBottomSheet(
        context: ctx,
        builder: (_) {
          return GestureDetector(
            onTap: () {},
            child: TransactionInput(_addTx),
            behavior: HitTestBehavior.opaque,
          );
        });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Expense Manager'),
        actions: <Widget>[
          IconButton(
            icon: Icon(Icons.add),
            onPressed: () => _startAddTx(context),
          ),
        ],
      ),
      body: SingleChildScrollView(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          children: <Widget>[
            Chart(_recentTransactions),
            Summary(_txs),
            TransactionsList(_txs),
            RaisedButton(
              child: Text('Press'),
              onPressed: () {
                Navigator.of(context).pushNamed(Statistics.routeName);
              },
            )
          ],
        ),
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
      floatingActionButton: FloatingActionButton(
        child: Icon(Icons.add),
        onPressed: () => _startAddTx(context),
      ),
    );
  }
}
