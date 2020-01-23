import 'dart:math';
import 'dart:ui';
import 'package:vector_math/vector_math.dart' as math;

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
      home: Home2(),
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

class _HomeContentState extends State<HomeContent>
    with TickerProviderStateMixin {
  double percentage = 0;
  double newPercentage = 0;
  AnimationController controller;

  @override
  void initState() {
    super.initState();
    setState(() {
      percentage = 0;
    });

    controller =
        AnimationController(vsync: this, duration: Duration(milliseconds: 1000))
          ..addListener(() {
            setState(() {
              percentage =
                  lerpDouble(percentage, newPercentage, controller.value);
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
              width: 8.0),
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

class Home2 extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: <Widget>[
          Container(
            child: CustomPaint(
              child: Container(
                height: 300,
              ),
              painter: CurvePainter(),
            ),
          ),
          Center(
            child: RadialProgress(),
          )
        ],
      ),
    );
  }
}

class CurvePainter extends CustomPainter {
  @override
  void paint(Canvas canvas, Size size) {
    var paint = Paint();
    var path = Path();

    path.lineTo(0, size.height * 0.75);
    path.quadraticBezierTo(size.width * 0.10, size.height * 0.70,
        size.width * 0.17, size.height * 0.90);
    path.quadraticBezierTo(
        size.width * 0.20, size.height, size.width * 0.25, size.height * 0.90);
    path.quadraticBezierTo(size.width * 0.40, size.height * 0.40,
        size.width * 0.50, size.height * 0.70);
    path.quadraticBezierTo(size.width * 0.60, size.height * 0.85,
        size.width * 0.65, size.height * 0.65);
    path.quadraticBezierTo(
        size.width * 0.70, size.height * 0.90, size.width, 0);
    path.close();

    paint.color = Colors.deepPurple[100];
    canvas.drawPath(path, paint);

    path = Path();
    path.lineTo(0, size.height * 0.50);
    path.quadraticBezierTo(size.width * 0.10, size.height * 0.80,
        size.width * 0.15, size.height * 0.60);
    path.quadraticBezierTo(size.width * 0.20, size.height * 0.45,
        size.width * 0.27, size.height * 0.60);
    path.quadraticBezierTo(
        size.width * 0.45, size.height, size.width * 0.50, size.height * 0.80);
    path.quadraticBezierTo(size.width * 0.55, size.height * 0.45,
        size.width * 0.75, size.height * 0.75);
    path.quadraticBezierTo(
        size.width * 0.85, size.height * 0.93, size.width, size.height * 0.60);
    path.lineTo(size.width, 0);
    path.close();

    paint.color = Colors.deepPurple[200];
    canvas.drawPath(path, paint);

    path = Path();
    path.lineTo(0, size.height * 0.75);
    path.quadraticBezierTo(size.width * 0.10, size.height * 0.55,
        size.width * 0.22, size.height * 0.70);
    path.quadraticBezierTo(size.width * 0.30, size.height * 0.90,
        size.width * 0.40, size.height * 0.75);
    path.quadraticBezierTo(size.width * 0.52, size.height * 0.50,
        size.width * 0.65, size.height * 0.70);
    path.quadraticBezierTo(
        size.width * 0.75, size.height * 0.85, size.width, size.height * 0.60);
    path.lineTo(size.width, 0);
    path.close();

    paint.color = Colors.deepPurple;
    canvas.drawPath(path, paint);
  }

  @override
  bool shouldRepaint(CustomPainter oldDelegate) {
    return false;
  }
}

class MyPainter2 extends CustomPainter {
  @override
  void paint(Canvas canvas, Size size) {
    var paint = Paint()..color = Colors.red;

    paint.color = Colors.white;

    var rect = Rect.fromLTWH(0, 0, size.width, size.height);

    canvas.drawRect(rect, paint);

    paint.color = Colors.red;

    final center = Offset(size.width / 2, size.height / 2);

    final double radius = min(size.width / 2, size.height / 2);

    canvas.drawCircle(center, radius, paint);

    paint.color = Colors.blue;

    var path = Path();
    path.lineTo(0, size.height / 2);
    path.lineTo(size.width, 0);
    path.close();

    canvas.drawPath(path, paint);

    paint.color = Colors.yellow;

    path = Path();
    path.moveTo(size.width / 2, size.height / 2);
    path.lineTo(size.width, size.height);
    path.lineTo(size.width / 2, 0);
    path.close();

    canvas.drawPath(path, paint);
  }

  @override
  bool shouldRepaint(CustomPainter oldDelegate) {
    return false;
  }
}

class MyPainter extends CustomPainter {
  final Color lineColor;
  final Color completeColor;
  final double completePercent;
  final double width;

  const MyPainter(
      {this.lineColor, this.completeColor, this.completePercent, this.width});

  @override
  void paint(Canvas canvas, Size size) {
    final Paint line = Paint()
      ..color = lineColor
      ..strokeCap = StrokeCap.round
      ..style = PaintingStyle.stroke
      ..strokeWidth = width;

    final Paint complete = Paint()
      ..color = completeColor
      ..strokeCap = StrokeCap.round
      ..style = PaintingStyle.stroke
      ..strokeWidth = width;
    final Offset center = Offset(size.width / 2, size.height / 2);
    final double radius = min(size.width / 2, size.height / 2);

    canvas.drawCircle(center, radius, line);

    double arcAngle = 2 * pi * (completePercent / 100);

    canvas.drawArc(Rect.fromCircle(center: center, radius: radius), -pi / 2,
        arcAngle, false, complete);
  }

  @override
  bool shouldRepaint(CustomPainter oldDelegate) {
    return true;
  }
}

class RadialProgress extends StatefulWidget {
  final double goalCompleted = 0.7;

  @override
  _RadialProgressState createState() => _RadialProgressState();
}

class _RadialProgressState extends State<RadialProgress> with SingleTickerProviderStateMixin {

  AnimationController controller;
  Animation<double> progress; 

  double progressDegrees = 0;

  @override
  void initState() {
    super.initState();

    controller = AnimationController(vsync: this, duration: Duration(milliseconds: 800));
    progress = Tween<double>(begin: 0, end: 360).animate(CurvedAnimation(parent: controller, curve: Curves.decelerate))..addListener(() {
      setState(() {
        progressDegrees = widget.goalCompleted * controller.value;  
      });
      
    });

    controller.addStatusListener((status) {
      switch(status) {

        case AnimationStatus.dismissed:
          controller.forward();
          break;
        case AnimationStatus.forward:
          // TODO: Handle this case.
          break;
        case AnimationStatus.reverse:
          // TODO: Handle this case.
          break;
        case AnimationStatus.completed:
          controller.reverse();
          break;
      }
    });

    controller.forward();
  }

  @override
  Widget build(BuildContext context) {
    return CustomPaint(
      child: Container(
        height: 300,
      ),
      painter: RadialPainter(progress.value),
    );
  }
}

class RadialPainter extends CustomPainter {
  double progressInDegrees = 0;

  RadialPainter(this.progressInDegrees);

  @override
  void paint(Canvas canvas, Size size) {
    var paint = Paint()
      ..color = Colors.black12
      ..strokeCap = StrokeCap.round
      ..strokeWidth = 20
      ..style = PaintingStyle.stroke;

    final center = Offset(size.width / 2, size.height / 2);
    final radius = min(size.width / 2, size.height / 2);
    canvas.drawCircle(center, radius, paint);

    var progress = Paint()
         ..shader = LinearGradient(colors: [Colors.red, Colors.purple, Colors.purpleAccent]).createShader(Rect.fromCircle(center: center, radius: radius))
         ..strokeCap = StrokeCap.round
         ..strokeWidth = 20
         ..style = PaintingStyle.stroke;

    
    
    canvas.drawArc(Rect.fromCircle(center: center, radius:radius), math.radians(-90), math.radians(progressInDegrees), false, progress);
  }

  @override
  bool shouldRepaint(CustomPainter oldDelegate) {
    return true;
  }
}
