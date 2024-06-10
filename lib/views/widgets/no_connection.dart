import 'package:flutter/material.dart';

class NoConnectionWidget extends StatelessWidget {

  const NoConnectionWidget({super.key});
  @override
  Widget build(BuildContext context) {
    return const Scaffold(
      body: Center(
        child:  Column(
          mainAxisSize: MainAxisSize.min,
          children: <Widget>[
            Icon(
              Icons.wifi_off,
              color: Colors.white,
              size: 50.0,
            ),
            SizedBox(height: 10.0),
            Text(
              "No Connection",
              style: TextStyle(
                color: Colors.white,
                fontSize: 20.0,
                fontWeight: FontWeight.bold,
              ),
            ),
            SizedBox(height: 5.0),
            Text(
              "Please check your internet connection",
              style: TextStyle(
                color: Colors.white,
                fontSize: 16.0,
              ),
              textAlign: TextAlign.center,
            ),
          ],
        ),
      ),
    );
  }
}