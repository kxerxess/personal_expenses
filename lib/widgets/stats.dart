import 'package:flutter/material.dart';

class Statistics extends StatelessWidget {
  static const routeName = '/statistics';
  const Statistics({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Text('Stats'),
      ),
    );
  }
}
