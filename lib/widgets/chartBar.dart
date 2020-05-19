import 'package:flutter/material.dart';

class ChartBar extends StatelessWidget {
  final data;
  final amountPercent;
  const ChartBar(this.data, this.amountPercent);

  @override
  Widget build(BuildContext context) {
    return Column(
      children: <Widget>[
        Container(
          height: 20,
          child: FittedBox(
            child: Text(
              '₹${data['amount'].toStringAsFixed(0)}',
            ),
          ),
        ),
        SizedBox(
          height: 8,
        ),
        Container(
          height: 80,
          width: 15,
          child: Stack(
            children: <Widget>[
              Container(
                decoration: BoxDecoration(
                  border: Border.all(color: Colors.black12, width: 1),
                  color: Colors.black12,
                  borderRadius: BorderRadius.circular(10),
                ),
              ),
              Container(
                alignment: Alignment.bottomCenter,
                child: FractionallySizedBox(
                  heightFactor: amountPercent,
                  child: Container(
                    decoration: BoxDecoration(
                      color: Theme.of(context).accentColor,
                      borderRadius: BorderRadius.circular(10),
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
        SizedBox(
          height: 8,
        ),
        Text(data['day']),
      ],
    );
  }
}
