import 'package:flutter/material.dart';

class LoggerScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Logger Screen'),
      ),
      body: Center(
        child: Text('This is the Logger Screen'),
      ),
    );
  }
}