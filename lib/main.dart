import 'dart:math';
import 'dart:ui';

import 'package:flutter/material.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: Home(),
    );
  }
}

class Home extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text("Custom Painter"),
        ),
        body: HomeContent());
  }
}

class HomeContent extends StatefulWidget {
  @override
  _HomeContentState createState() => _HomeContentState();
}

class _HomeContentState extends State<HomeContent> with TickerProviderStateMixin {
  double percentage = 0;
  double newPercentage = 0;
  AnimationController controller;

  @override
  void initState() {
    super.initState();
    setState(() {
      percentage = 0;
    });

    controller = AnimationController(vsync: this, duration: Duration(milliseconds: 1000))..addListener((){
      setState((){
        percentage = lerpDouble(percentage, newPercentage, controller.value);
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Container(
        height: 200,
        width: 200,
        child: CustomPaint(
          foregroundPainter: new MyPainter(
              lineColor: Colors.amber,
              completeColor: Colors.blueAccent,
              completePercent: percentage,
              width: 8.0
          ),
          child: Padding(
            padding: EdgeInsets.all(8.0),
            child: RaisedButton(
              color: Colors.purple,
              splashColor: Colors.blueAccent,
              shape: CircleBorder(),
              child: Text("Click ME"),
              onPressed: () {
                setState(() {
                  percentage = newPercentage;
                  newPercentage += 10;
                  if (newPercentage > 100) {
                    percentage = 0;
                    newPercentage = 0;
                  }
                  controller.forward(from: 0);
                });
              },
            ),
          ),
        ),
      ),
    );
  }
}

class MyPainter extends CustomPainter {

  final Color lineColor;
  final Color completeColor;
  final double completePercent;
  final double width;

  const MyPainter({this.lineColor, this.completeColor, this.completePercent, this.width});

  @override
  void paint(Canvas canvas, Size size) {
    final Paint line = Paint()..color = lineColor
                        ..strokeCap = StrokeCap.round
                        ..style = PaintingStyle.stroke
                        ..strokeWidth = width;

    final Paint complete = Paint()..color = completeColor
                                  ..strokeCap = StrokeCap.round
                                  ..style = PaintingStyle.stroke
                                  ..strokeWidth = width;
    final Offset center = Offset(size.width / 2, size.height / 2);
    final double radius = min(size.width / 2, size.height / 2);
    
    canvas.drawCircle(center, radius, line);

    double arcAngle = 2 * pi * (completePercent / 100);

    canvas.drawArc(Rect.fromCircle(center: center, radius: radius), -pi/2, arcAngle, false, complete);
  }

  @override
  bool shouldRepaint(CustomPainter oldDelegate) {
    return true;
  }

}