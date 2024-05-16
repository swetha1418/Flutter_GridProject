import 'dart:async';
import 'dart:math';

import 'package:flutter/material.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Grid_Project',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: GridProject(),
    );
  }
}

class GridProject extends StatefulWidget {
  @override
  _GridProjectState createState() => _GridProjectState();
}




class _GridProjectState extends State<GridProject> {
  String v1 = '0';
  String v2 = '0';
  String time = '';
  String prevV1 = '0';
  String prevV2 = '0';
  final random = Random();

  @override
  void initState() {
    super.initState();
    Timer.periodic(Duration(seconds: 1), (timer) {
      updateTime();
    });
  }

  void updateValueA() {
    setState(() {
      prevV1 = v1;
      v1 = generateRandomNumber(90, 100).toString();
    });
  }

  void updateValueB() {
    setState(() {
      prevV2 = v2;
      v2 = generateRandomNumber(90, 100).toString();
    });
  }

  void updateTime() {
    setState(() {
      time = DateTime.now().toString();
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Grid_Project'),
        titleTextStyle:
            TextStyle(fontSize: 24, fontFamily: AutofillHints.birthday),
        centerTitle: true,
      ),
      body: GridView.count(
        crossAxisCount: 3,
        children: [
          GestureDetector(
            onTap: updateValueA,
            child: GridItem(
              label: 'A',
              value: v1,
              compareValue: prevV1,
            ),
          ),
          GestureDetector(
            onTap: updateValueB,
            child: GridItem(
              label: 'B',
              value: v2,
              compareValue: prevV2,
            ),
          ),
          GridItem(
            label: 'C',
            value: time,
            isTime: true,
          ),
        ],
      ),
    );
  }
}

class GridItem extends StatelessWidget {
  final String label;
  final String value;
  final String compareValue;
  final bool isTime;

  GridItem({
    required this.label,
    required this.value,
    this.compareValue = '',
    this.isTime = false,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        CircleAvatar(
          backgroundColor: Colors.orange,
          child: Text(
            label,
            style: TextStyle(color: Colors.white),
          ),
        ),
        SizedBox(height: 10),
        Text(
          value,
          style: TextStyle(
            color:
                isTime ? Colors.black : determineTextColor(compareValue, value),
          ),
        ),
      ],
    );
  }
}

int generateRandomNumber(int min, int max) {
  final random = Random();
  return min + random.nextInt(max - min + 1);
}

Color determineTextColor(String previousValue, String currentValue) {
  final prev = double.parse(previousValue);
  final current = double.parse(currentValue);
  return current > prev ? Colors.green : Colors.red;
}
