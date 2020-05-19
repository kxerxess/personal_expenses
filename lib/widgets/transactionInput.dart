import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class TransactionInput extends StatefulWidget {
  final Function addTx;

  TransactionInput(this.addTx);

  @override
  _TransactionInputState createState() => _TransactionInputState();
}

class _TransactionInputState extends State<TransactionInput> {
  final nameInputController = TextEditingController();
  final amountInputController = TextEditingController();
  DateTime _selectedDate;

  void submitData() {
    final enteredName = nameInputController.text;
    final enteredAmount = double.parse(amountInputController.text);

    if (enteredName.isEmpty || enteredAmount <= 0 || _selectedDate == null) {
      return;
    }

    widget.addTx(
      enteredName,
      enteredAmount,
      _selectedDate,
    );
    Navigator.of(context).pop();
  }

  void _presentDatePicker() {
    showDatePicker(
      context: context,
      initialDate: DateTime.now(),
      firstDate: DateTime(2019),
      lastDate: DateTime.now(),
    ).then((pickedDate) {
      if (pickedDate == null) {
        return;
      }
      setState(() {
        _selectedDate = pickedDate;
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      child: Card(
        elevation: 6,
        child: Container(
          padding: EdgeInsets.all(15),
          child: Column(
            children: <Widget>[
              TextField(
                decoration: InputDecoration(labelText: 'Name'),
                controller: nameInputController,
                onSubmitted: (_) => submitData(),
              ),
              TextField(
                decoration: InputDecoration(labelText: 'Amount'),
                controller: amountInputController,
                keyboardType: TextInputType.numberWithOptions(decimal: true),
                onSubmitted: (_) => submitData(),
              ),
              Row(
                children: <Widget>[
                  Container(
                    child: Text(_selectedDate == null
                        ? 'No Date Chosen!'
                        : 'Date: ${DateFormat.yMd().format(_selectedDate)}'),
                  ),
                  Container(
                    margin: EdgeInsets.all(10),
                    child: FlatButton(
                      color: Colors.black12,
                      onPressed: _presentDatePicker,
                      child: Text('Choose Date'),
                    ),
                  ),
                ],
              ),
              Container(
                alignment: Alignment.topRight,
                child: RaisedButton(
                  child: Text('Add Transaction'),
                  color: Theme.of(context).accentColor,
                  textColor: Colors.white,
                  onPressed: submitData,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
