import 'package:flutter/material.dart';

import 'package:shipanther/screens/home.dart';
import 'package:shipanther/screens/terminal/terminalScreen.dart';

class SuperAdminHomePage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Welcome Super Admin'),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            RaisedButton(
                child: Text('Tenents'),
                onPressed: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(builder: (context) => Home()),
                  );
                }),
            SizedBox(
              height: 20,
            ),
            RaisedButton(
                child: Text('Terminals'),
                onPressed: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(builder: (context) => TerminalScreen()),
                  );
                }),
          ],
        ),
      ),
    );
  }
}
